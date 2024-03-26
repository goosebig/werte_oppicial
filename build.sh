#!/bin/bash
export TZ=Asia/Jakarta

DATE=$(date +%Y%m%d_%H%M%S)

# 打印 info
make info

# 主配置名称
PROFILE="generic"

PACKAGES=""

# 主题
# Passwall 代理 luci-i18n-passwall-zh-cn
# PACKAGES="$PACKAGES brook chinadns-ng dns2socks dns2tcp hysteria microsocks simple-obfs tcping trojan-go trojan-plus xray-core v2ray-geoip v2ray-geosite xray-plugin"
PACKAGES="$PACKAGES luci-mod-status autocore"
#rpcd rpcd-mod-file rpcd-mod-iwinfo rpcd-mod-rpcsys rpcd-mod-ucode"
PACKAGES="$PACKAGES -dnsmasq dnsmasq-full"
PACKAGES="$PACKAGES luci-proto-mbim"
PACKAGES="$PACKAGES luci-proto-qmi"
PACKAGES="$PACKAGES luci-proto-modemmanager"
#PACKAGES="$PACKAGES luci-app-passwall"
PACKAGES="$PACKAGES luci-app-eqosplus"

PACKAGES="$PACKAGES internet-detector luci-app-internet-detector"

PACKAGES="$PACKAGES -dnsmasq dnsmasq-full cgi-io libiwinfo libiwinfo-data libiwinfo-lua liblua block-mount mount-utils"
PACKAGES="$PACKAGES liblucihttp liblucihttp-lua libubus-lua lua luci luci-app-firewall luci-app-opkg"
PACKAGES="$PACKAGES luci-base luci-lib-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full"
PACKAGES="$PACKAGES luci-mod-network luci-mod-system luci-proto-ipv6 luci-proto-ppp luci-ssl"
PACKAGES="$PACKAGES luci-theme-bootstrap px5g-wolfssl rpcd rpcd-mod-file rpcd-mod-iwinfo rpcd-mod-luci"
PACKAGES="$PACKAGES rpcd-mod-rrdns uhttpd uhttpd-mod-ubus usbutils htop"
PACKAGES="$PACKAGES kmod-usb-net kmod-usb-net-huawei-cdc-ncm kmod-usb-net-cdc-ether kmod-usb-acm kmod-usb-net-qmi-wwan"
PACKAGES="$PACKAGES kmod-usb-net-rndis kmod-usb-serial-qualcomm kmod-usb-net-sierrawireless kmod-usb-ohci kmod-usb-serial"
PACKAGES="$PACKAGES kmod-nls-utf8 kmod-usb-serial-option kmod-usb-serial-sierrawireless kmod-usb-uhci kmod-usb2"
PACKAGES="$PACKAGES kmod-usb-net-ipheth kmod-usb-net-cdc-mbim usbmuxd libusbmuxd-utils libimobiledevice-utils"
PACKAGES="$PACKAGES kmod-usb-storage kmod-usb-storage-uas ksmbd-server"

PACKAGES="$PACKAGES luci-app-openclash luci-app-cloudflared"
PACKAGES="$PACKAGES luci-app-diskman luci-app-hd-idle luci-app-samba4"
PACKAGES="$PACKAGES luci-theme-material luci-theme-argon luci-app-poweroff"
PACKAGES="$PACKAGES luci-app-ramfree luci-app-ttyd openssh-sftp-server adb"
PACKAGES="$PACKAGES usbutils pciutils htop"
#PACKAGES="$PACKAGES kmod-nft-tproxy kmod-inet-diag ip6tables-mod-nat iptables-mod-extra iptables-mod-tproxy kmod-ipt-nat ruby ruby-yaml kmod-tun"




