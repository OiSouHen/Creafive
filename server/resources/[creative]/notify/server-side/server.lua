-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("notify",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Shortcuts()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local Shortcuts = {}
		local inventory = vRP.userInventory(user_id)
		if inventory then
			for i = 1,5 do
				local Slot = tostring(i)
				if inventory[Slot] then
					Shortcuts[Slot] = itemIndex(inventory[Slot]["item"])
				else
					Shortcuts[Slot] = ""
				end
			end

			return Shortcuts
		end
	end

	return false
end