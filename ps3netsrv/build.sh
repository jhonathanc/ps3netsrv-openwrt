#!/bin/bash
echo "src-git ps3netsrv_feed https://github.com/jhonathanc/ps3netsrv-openwrt.git" >> feeds.conf.default

#sudo apt-get update
#sudo apt-get install upx -y
#cp /usr/bin/upx staging_dir/host/bin
#cp /usr/bin/upx-ucl staging_dir/host/bin

./scripts/feeds update -a
./scripts/feeds install -a
make package/ps3netsrv/{download,prepare,compile} -j4