-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Route = 0
local Plants = {}
local Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(Plants) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= 50 then
				if Objects[k] == nil and v["route"] == Route then
					exports["target"]:AddCircleZone("Plants:"..k,vector3(v["coords"][1],v["coords"][2],v["coords"][3] + 0.5),0.5,{
						name = "Plants:"..k,
						heading = 3374176
					},{
						shop = k,
						distance = 1.0,
						options = {
							{
								event = "plants:Coletar",
								label = "Coletar",
								tunnel = "shop"
							},{
								event = "plants:Estaquia",
								label = "Estaquia",
								tunnel = "shop"
							},{
								event = "plants:Fertilizar",
								label = "Fertilizar",
								tunnel = "shop"
							},{
								event = "plants:Informacoes",
								label = "Informações",
								tunnel = "shop"
							}
						}
					})

					createModels(k,v["prop"],v["coords"][1],v["coords"][2],v["coords"][3])
				end
			else
				if Objects[k] then
					if DoesEntityExist(Objects[k]) then
						exports["target"]:RemCircleZone("Plants:"..k)
						DeleteEntity(Objects[k])
						Objects[k] = nil
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE:ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("update:Route")
AddEventHandler("update:Route",function(Number)
	Route = Number
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:COLETAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Coletar")
AddEventHandler("plants:Coletar",function(Number)
	TriggerServerEvent("plants:Coletar",Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:ESTAQUIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Estaquia")
AddEventHandler("plants:Estaquia",function(Number)
	TriggerServerEvent("plants:Estaquia",Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:FERTILIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Fertilizar")
AddEventHandler("plants:Fertilizar",function(Number)
	TriggerServerEvent("plants:Fertilizar",Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:INFORMACOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Informacoes")
AddEventHandler("plants:Informacoes",function(Number)
	TriggerServerEvent("plants:Informacoes",Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
function createModels(Number,model,x,y,z)
	local mHash = GetHashKey(model)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Citizen.Wait(1)
	end

	Objects[Number] = CreateObject(mHash,x,y,z,false,false,false)
	PlaceObjectOnGroundProperly(Objects[Number])
	FreezeEntityPosition(Objects[Number],true)
	SetModelAsNoLongerNeeded(mHash)

	SetEntityLodDist(Objects[Number],0xFFFF)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Table")
AddEventHandler("plants:Table",function(table)
	Plants = table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Adicionar")
AddEventHandler("plants:Adicionar",function(Number,Table)
	Plants[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Remover")
AddEventHandler("plants:Remover",function(Number)
	Plants[Number] = nil

	if DoesEntityExist(Objects[Number]) then
		exports["target"]:RemCircleZone("Plants:"..Number)
		DeleteEntity(Objects[Number])
		Objects[Number] = nil
	end
end)