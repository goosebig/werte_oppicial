#!/bin/bash
# Base install.sh by Gege Desembri <https://github.com/GegeDesembri/openwrt-tools>
# Revamped installation and added various supported devices architectures (Arm, arm64, x86_generic, x86_64) by Helmi Amirudin <https://helmiau.com>

echo "Start Cloudflare Download !"
echo "Current Path: $PWD"

#mkdir -p $PWD/files/usr/bin
#cd files/usr/bin || (echo "Clash core path does not exist! " && exit)

github_reponame="cloudflare/cloudflared"
path_binary="$PWD/packages/luci-app-openclash_new.ipk"


latest_ver=$(curl -s https://raw.githubusercontent.com/vernesong/OpenClash/package/master/version | head -n1 | sed "s/^v//g")
echo ${latest_ver}
wget -qO ${path_binary} --show-progress "https://raw.githubusercontent.com/vernesong/OpenClash/package/master/luci-app-openclash_${latest_ver}_all.ipk"

#wget -qO- "https://github.com/cloudflare/cloudflared/releases/download/2023.8.0/cloudflared-linux-arm64" > $PWD/files/usr/bin/cloudflared

#echo ${path_binary}
#chmod +x $PWD/files/usr/bin/cloudflared

#chmod +x ${path_binary}


exit 0
