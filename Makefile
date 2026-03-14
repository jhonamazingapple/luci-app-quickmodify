include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-quickmodify
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-quickmodify
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Quick Modify Hostname and MAC
  DEPENDS:=+luci-base
  PKGARCH:=all
endef

define Build/Compile
endef

define Package/luci-app-quickmodify/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./root/usr/bin/quickmod_logic.sh $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-quickmodify.json $(1)/usr/share/rpcd/acl.d/
	$(INSTALL_DIR) $(1)/usr/share/luci/menu.d
	$(INSTALL_DATA) ./root/usr/share/luci/menu.d/luci-app-quickmodify.json $(1)/usr/share/luci/menu.d/
	$(INSTALL_DIR) $(1)/www/luci-static/resources/view
	$(INSTALL_DATA) ./htdocs/luci-static/resources/view/quickmodify.js $(1)/www/luci-static/resources/view/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./root/etc/config/quickmodify $(1)/etc/config/quickmodify
endef

$(eval $(call BuildPackage,luci-app-quickmodify))
