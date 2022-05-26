-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service,Color)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local splitName = splitString(Service,"-")
		local serviceName = splitName[1]

		if vRP.hasPermission(user_id,serviceName) then
			if serviceName == "Lspd" or serviceName == "Sheriff" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.removePermission(user_id,"Police")
				TriggerEvent("blipsystem:serviceExit",source)
				TriggerClientEvent("vRP:PoliceService",source,false)
			end

			if serviceName == "Paramedic" then
				vRP.removePermission(user_id,serviceName)
				TriggerEvent("blipsystem:serviceExit",source)
				TriggerClientEvent("vRP:ParamedicService",source,false)
			end

			vRP.updatePermission(user_id,serviceName,"wait"..serviceName)
			TriggerClientEvent("Notify",source,"azul","Saiu de serviço.",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Entrar em Serviço",5000)
		elseif vRP.hasPermission(user_id,"wait"..serviceName) then
			if serviceName == "Lspd" or serviceName == "Sheriff" or serviceName == "Corrections" or serviceName == "Ranger" or serviceName == "State" then
				vRP.insertPermission(source,user_id,"Police")
				TriggerClientEvent("vRP:PoliceService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"POLICE: "..serviceName,Color)
			end

			if serviceName == "Paramedic" then
				vRP.insertPermission(source,user_id,serviceName)
				TriggerClientEvent("vRP:ParamedicService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"Paramedic",Color)
			end

			vRP.updatePermission(user_id,"wait"..serviceName,serviceName)
			TriggerClientEvent("Notify",source,"azul","Entrou em serviço.",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Sair de Serviço",5000)
		end
	end
end)