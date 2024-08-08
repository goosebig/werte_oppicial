#!/bin/sh

modem=$1
datetime=$(date '+%Y-%m-%d %H:%M:%S')

# Echo the date and time
nama_hp=$(adb devices -l | grep $modem | sed 's/device:/(/' | sed 's/model://g' | awk '{print toupper($5), toupper($6)}')

echo "☎️ $nama_hp)"

modem_ip=$(adb -s $modem shell ip addr show | grep 'global rmnet'  | grep -oE 'inet ([0-9]+\.){3}[0-9]+' | awk '{print $2}')

echo "🔴 IP LAMA : $modem_ip"

adb -s $modem shell cmd connectivity airplane-mode enable
sleep 3
adb -s $modem shell cmd connectivity airplane-mode disable

# Function to check if IP is not empty
check_ip() {
    if [ -n "$1" ]; then
        return 0  # IP is not empty
    else
        return 1  # IP is empty
    fi
}

while true; do
    # Replace this command with your actual command to get the IP address
    current_ip=$(adb -s $modem shell ip addr show | grep 'global rmnet'  | grep -oE 'inet ([0-9]+\.){3}[0-9]+' | awk '{print $2}')

    # Check if the IP is not empty
    if check_ip "$current_ip"; then
        # Run your command when the IP is not empty
        # echo "abc"
        break  # Break out of the loop after running the command
    fi

    # Sleep for a certain duration before checking again
    sleep 2
done

echo "🟢 IP BARU : $current_ip"