# 常用kmod组件
PACKAGES="$PACKAGES git bash cfdisk"
PACKAGES="$PACKAGES usb-modeswitch kmod-usb2 kmod-usb3 kmod-usb-ohci kmod-usb-ehci kmod-sdhci"
PACKAGES="$PACKAGES kmod-usb-net-rndis kmod-usb-net-huawei-cdc-ncm kmod-usb-net-cdc-eem kmod-usb-net-cdc-ether kmod-usb-net-cdc-subset kmod-nls-base kmod-usb-core kmod-usb-net kmod-usb-net-cdc-ether kmod-usb2"


#PACKAGES="$PACKAGES -dnsmasq dnsmasq-full cgi-io libiwinfo libiwinfo-data libiwinfo-lua liblua block-mount mount-utils"
#PACKAGES="$PACKAGES liblucihttp liblucihttp-lua libubus-lua lua luci luci-app-firewall luci-app-opkg"
#PACKAGES="$PACKAGES luci-base luci-lib-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-mod-admin-full"
#PACKAGES="$PACKAGES luci-mod-network luci-mod-status luci-mod-system luci-proto-ipv6 luci-proto-ppp luci-ssl"
#PACKAGES="$PACKAGES luci-theme-bootstrap px5g-wolfssl rpcd rpcd-mod-file rpcd-mod-iwinfo rpcd-mod-luci"
#PACKAGES="$PACKAGES rpcd-mod-rrdns uhttpd uhttpd-mod-ubus usbutils htop"
#PACKAGES="$PACKAGES kmod-usb-net kmod-usb-net-huawei-cdc-ncm kmod-usb-net-cdc-ether kmod-usb-acm kmod-usb-net-qmi-wwan"
#PACKAGES="$PACKAGES kmod-usb-net-rndis kmod-usb-serial-qualcomm kmod-usb-net-sierrawireless kmod-usb-ohci kmod-usb-serial"
#PACKAGES="$PACKAGES kmod-nls-utf8 kmod-usb-serial-option kmod-usb-serial-sierrawireless kmod-usb-uhci kmod-usb2"
#PACKAGES="$PACKAGES kmod-usb-net-ipheth kmod-usb-net-cdc-mbim usbmuxd libusbmuxd-utils libimobiledevice-utils"
#PACKAGES="$PACKAGES kmod-usb-storage kmod-usb-storage-uas ksmbd-server"

#PACKAGES="$PACKAGES iptables-nft docker-compose luci-app-dockerman"

PACKAGES="$PACKAGES bash screen jq wget-ssl curl"
#PACKAGES="$PACKAGES iw kmod-cfg80211 kmod-iwlwifi wpa-supplicant wireless-tools wireless-regdb kmod-mac80211 hostapd-openssl hostapd-common iwlwifi-firmware-iwl6050"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl100"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl1000"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl105"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl135"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl2000"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl2030"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl3160"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl3168"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl5000"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl5150"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl6000g2"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl6000g2a"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl6000g2b"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl6050"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl7260"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl7265"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl7265d"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl8260c"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl8265"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl9000"
#PACKAGES="$PACKAGES iwlwifi-firmware-iwl9260"

PACKAGES="$PACKAGES iptables-nft netdata vnstat2 vnstati2"
PACKAGES="$PACKAGES luci-app-netmonitor"
PACKAGES="$PACKAGES luci-app-cloudflared luci-app-diskman luci-app-hd-idle luci-app-samba4 cloudflared"

PACKAGES="$PACKAGES kmod-inet-diag"
PACKAGES="$PACKAGES luci-compat"
PACKAGES="$PACKAGES kmod-nft-tproxy"
PACKAGES="$PACKAGES kmod-ipt-nat"
PACKAGES="$PACKAGES iptables-mod-extra"
PACKAGES="$PACKAGES kmod-tun"
PACKAGES="$PACKAGES iptables-mod-tproxy"


PACKAGES="$PACKAGES luci-app-openclash"
#PACKAGES="$PACKAGES luci-app-lite-watchdog"
PACKAGES="$PACKAGES adguardhome luci-app-adguardhome"
#PACKAGES="$PACKAGES luci-app-adblock"

