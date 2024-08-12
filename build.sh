#!/bin/bash
export TZ=Asia/Jakarta

DATE=$(date +%Y%m%d_%H%M%S)

# 打印 info
make info

# 主配置名称
PROFILE="generic"

PACKAGES=" "

# Modem and UsbLAN Driver
PACKAGES+=" kmod-usb-net-rtl8150 kmod-usb-net-rtl8152 kmod-usb-net-asix kmod-usb-net-asix-ax88179"
PACKAGES+=" kmod-mii kmod-usb-net kmod-usb-wdm kmod-usb-net-qmi-wwan uqmi luci-proto-qmi \
kmod-usb-net-cdc-ether kmod-usb-serial-option kmod-usb-serial kmod-usb-serial-wwan qmi-utils \
kmod-usb-serial-qualcomm kmod-usb-acm kmod-usb-net-cdc-ncm kmod-usb-net-cdc-mbim umbim \
modemmanager luci-proto-modemmanager libmbim libqmi usbutils luci-proto-mbim luci-proto-ncm \
kmod-usb-net-huawei-cdc-ncm kmod-usb-net-cdc-ether kmod-usb-net-rndis kmod-usb-net-sierrawireless kmod-usb-ohci kmod-usb-serial-sierrawireless \
kmod-usb-uhci kmod-usb2 kmod-usb-ehci kmod-usb-net-ipheth usbmuxd libusbmuxd-utils libimobiledevice-utils usb-modeswitch kmod-nls-utf8 mbim-utils \
kmod-phy-broadcom kmod-phylib-broadcom kmod-tg3"

#openclash
PACKAGES+="coreutils-nohup bash dnsmasq-full curl ca-certificates ipset ip-full libcap libcap-bin ruby ruby-yaml kmod-tun kmod-inet-diag unzip kmod-nft-tproxy luci-compat luci luci-base luci-app-openclash"

PACKAGES+=" luci-app-adguardhome ca-certificates ca-bundle tar unzip bind-tools"

# NAS and Hard disk tools
PACKAGES+=" luci-app-diskman luci-app-hd-idle smartmontools kmod-usb-storage kmod-usb-storage-uas ntfs-3g"

PACKAGES+=" samba4-server luci-app-samba4 aria2 ariang luci-app-aria2 luci-app-tinyfilemanager"

# Docker
# PACKAGES+=" docker docker-compose dockerd luci-app-dockerman"

# Argon Theme
PACKAGES+=" luci-theme-argon luci-app-argon-config"

# PHP8
PACKAGES+=" libc php8 php8-fastcgi php8-fpm php8-mod-session php8-mod-ctype php8-mod-fileinfo php8-mod-zip php8-mod-iconv php8-mod-mbstring coreutils-stat zoneinfo-asia"

PACKAGES+=" kmod-iwlwifi iw-full pciutils -dnsmasq  -kmod-usb-net-rtl8152-vendor"


PACKAGES+=" zram-swap adb parted losetup resize2fs luci luci-ssl block-mount luci-app-poweroff luci-app-ramfree htop bash curl wget wget-ssl tar unzip unrar gzip jq luci-app-ttyd nano httping screen openssh-sftp-server"

# Bandwidth And Network Monitoring
PACKAGES+=" internet-detector luci-app-internet-detector nlbwmon luci-app-nlbwmon vnstat2 vnstati2 luci-app-netmonitor"


PACKAGES+=" python3-pip python3 python3-setuptools"


PACKAGES+=" luci-app-tailscale tailscale tailscaled"

#my
PACKAGES+=" zsh autocore-x86"



FILES="files"

# 禁用 openssh-server 的 sshd 服务和 docker 的 dockerd 服务以防止冲突

DISABLED_SERVICES="sshd"

#make image PROFILE="$PROFILE" PACKAGES="$PACKAGES" FILES="$FILES" DISABLED_SERVICES="$DISABLED_SERVICES" EXTRA_IMAGE_NAME="$DATE"

make image PROFILE="$PROFILE" PACKAGES="$PACKAGES" FILES="$FILES" DISABLED_SERVICES="$DISABLED_SERVICES"

