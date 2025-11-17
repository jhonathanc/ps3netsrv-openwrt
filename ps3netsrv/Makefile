#
# Copyright (C) 2012-2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ps3netsrv
PKG_VERSION:=20250803
PKG_GIT_COMMIT:=cb0e765ad37d62cf68b5f0d7bdda4b477b96fba8
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/jhonathanc/ps3netsrv/archive/refs/tags
PKG_HASH:=ea516ff938b93898cee44ececb30a428adf4387ad66fc7e584bc6f90e59f4cb4

PKG_MAINTAINER:=JCorrea
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk

define Package/ps3netsrv
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=File Transfer
  TITLE:=PS3 Game Server
  URL:=https://github.com/jhonathanc/ps3netsrv-openwrt/
  DEPENDS:=+libpthread +libstdcpp
endef

define Package/ps3netsrv/description
ps3netsrv allows you to stream games and ISOs over the network to your CFW PlayStation(R) 3 system.
This may be useful if you have a modified PS3, and your router has storage options.
endef

define Package/ps3netsrv/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ps3netsrv $(1)/usr/bin

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/ps3netsrv.init $(1)/etc/init.d/ps3netsrv

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/ps3netsrv.config $(1)/etc/config/ps3netsrv
  
	# LuCI controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luci/controller/ps3netsrv.lua \
		$(1)/usr/lib/lua/luci/controller/ps3netsrv.lua

	# LuCI view (JS moderna)
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/ps3netsrv
	$(INSTALL_DATA) ./luci/view/ps3netsrv/main.js \
		$(1)/usr/lib/lua/luci/view/ps3netsrv/main.js
endef

$(eval $(call BuildPackage,ps3netsrv))
