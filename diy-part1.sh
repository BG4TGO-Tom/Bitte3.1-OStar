#!/bin/bash
# diy-part1.sh - 用于在 feeds.conf.default 中追加或替换自定义 feed 来源
# 在 Actions 中，这个脚本会在 openwrt 目录下执行

cd "$(dirname "$0")" || exit 1   # 确保在 openwrt 目录下执行（保险）

# 先备份 feeds.conf.default（可选，但推荐）
[ -f feeds.conf.default ] && cp feeds.conf.default feeds.conf.default.bak

# 清空或注释掉原有同名 feed（避免重复）
sed -i '/^src-git.*packages/d' feeds.conf.default
sed -i '/^src-git.*luci/d' feeds.conf.default
sed -i '/^src-git.*mmdvm/d' feeds.conf.default
sed -i '/^src-git.*devtools/d' feeds.conf.default

# 追加你指定的 feed 来源
cat >> feeds.conf.default << 'EOF'
src-git packages https://git.openwrt.org/feed/packages.git;openwrt-19.07
src-git luci https://github.com/lazywalker/luci.git;ostar-19.07
src-git mmdvm https://github.com/lazywalker/mmdvm-openwrt.git
src-git devtools https://github.com/lazywalker/devtools-feeds.git
EOF

echo "feeds.conf.default 已更新，添加了自定义 feed:"
cat feeds.conf.default | grep -E 'packages|luci|mmdvm|devtools'
