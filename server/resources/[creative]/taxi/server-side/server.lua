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
Tunnel.bindInterface("taxi",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentService()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,2)
		local value = math.random(200,225)
		vRP.generateItem(user_id,"dollars",value,true)

		if vRP.userPremium(user_id) then
			vRP.generateItem(user_id,"dollars",value * 0.10,true)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initService(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if status then
			vRP.insertPermission(source,user_id,"Taxi")
		else
			vRP.removePermission(user_id,"Taxi")
		end
	end

	return true
end