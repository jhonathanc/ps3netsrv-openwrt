# ps3netsrv-openwrt

The sources of ps3netsrv for OpenWrt were included in https://github.com/jhonathanc/ps3netsrv to use CI (continuous integration) for other platforms, including Windows, MacOS and Linux (Ubuntu, Debian, Fedora, Arch and AlmaLinux). This will allow us to release new versions faster to all supported platforms. And also to make it easier for users to install and use ps3netsrv.

After all, the instructions to use and setup it will remain here, to avoid confusions, but I'll add the instructions to use and setup it for openwrt on https://github.com/jhonathanc/ps3netsrv too.

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
