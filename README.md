# ps3netsrv-openwrt

![Build Status](https://github.com/jhonathanc/ps3netsrv-openwrt/workflows/CI/badge.svg)

OpenWrt ps3netsrv feed for use with the OpenWrt SDK.

You can find binaries for some platforms on:
https://github.com/jhonathanc/ps3netsrv/releases

If you want to add a new platform, you can fork this repository, edit the main.yml file to add a new job, test it and then, open a PR. I'll be really glad to merge it here :D.

How to build (on linux):
1. Follow this guide to download and prepare the SDK: https://openwrt.org/docs/guide-developer/using_the_sdk;
2. Open terminal and go to OpenWrt SDK path (usually with "cd" command, eg: "cd /home/yourUser/somePath/...");
3. Add the new feed to feeds.conf.default:
```
echo "src-git ps3netsrv_feed https://github.com/jhonathanc/ps3netsrv-openwrt.git" >> feeds.conf.default
```
4. And use this commands to build:
```
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make package/ps3netsrv/download
make package/ps3netsrv/prepare
make package/ps3netsrv/compile
```
5. If you didn't get any error message during the build process, you will find the compiled ps3netsrv on "./bin/packages/{yourPlatform}/ps3netsrv_feed/". So, just upload and install it to your router and config it following this guide:
https://github.com/jhonathanc/ps3netsrv/releases

6. If you find any problem, let me know (open an issue) and I will try to help you.

<b>After install to openwrt procedure</b>:
- After install, you need to setup it. The easiest way is through terminal, over ssh with these commands:
```
uci set ps3netsrv.main.enabled='1'
uci set ps3netsrv.main.dir='mnt/sda1'
uci set ps3netsrv.main.port='38008'
uci commit
```
Notes:
- "ps3netsrv.main.enabled='1'" means it will start on boot. If you don't want it, set the value to '0' (so you will need to start it manually through terminal);
- "ps3netsrv.main.dir" is used to set the root dir of your games directories (which contains "PS3ISO", "GAMES",...);
- "ps3netsrv.main.port" is used to set the port used by ps3netsrv.
