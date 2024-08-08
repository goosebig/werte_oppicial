#!/bin/bash

# Define the location of the modem mapping file
modem_file="/root/pyteg.env"

# Extract default route information
route_info=$(ip route show | grep default | awk '{print $3, $5}')

# List connected devices via adb
devices=$(adb devices | grep -w "device" | grep -v "List of devices attached" | awk '{print $1}')

echo "IP REMOTE MODEM
"

# Loop through each serial number
for serial in $devices; do
  # Get the model based on serial from modem.txt
  model=$(grep -E "^$serial:" "$modem_file" | cut -d ':' -f 2)
  
  if [ -z "$model" ]; then
    model="UNKNOWN"
  fi
  
  echo "🟢 $model"
  
  # Get the IP address from adb
  ip_address=$(adb -s "$serial" shell ip route | grep rndis | awk '{print $9}')
  echo "<blockquote><code>$ip_address</code></blockquote>"
done
