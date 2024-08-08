#!/bin/sh
echo "abc"
echo "abc"
echo "abc"
hape=$1

dtip=$(adb -s "$hape" shell ip route| grep 'rmnet.*src' | sed -E 's/.*src ([^ ]+).*/\1/')
echo "IP      : $dtip"
dtop=$(adb -s "$hape" shell getprop gsm.sim.operator.alpha)
echo "OPSEL   : $dtop"
data_mentah=$(adb -s "$hape" shell dumpsys battery)
# echo "$data_mentah"

# Extracting the battery level using grep and saving it to dtlevel
dtlevel=$(echo "$data_mentah" | grep 'level' | awk '{print $2}')

# Output the extracted battery level
# echo "level: $dtlevel%"

# Extracting the temperature
temperature=$(echo "$data_mentah" | grep 'temperature' | awk '{print $2}')

# Convert temperature from tenths of Celsius to Celsius
temperature_celsius=$((temperature / 10))
# Handle fractional part manually
temperature_celsius_fractional=$(( (temperature % 10) * 10 / 10 ))

dttechnology=$(echo "$data_mentah" | grep 'technology' | awk '{print $2}')

echo "BATTERY : $dtlevel% ($temperature_celsius.$temperature_celsius_fractional°C) $dttechnology"

