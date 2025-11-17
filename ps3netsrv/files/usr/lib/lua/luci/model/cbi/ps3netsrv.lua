--[[
LuCI - Lua Configuration Interface for ps3netsrv
]]--

local map, section, net = ...
local net = map:section(TypedSection, "ps3netsrv", translate("PS3 Net Server Configuration"))
net.anonymous = true
net.addremove = false

local enable = net:option(Flag, "enabled", translate("Enable"), translate("Enable PS3 Net Server on startup"))
enable.default = 0

local dir = net:option(Value, "dir", translate("Games Directory"), translate("Root directory containing PS3 games (e.g., /mnt/sda1/PS3)"))
dir.datatype = "string"
dir.placeholder = "/mnt/sda1/PS3"
dir:depends("enabled", "1")

function dir:validate(value)
	if value == "" then
		return nil, translate("Directory path cannot be empty")
	end
	if string.sub(value, 1, 1) ~= "/" then
		return nil, translate("Directory path must start with /")
	end
	return value
end

local port = net:option(Value, "port", translate("Port"), translate("Port number for PS3 Net Server (default: 38008)"))
port.datatype = "port"
port.default = "38008"
port.placeholder = "38008"
port:depends("enabled", "1")

function port:validate(value)
	local port_num = tonumber(value)
	if not port_num then
		return nil, translate("Port must be a valid number")
	end
	if port_num < 1024 or port_num > 65535 then
		return nil, translate("Port must be between 1024 and 65535")
	end
	return value
end

return map
