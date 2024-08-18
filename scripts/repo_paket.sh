#!/bin/bash
# This script is for custom downloading the latest package versions from snapshots/stable repo URLs and GitHub releases.
# Specify the file name and URL base.
# Download packages from official snapshots, stable repo URLs, and custom repos.

{
files1=(
    "adguardhome|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-adguardhome|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-proto-modemmanager|https://downloads.openwrt.org/releases/packages-23.05/x86_64/luci"
    "luci-proto-mbim|https://downloads.openwrt.org/releases/packages-23.05/x86_64/luci"
    "modemmanager|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "libmbim|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "libqmi|https://downloads.openwrt.org/releases/packages-23.05/x86_64/packages"
    "luci-app-argon-config|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/luci"
    "luci-theme-argon|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-poweroff|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-diskman|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-disks-info|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-tailscale|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "tailscale|https://downloads.openwrt.org/snapshots/packages/x86_64/packages"
    "luci-app-tinyfilemanager|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "luci-app-internet-detector|https://dl.openwrt.ai/23.05/packages/x86_64/kiddin9"
    "internet-detector|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/packages"
    "internet-detector-mod-modem-restart|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/packages"
    "luci-app-netspeedtest|https://fantastic-packages.github.io/packages/releases/23.05/packages/x86_64/packages"
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

    # Fetch the URL content and display the matched files for debugging
    url_content=$(curl -sL "$base_url")
    echo "Fetched URL content for $filename1:"
    echo "$url_content" | grep "${filename1}_[0-9a-zA-Z\._~-]*\.ipk"

    # Find the latest package file URL
    file_urls=$(echo "$url_content" | grep -oE "${filename1}_[0-9a-zA-Z\._~-]*\.ipk" | sort -V | tail -n 1)

    if [ -z "$file_urls" ]; then
        echo "No files found for $filename1. Check the URL or the package name pattern."
        echo "#"
        continue
    fi

    for file_url in $file_urls; do
        if [ ! -z "$file_url" ]; then
            echo "Downloading $file_url"
            echo "from $base_url/$file_url"
            curl -Lo "packages/$file_url" "$base_url/$file_url"
            if [ $? -eq 0 ]; then
                echo "Package [$filename1] downloaded successfully!."
            else
                echo "Failed to download package [$filename1]."
            fi
            echo "#"
            break
        else
            echo "Failed to retrieve packages [$filename1] because it's different from $base_url/$file_url. Retrying before exit..."
        fi
    done
done
}
