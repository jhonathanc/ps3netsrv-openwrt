--[[
LuCI - Lua Configuration Interface for ps3netsrv
]]--

module("luci.controller.admin.services.ps3netsrv", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ps3netsrv") then
		return
	end

	entry({"admin", "services", "ps3netsrv"}, view("ps3netsrv/main"), _("PS3 Net Server"), 30).dependent = false
	entry({"admin", "services", "ps3netsrv_status"}, call("ps3netsrv_status"))
end

function ps3netsrv_status()
	local sys = require "luci.sys"
	
	luci.http.prepare_content("application/json")
	
	-- Verifica se o serviço está ativo
	local running = sys.call("pgrep -f '^ps3netsrv' > /dev/null") == 0
	
	-- Tenta obter mais informações
	local info = {}
	if running then
		local config_enabled = luci.model.uci.cursor():get("ps3netsrv", "main", "enabled")
		local port = luci.model.uci.cursor():get("ps3netsrv", "main", "port") or "38008"
		local dir = luci.model.uci.cursor():get("ps3netsrv", "main", "dir") or "/mnt/sda1/PS3"
		
		info.status = "running"
		info.port = port
		info.dir = dir
	else
		info.status = "stopped"
	end
	
	luci.http.write_json(info)
end
