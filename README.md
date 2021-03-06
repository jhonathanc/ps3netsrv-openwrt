# ps3netsrv-openwrt
OpenWrt ps3netsrv feed for use with the OpenWrt SDK.

How to build (on linux):
1. Follow this guide to download and prepare the SDK: https://openwrt.org/docs/guide-developer/using_the_sdk;
2. Inside OpenWrt SDK path, you will find a file called "feeds.conf.default", copy this file and paste on same directory. Rename the new file to "feeds.conf";
3. Open the "feeds.conf" file and put this line at the end of the file:
```
src-git ps3netsrv_feed https://github.com/jhonathanc/ps3netsrv-openwrt.git
```
4. Save the "feeds.conf" and close the file;
5. On the terminal, go to the root path of OpenWrt SDK and use this commands:
```
./scripts/feeds update -a
./scripts/feeds install -a
make package/ps3netsrv/download
make package/ps3netsrv/prepare
make package/ps3netsrv/compile
```
6. If you didn't get any error message during the build process, you will find the compiled ps3netsrv on "./bin/packages/{yourPlatform}/ps3netsrv_feed/". So, just upload and install it to your router and config it following this guide:
https://github.com/jhonathanc/ps3netsrv/releases

7. If you find any problem, let me know (open an issue) and I will try to help you.

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
