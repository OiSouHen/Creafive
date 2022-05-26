-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("robberys",cRP)
vCLIENT = Tunnel.getInterface("robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYAVAILABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local robberyAvailable = {
	["departamentStore"] = os.time(),
	["ammunation"] = os.time(),
	["fleecas"] = os.time(),
	["barbershop"] = os.time(),
	["banks"] = os.time()
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
local robberys = {
	["1"] = {
		["coords"] = { 28.24,-1338.832,29.5 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["2"] = {
		["coords"] = { 2548.883,384.850,108.63 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["3"] = {
		["coords"] = { 1159.156,-314.055,69.21 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["4"] = {
		["coords"] = { -710.067,-904.091,19.22 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["5"] = {
		["coords"] = { -43.652,-1748.122,29.43 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["6"] = {
		["coords"] = { 378.291,333.712,103.57 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["7"] = {
		["coords"] = { -3250.385,1004.504,12.84 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["8"] = {
		["coords"] = { 1734.968,6421.161,35.04 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["9"] = {
		["coords"] = { 546.450,2662.45,42.16 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["10"] = {
		["coords"] = { 1959.113,3749.239,32.35 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["11"] = {
		["coords"] = { 2672.457,3286.811,55.25 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["12"] = {
		["coords"] = { 1708.095,4920.711,42.07 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["13"] = {
		["coords"] = { -1829.422,798.491,138.2 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["14"] = {
		["coords"] = { -2959.66,386.765,14.05 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["15"] = {
		["coords"] = { -3048.155,585.519,7.91 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["16"] = {
		["coords"] = { 1126.75,-979.760,45.42 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["17"] = {
		["coords"] = { 1169.631,2717.833,37.16 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["18"] = {
		["coords"] = { -1478.67,-375.675,39.17 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["19"] = {
		["coords"] = { -1221.126,-916.213,11.33 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["20"] = {
		["coords"] = { 168.97,6644.71,31.69 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["21"] = {
		["coords"] = { -168.42,6318.8,30.58 },
		["name"] = "Loja de departamentStoreo",
		["type"] = "departamentStore",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card01",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 8,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["22"] = {
		["coords"] = { 1693.374,3761.669,34.71 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["23"] = {
		["coords"] = { 253.061,-51.643,69.95 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["24"] = {
		["coords"] = { 841.128,-1034.951,28.2 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["25"] = {
		["coords"] = { -330.467,6085.647,31.46 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["26"] = {
		["coords"] = { -660.987,-933.901,21.83 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["27"] = {
		["coords"] = { -1304.775,-395.832,36.7 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["28"] = {
		["coords"] = { -1117.765,2700.388,18.56 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["29"] = {
		["coords"] = { 2566.632,292.945,108.74 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["30"] = {
		["coords"] = { -3172.701,1089.462,20.84 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["31"] = {
		["coords"] = { 23.733,-1106.27,29.8 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["32"] = {
		["coords"] = { 808.914,-2158.684,29.62 },
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["distance"] = 10.0,
		["cooldown"] = 45,
		["item"] = "card02",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",18750,23750 }
		}
	},
	["33"] = {
		["coords"] = { -1210.409,-336.485,38.29 },
		["name"] = "Banco Fleeca",
		["type"] = "fleecas",
		["distance"] = 10.0,
		["cooldown"] = 180,
		["item"] = "card03",
		["locate"] = "Sul",
		["timer"] = 420,
		["cops"] = 10,
		["payment"] = {
			{ "goldbar",125,145 }
		}
	},
	["34"] = {
		["coords"] = { -353.519,-55.518,49.54 },
		["name"] = "Banco Fleeca",
		["type"] = "fleecas",
		["distance"] = 10.0,
		["cooldown"] = 180,
		["item"] = "card03",
		["locate"] = "Sul",
		["timer"] = 420,
		["cops"] = 10,
		["payment"] = {
			{ "goldbar",125,145 }
		}
	},
	["35"] = {
		["coords"] = { 311.525,-284.649,54.67 },
		["name"] = "Banco Fleeca",
		["type"] = "fleecas",
		["distance"] = 10.0,
		["cooldown"] = 180,
		["item"] = "card03",
		["locate"] = "Sul",
		["timer"] = 420,
		["cops"] = 10,
		["payment"] = {
			{ "goldbar",125,145 }
		}
	},
	["36"] = {
		["coords"] = { 147.210,-1046.292,29.87 },
		["name"] = "Banco Fleeca",
		["type"] = "fleecas",
		["distance"] = 10.0,
		["cooldown"] = 180,
		["item"] = "card03",
		["locate"] = "Sul",
		["timer"] = 420,
		["cops"] = 10,
		["payment"] = {
			{ "goldbar",125,145 }
		}
	},
	["37"] = {
		["coords"] = { -2956.449,482.090,16.2 },
		["name"] = "Banco Fleeca",
		["type"] = "fleecas",
		["distance"] = 10.0,
		["cooldown"] = 180,
		["item"] = "card03",
		["locate"] = "Sul",
		["timer"] = 420,
		["cops"] = 10,
		["payment"] = {
			{ "goldbar",125,145 }
		}
	},
	["38"] = {
		["coords"] = { 1175.66,2712.939,38.59 },
		["name"] = "Banco Fleeca",
		["type"] = "fleecas",
		["distance"] = 10.0,
		["cooldown"] = 180,
		["item"] = "card03",
		["locate"] = "Norte",
		["timer"] = 420,
		["cops"] = 10,
		["payment"] = {
			{ "goldbar",125,145 }
		}
	},
	["39"] = {
		["coords"] = { -810.15,-179.57,37.57 },
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["distance"] = 10.0,
		["cooldown"] = 60,
		["item"] = "card04",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",8750,11250 }
		}
	},
	["40"] = {
		["coords"] = { 134.4,-1707.81,29.28 },
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["distance"] = 10.0,
		["cooldown"] = 60,
		["item"] = "card04",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",8750,11250 }
		}
	},
	["41"] = {
		["coords"] = { -1284.26,-1115.11,6.99 },
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["distance"] = 10.0,
		["cooldown"] = 60,
		["item"] = "card04",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",8750,11250 }
		}
	},
	["42"] = {
		["coords"] = { 1930.61,3727.97,32.84 },
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["distance"] = 10.0,
		["cooldown"] = 60,
		["item"] = "card04",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",8750,11250 }
		}
	},
	["43"] = {
		["coords"] = { 1211.45,-470.7,66.2 },
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["distance"] = 10.0,
		["cooldown"] = 60,
		["item"] = "card04",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",8750,11250 }
		}
	},
	["44"] = {
		["coords"] = { -30.56,-151.83,57.07 },
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["distance"] = 10.0,
		["cooldown"] = 60,
		["item"] = "card04",
		["locate"] = "Sul",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",8750,11250 }
		}
	},
	["45"] = {
		["coords"] = { -277.75,6230.6,31.69 },
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["distance"] = 10.0,
		["cooldown"] = 60,
		["item"] = "card04",
		["locate"] = "Norte",
		["timer"] = 300,
		["cops"] = 6,
		["payment"] = {
			{ "dollars",8750,11250 }
		}
	},
	["46"] = {
		["coords"] = { -104.386,6477.150,31.83 },
		["name"] = "Saving Bank",
		["type"] = "banks",
		["distance"] = 10.0,
		["cooldown"] = 360,
		["item"] = "card05",
		["locate"] = "Norte",
		["timer"] = 900,
		["cops"] = 14,
		["payment"] = {
			{ "goldbar",175,225 }
		}
	},
	["47"] = {
		["coords"] = { 265.336,220.184,102.09 },
		["name"] = "Vinewood Vault",
		["type"] = "banks",
		["distance"] = 20.0,
		["cooldown"] = 360,
		["item"] = "card05",
		["locate"] = "Sul",
		["timer"] = 900,
		["cops"] = 14,
		["payment"] = {
			{ "goldbar",175,225 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkRobbery(robberyId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robberys[robberyId] then
			local prev = robberys[robberyId]

			if os.time() >= robberyAvailable[prev["type"]] then
				local policeResult = vRP.numPermission("Police")
				if parseInt(#policeResult) >= parseInt(prev["cops"]) then
					local consultItem = vRP.getInventoryItemAmount(user_id,prev["item"])
					if consultItem[1] <= 0 then
						TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName(prev["item"]).."</b>.",5000)
						return false
					end

					if vRP.checkBroken(consultItem[2]) then
						TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(prev["item"]).."</b> quebrado.",5000)
						return false
					end

					if vRP.tryGetInventoryItem(user_id,consultItem[2],1) then
						robberyAvailable[prev["type"]] = os.time() + (prev["cooldown"] * 60)
						TriggerClientEvent("player:applyGsr",source)

						for k,v in pairs(policeResult) do
							async(function()
								TriggerClientEvent("NotifyPush",v,{ code = 31, title = prev["name"], x = prev["coords"][1], y = prev["coords"][2], z = prev["coords"][3], time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
								vRPC.playSound(v,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
							end)
						end

						return true
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentRobbery(robberyId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,10)
		TriggerEvent("Wanted",source,user_id,900)

		local identity = vRP.userIdentity(user_id)
		for k,v in pairs(robberys[robberyId]["payment"]) do
			local value = math.random(v[2],v[3])
			vRP.generateItem(user_id,v[1],parseInt(value),true)

			if robberys[robberyId]["locate"] ~= identity["locate"] then
				vRP.generateItem(user_id,v[1],parseInt(value * 0.1),true)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	vCLIENT.inputRobberys(source,robberys)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:JEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
local jewelryShowcase = {}
local jewelryTimers = os.time()
local jewelryCooldowns = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:INITJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("robberys:initJewelry")
AddEventHandler("robberys:initJewelry",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if os.time() >= jewelryCooldowns then
			local policeResult = vRP.numPermission("Police")
			if parseInt(#policeResult) >= 8 then
				local consultItem = vRP.getInventoryItemAmount(user_id,"pendrive")
				if consultItem[1] <= 0 then
					TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x Pendrive</b>.",5000)
					return false
				end

				if vRP.checkBroken(consultItem[2]) then
					TriggerClientEvent("Notify",source,"vermelho","<b>Pendrive</b> quebrado.",5000)
					return false
				end

				if vRP.tryGetInventoryItem(user_id,consultItem[2],1) then
					TriggerClientEvent("Notify",source,"verde","Sistema corrompido.",5000)
					jewelryCooldowns = os.time() + 7200
					jewelryTimers = os.time() + 600
					jewelryShowcase = {}

					for k,v in pairs(policeResult) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Joalheria", x = -633.07, y = -238.7, z = 38.06, time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
							vRPC.playSound(v,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:JEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("robberys:jewelry")
AddEventHandler("robberys:jewelry",function(entity)
	local source = source
	local showcase = entity[1]
	local user_id = vRP.getUserId(source)
	if user_id then
		if os.time() <= jewelryTimers then
			if jewelryShowcase[showcase] == nil then
				jewelryShowcase[showcase] = true
				TriggerClientEvent("vRP:Cancel",source,true)
				vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)

				SetTimeout(20000,function()
					vRPC.stopAnim(source,false)
					vRP.upgradeStress(user_id,10)
					TriggerEvent("Wanted",source,user_id,60)
					TriggerClientEvent("vRP:Cancel",source,false)
					vRP.generateItem(user_id,"watch",math.random(20,30),true)
				end)
			else
				TriggerClientEvent("Notify",source,"azul","Vitrine vazia.",3000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Necessário corromper o sistema.",3000)
		end
	end
end)