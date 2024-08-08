#!/bin/bash
echo "sss" 
interpis=usb0+usb1
echo $interpis

options=( "5" "h" "d" "m" "y")

for opt in "${options[@]}"
do

panjang=$(vnstat "-$opt" | grep /s | head -n 1 | awk '{print $1}' | wc -m)
echo $panjang
vn=$(vnstat "-$opt" -i "$interpis" | grep /s | sed 's/  */ /g' | sed 's/ | / /g' | awk -v panjang="$panjang" '{printf "%-"panjang"s • %7s%4s\n", $1, $6, $7}')
# echo "<blockquote><code>
echo "<code>
$vn
</code>"
# </code></blockquote>"
done