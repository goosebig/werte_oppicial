#!/bin/bash
# This script for custom download the latest packages version from snapshots/stable repo's url and github releases.
# Put file name and url base.
# Download packages from official snapshots, stable repo's urls and custom repo's.
{
files1=(
    #"luci-proto-modemmanager|https://downloads.openwrt.org/snapshots/packages/x86_64/luci"
    "adguardhome|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-adguardhome|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    #"luci-proto-mbim|https://downloads.openwrt.org/snapshots/packages/x86_64/luci"
    #"modemmanager|https://downloads.openwrt.org/snapshots/packages/x86_64/packages"
    #"libmbim|https://downloads.openwrt.org/snapshots/packages/x86_64/packages"
    #"libqmi|https://downloads.openwrt.org/snapshots/packages/x86_64/packages"
    "sms-tool|https://downloads.openwrt.org/snapshots/packages/x86_64/packages"
    "luci-proto-modemmanager|https://downloads.openwrt.org/releases/packages-23.05/x86_64/luci"
    "luci-proto-mbim|https://downloads.openwrt.org/releases/packages-23.05/x86_64/luci"
    "modemmanager|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "libmbim|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "libqmi|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    #"sms-tool|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "luci-app-argon-config|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/luci"
    "luci-theme-argon|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-cpu-status-mini|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-diskman|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-disks-info|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-log-viewer|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/luci"
    "luci-app-tinyfilemanager|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-internet-detector|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "internet-detector|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/packages"
    "internet-detector-mod-modem-restart|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/packages"
    "luci-app-netspeedtest|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "python3-speedtest-cli|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "librespeed-go|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "luci-app-ramfree|https://downloads.immortalwrt.org/snapshots/packages/x86_64/luci"
)

echo "###########################################################"
echo "Downloading packages from official repo's and custom repo's"
echo "###########################################################"
echo "#"
for entry in "${files1[@]}"; do
    IFS="|" read -r filename1 base_url <<< "$entry"
    echo "Processing file: $filename1"
    file_urls=$(curl -sL "$base_url" | grep -oE "${filename1}_[0-9a-zA-Z\._~-]*\.ipk" | sort -V | tail -n 1)
    for file_url in $file_urls; do
        if [ ! -z "$file_url" ]; then
            echo "Downloading $file_url"
            echo "from $base_url/$file_url"
            curl -Lo "packages/$file_url" "$base_url/$file_url"
            echo "Packages [$filename1] downloaded successfully!."
            echo "#"
            break
        else
            echo "Failed to retrieve packages [$filename1] because it's different from $base_url/$file_url. Retrying before exit..."
        fi
    done
done
}

