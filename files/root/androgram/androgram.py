import logging
import configparser
import subprocess
import os
import sys
import time
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup, ReplyKeyboardMarkup, KeyboardButton, ReplyKeyboardRemove
from telegram.ext import ApplicationBuilder, ContextTypes, CommandHandler, MessageHandler, filters, CallbackQueryHandler
from telegram.constants import ParseMode
from telegram.error import NetworkError, TelegramError

# Enable logging
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)

# Load configuration
config = configparser.ConfigParser()
config.read('/root/androgram/config.ini')
token = config['telegram']['token']
allowed_users = [int(uid) for uid in config['telegram']['allowed_users'].split(',')]
device_names = {key: value for key, value in config['devices'].items()}
sms_display_limit = int(config['settings'].get('sms_limit', 5))

# Define state constants
EDITING_DEVICE_NAMES = 'editing_device_names'
SETTING_SMS_LIMIT = 'setting_sms_limit'
CONFIRM_REFRESH_HP = 'confirm_refresh_hp'

# Define state storage
user_states = {}

def load_device_names():
    """Load device names from the configuration file."""
    global config, device_names
    config.read('/root/androgram/config.ini')  # Re-read the configuration file
    device_names = {key: value for key, value in config['devices'].items()}

def run_shell_script(script_path: str, device: str = None) -> str:
    """Run the shell script and return its output."""
    try:
        command = [script_path]
        if device:
            command.append(device)
        result = subprocess.run(command, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        return f"An error occurred while running the script: {e.stderr}"

def get_adb_devices() -> list:
    """Run adb devices command and return list of devices."""
    try:
        result = subprocess.run(['adb', 'devices'], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        lines = result.stdout.splitlines()
        devices = [line.split()[0] for line in lines[1:] if line]
        return devices
    except subprocess.CalledProcessError as e:
        logger.error(f"An error occurred while running adb: {e.stderr}")
        return []

def is_user_allowed(user_id: int) -> bool:
    return user_id in allowed_users

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Send a message when the command 'start' is issued."""
    await update.message.reply_text('Hi! This is the start command.', disable_web_page_preview=True)
    await show_main_menu(update)

async def help_command(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Send a message when the command 'help' is issued."""
    await update.message.reply_text('Help! This is the help command.', disable_web_page_preview=True)

async def restart(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Restart the bot and reload device names."""
    message = await update.message.reply_text("Restarting bot...", disable_web_page_preview=True)
    load_device_names()  # Refresh device names before stopping the application
    await message.edit_text("Success...", disable_web_page_preview=True)
    os.execl(sys.executable, sys.executable, *sys.argv)  # Restart the application

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Handle non-slash commands."""
    user_id = update.message.from_user.id
    text = update.message.text.lower()

    if user_id in user_states:
        state = user_states[user_id]
        if state == EDITING_DEVICE_NAMES:
            # Handle device name editing
            new_name = update.message.text
            device_serial = user_states.get(f'{user_id}_device')
            if device_serial in device_names:
                device_names[device_serial] = new_name
                config.set('devices', device_serial, new_name)
                with open('/root/androgram/config.ini', 'w') as configfile:
                    config.write(configfile)
                await update.message.reply_text(f"Device name updated to {new_name}.", reply_markup=ReplyKeyboardRemove())
            else:
                await update.message.reply_text("Device not found.", reply_markup=ReplyKeyboardRemove())
            del user_states[user_id]
            # Show main menu after updating
            await show_main_menu(update)
            return

        if state == SETTING_SMS_LIMIT:
            # Handle SMS limit setting
            try:
                limit = int(text)
                config.set('settings', 'sms_limit', str(limit))
                with open('/root/androgram/config.ini', 'w') as configfile:
                    config.write(configfile)
                global sms_display_limit
                sms_display_limit = limit
                await update.message.reply_text(f"SMS display limit set to {limit}.", reply_markup=ReplyKeyboardRemove())
            except ValueError:
                await update.message.reply_text("Invalid number. Please enter a valid integer.", reply_markup=ReplyKeyboardRemove())
            del user_states[user_id]
            # Show main menu after updating
            await show_main_menu(update)
            return

    if not is_user_allowed(user_id):
        await update.message.reply_text("You are not authorized to use this bot.", disable_web_page_preview=True)
        return

    if text == 'start':
        await start(update, context)
    elif text == 'help':
        await help_command(update, context)
    elif text == 'androgram':
        await show_main_menu(update)
    elif text == 'ip remote':
        message = await update.message.reply_text("Command is being executed...", disable_web_page_preview=True)
        script_output = run_shell_script('/root/androgram/core/ipremote.sh')
        await message.edit_text(f"{script_output}", parse_mode=ParseMode.HTML, disable_web_page_preview=True)
    elif text == 'sms':
        devices = get_adb_devices()
        if devices:
            keyboard = [
                [InlineKeyboardButton(device_names.get(device, device), callback_data=f'sms.sh {device}')]
                for device in devices
            ]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text('Select a device to run the SMS script:', reply_markup=reply_markup, disable_web_page_preview=True)
        else:
            await update.message.reply_text("No devices found or an error occurred.", disable_web_page_preview=True)
    elif text == 'refresh hp':
        devices = get_adb_devices()
        if devices:
            keyboard = [
                [InlineKeyboardButton(device_names.get(device, device), callback_data=f'select_device_for_refresh {device}')]
                for device in devices
            ]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text('Select a device and confirm to run the refresh HP script:', reply_markup=reply_markup, disable_web_page_preview=True)
        else:
            await update.message.reply_text("No devices found or an error occurred.", disable_web_page_preview=True)
    elif text == 'restart bot':
        await restart(update, context)
    elif text == 'settings':
        keyboard = [
            [KeyboardButton("Edit Device Names")],
            [KeyboardButton("Set SMS Display Limit")],
            [KeyboardButton("Main Menu")]
        ]
        reply_markup = ReplyKeyboardMarkup(keyboard, resize_keyboard=True)
        await update.message.reply_text('Settings menu:', reply_markup=reply_markup)
    elif text == 'edit device names':
        devices = get_adb_devices()
        if devices:
            keyboard = [
                [InlineKeyboardButton(device_names.get(device, device), callback_data=f'select_device_for_edit {device}')]
                for device in devices
            ]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text('Select a device to edit its name:', reply_markup=reply_markup, disable_web_page_preview=True)
        else:
            await update.message.reply_text("No devices found or an error occurred.", disable_web_page_preview=True)
    elif text == 'set sms display limit':
        user_states[user_id] = SETTING_SMS_LIMIT
        await update.message.reply_text(f"Current SMS display limit is {sms_display_limit}. Please enter the new limit.", reply_markup=ReplyKeyboardRemove())
    elif text == 'main menu':
        await show_main_menu(update)
    elif text == 'info hp':
        devices = get_adb_devices()
        if devices:
            keyboard = [
                [InlineKeyboardButton(device_names.get(device, device), callback_data=f'infohp.sh {device}')]
                for device in devices
            ]
            reply_markup = InlineKeyboardMarkup(keyboard)
            await update.message.reply_text('Select a device to run the Info HP script:', reply_markup=reply_markup, disable_web_page_preview=True)
        else:
            await update.message.reply_text("No devices found or an error occurred.", disable_web_page_preview=True)
    else:
        await update.message.reply_text(f"Unrecognized command: {text}", disable_web_page_preview=True)

async def button(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    """Handle button presses."""
    query = update.callback_query
    await query.answer()

    callback_data = query.data.split()
    action = callback_data[0]
    
    if action == 'select_device_for_edit':
        device = callback_data[1]
        user_states[query.from_user.id] = EDITING_DEVICE_NAMES
        user_states[f'{query.from_user.id}_device'] = device
        await query.edit_message_text(text=f"Selected device: {device_names.get(device, device)}. Please send the new name for this device.", disable_web_page_preview=True)
    elif action == 'select_device_for_refresh':
        device = callback_data[1]
        keyboard = [
            [InlineKeyboardButton("Yes", callback_data=f'confirm_refresh_hp {device}')],
            [InlineKeyboardButton("No", callback_data='cancel_refresh_hp')]
        ]
        reply_markup = InlineKeyboardMarkup(keyboard)
        await query.edit_message_text(text=f"Are you sure you want to run the refresh HP script on device {device_names.get(device, device)}?", reply_markup=reply_markup, disable_web_page_preview=True)
    elif action == 'confirm_refresh_hp':
        device = callback_data[1]
        await query.edit_message_text(text="Command is being executed...", disable_web_page_preview=True)
        
        script_path = '/root/androgram/core/refreshhp.sh'
        script_output = run_shell_script(script_path, device)
        
        await query.edit_message_text(text=f"Script output for device {device_names.get(device, device)}:\n{script_output}", disable_web_page_preview=True)
    elif action == 'cancel_refresh_hp':
        await query.edit_message_text(text="Operation cancelled.", disable_web_page_preview=True)
    elif action in ['sms.sh', 'infohp.sh', 'refreshhp.sh']:
        device = callback_data[1]
        msg = await query.edit_message_text(text="Command is being executed...", disable_web_page_preview=True)
        
        script_path = f'/root/androgram/core/{action}'
        script_output = run_shell_script(script_path, device)
        
        if action == 'sms.sh':
            await query.edit_message_text(
                f"<b>List SMS of '{device_names.get(device, device)}':</b>",
                parse_mode='HTML'
            )
            chunks = split_output(script_output, 3)
            for chunk in chunks:
                await query.message.reply_text(text='\n'.join(chunk), disable_web_page_preview=True)
            
        else:
            await query.edit_message_text(text=f"Script output for device {device_names.get(device, device)}:\n{script_output}", disable_web_page_preview=True)

async def show_main_menu(update: Update) -> None:
    """Show the main menu."""
    keyboard = [
        [KeyboardButton("SMS"), KeyboardButton("Refresh HP")],
        [KeyboardButton("IP Remote"), KeyboardButton("Info HP")],
        [KeyboardButton("Restart Bot"), KeyboardButton("Settings")]
    ]
    reply_markup = ReplyKeyboardMarkup(keyboard, resize_keyboard=True)
    await update.message.reply_text('Select an option:', reply_markup=reply_markup)

def split_output(output: str, lines_per_chunk: int) -> list:
    """Split the output into chunks of specified lines."""
    lines = output.splitlines()
    return [lines[i:i + lines_per_chunk] for i in range(0, len(lines), lines_per_chunk)]

def main() -> None:
    """Start the bot."""
    # Create the Application and pass it your bot's token.
    # Retrieve devices at startup
    global device_names
    devices = get_adb_devices()
    logger.info(f"Connected devices on startup: {devices}")
    #
    application = ApplicationBuilder().token(token).build()

    # on different commands - answer in Telegram
    application.add_handler(CommandHandler("start", start))
    application.add_handler(CommandHandler("help", help_command))
    application.add_handler(CommandHandler("restart", restart))

    # Handle messages without slashes
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))

    # Handle callback queries
    application.add_handler(CallbackQueryHandler(button))

    # Run the bot with retry mechanism
    while True:
        try:
            application.run_polling()
        except NetworkError as e:
            logger.error(f"NetworkError: {e}. Retrying in 5 seconds...")
            time.sleep(5)
        except TelegramError as e:
            logger.error(f"TelegramError: {e}. Retrying in 5 seconds...")
            time.sleep(5)

if __name__ == '__main__':
    main()
