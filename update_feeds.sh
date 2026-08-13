#!/bin/bash
set -e

# Update all feeds and initially generate indexes
./scripts/feeds update -a

# Remove conflicting LuCI package
rm -rf feeds/luci/applications/luci-app-mosdns

# Remove packages that should be provided by kenzo/small
rm -rf \
    feeds/packages/net/alist \
    feeds/packages/net/adguardhome \
    feeds/packages/net/mosdns \
    feeds/packages/net/xray* \
    feeds/packages/net/v2ray* \
    feeds/packages/net/sing* \
    feeds/packages/net/smartdns \
    feeds/packages/utils/v2dat \
    feeds/packages/lang/golang

# Replace Go toolchain
git clone \
    https://github.com/kenzok8/golang \
    -b 1.26 \
    feeds/packages/lang/golang

# IMPORTANT: regenerate indexes after modifying feed contents
./scripts/feeds update -i packages luci

# Clean old feed symlinks and reinstall
rm -rf package/feeds
./scripts/feeds install -a
