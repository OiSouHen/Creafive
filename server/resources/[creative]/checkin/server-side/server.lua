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
Tunnel.bindInterface("checkin",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getHealth(source) <= 101 then
			if vRP.tryGetInventoryItem(user_id,"adrenaline",1) then
				vRP.upgradeHunger(user_id,20)
				vRP.upgradeThirst(user_id,20)
				vRP.upgradeStress(user_id,10)
				TriggerEvent("Repose",source,user_id,900)

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Precisa de uma <b>Adrenalina</b>.",5000)
			end
		else
			if vRP.request(source,"Prosseguir o tratamento por <b>$750</b> dólares?","Sim","Não") then
				if vRP.paymentFull(user_id,750) then
					vRP.upgradeHunger(user_id,20)
					vRP.upgradeThirst(user_id,20)
					vRP.upgradeStress(user_id,10)
					TriggerEvent("Repose",source,user_id,900)

					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end

	return false
end