PACKAGES="$PACKAGES luci-theme-material luci-theme-argon luci-app-poweroff"
PACKAGES="$PACKAGES luci-app-ramfree luci-app-ttyd openssh-sftp-server adb"
PACKAGES="$PACKAGES usbutils pciutils htop irqbalance"
#PACKAGES="$PACKAGES kmod-nft-tproxy kmod-inet-diag ip6tables-mod-nat iptables-mod-extra iptables-mod-tproxy kmod-ipt-nat ruby ruby-yaml kmod-tun"




# 常用kmod组件
PACKAGES="$PACKAGES git bash cfdisk"
PACKAGES="$PACKAGES usb-modeswitch kmod-usb2 kmod-usb3 kmod-usb-ohci kmod-usb-ehci kmod-sdhci"
PACKAGES="$PACKAGES kmod-usb-net-rndis kmod-usb-net-huawei-cdc-ncm kmod-usb-net-cdc-eem kmod-usb-net-cdc-ether kmod-usb-net-cdc-subset kmod-nls-base kmod-usb-core kmod-usb-net kmod-usb-net-cdc-ether kmod-usb2"


# Diskman 磁盘管理
PACKAGES="$PACKAGES -luci-i18n-base-zh-cn -default-settings-chn"

# collectd 统计
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES collectd-mod-sensors lm-sensors lm-sensors-detect" 


# OpenClash 代理
#PACKAGES="$PACKAGES kmod-nf-ipt kmod-ipt-core kmod-ipt-ipset libipset13 ipset"
#PACKAGES="$PACKAGES luci-app-openclash"

# 常用的网络存储组件
# 文件助手
#PACKAGES="$PACKAGES luci-app-fileassistant"
# 硬盘休眠
#PACKAGES="$PACKAGES luci-i18n-hd-idle-zh-cn"
# Samba 网络共享
#PACKAGES="$PACKAGES luci-i18n-samba4-zh-cn"

# Docker 组件
#PACKAGES="$PACKAGES libc6-compat luci-lib-docker luci-i18n-dockerman-zh-cn"



# XUNLEI组件
#vPACKAGES="$PACKAGES libc6-compat nas-xunlei luci-app-xunlei luci-i18n-xunlei-zh-cn"

# 宽带监控 Nlbwmon
# PACKAGES="$PACKAGES luci-i18n-nlbwmon-zh-cn"

# Packages 文件夹下的 ipk 包
# PACKAGES="$PACKAGES luci-i18n-wrtbwmon-zh-cn"

# 一些自己需要的内核组件
#PACKAGES="$PACKAGES kmod-usb-printer kmod-lp"
# zsh 终端
PACKAGES="$PACKAGES zsh"
# Vim 完整版，带语法高亮
#PACKAGES="$PACKAGES vim-fuller"
# X/Y/ZMODEM 文件传输
#PACKAGES="$PACKAGES lrzsz"
# OpenSSH
PACKAGES="$PACKAGES openssh-server openssh-client"
# Netdata 系统监控界面
PACKAGES="$PACKAGES luci-app-tinyfilemanager"




# 界面翻译补全
# PACKAGES="$PACKAGES luci-i18n-opkg-zh-cn luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn luci-i18n-turboacc-zh-cn luci-i18n-filetransfer-zh-cn"

# 移除不需要的包

# 一些自定义文件
FILES="files"

# 禁用 openssh-server 的 sshd 服务和 docker 的 dockerd 服务以防止冲突
DISABLED_SERVICES="sshd"

make image PROFILE="$PROFILE" PACKAGES="$PACKAGES" FILES="$FILES" DISABLED_SERVICES="$DISABLED_SERVICES" EXTRA_IMAGE_NAME="$DATE"
#make image PROFILE="$PROFILE" PACKAGES="$PACKAGES" DISABLED_SERVICES="$DISABLED_SERVICES"

