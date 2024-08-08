#!/bin/sh

CONFIG_FILE="/root/androgram/config.ini"

# Extract the sms_limit value from the config file
sms_limit=$(grep '^sms_limit' "$CONFIG_FILE" | awk -F'=' '{print $2}' | xargs)

# Print the sms_limit value

hape=$1
# nama_hp=$2
datetime=$(date '+%Y-%m-%d %H:%M:%S')

# Echo the date and time
nama_hp=$(adb devices -l | grep $hape | sed 's/device:/(/' | sed 's/model://g' | awk '{print toupper($5), toupper($6)}')

# echo "hape"
adb -s $hape shell content query --uri content://sms/ --projection "address AS PENGIRIM, datetime(date_sent / 1000, 'unixepoch', 'localtime') AS DATE, replace(replace(body, char(10), ' '), char(13), ' ') AS SMS" --sort "date ASC" | tail -n $sms_limit | sed 's/Row: [0-9]\+ //g; s/, SMS=/)\n✉️ /g; s/PENGIRIM=/\n👤 /g; s/, DATE=/ (/g'