-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:IDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Identity")
AddEventHandler("vRP:Identity",function(info)
	if info == nil then
		SendNUIMessage({ identity = false })
	else
		SendNUIMessage({ identity = true, mode = info["mode"], nome = info["nome"], nacionalidade = info["nacionalidade"], propriedades = info["propriedades"], veiculos = info["veiculos"], gemas = info["gemas"], porte = info["porte"], premium = info["premium"], sangue = info["sangue"] })
	end
end)