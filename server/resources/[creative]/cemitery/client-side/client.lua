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
Tunnel.bindInterface("cemitery",cRP)
vSERVER = Tunnel.getInterface("cemitery")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Selected = 1
local checkItem = 0
local spawnPed = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local cCoords = {
	{ -1731.62,-287.05,49.84,280.63 },
	{ -1740.59,-298.19,48.48,272.13 },
	{ -1747.95,-299.18,47.8,283.47 },
	{ -1757.38,-284.38,47.38,283.47 },
	{ -1782.43,-259.35,47.47,325.99 },
	{ -1784.46,-257.43,47.35,323.15 },
	{ -1798.49,-252.72,44.72,311.82 },
	{ -1804.53,-265.8,43.78,320.32 },
	{ -1749.27,-277.75,48.86,286.3 },
	{ -1766.21,-260.46,49.25,331.66 },
	{ -1794.43,-236.91,49.03,297.64 },
	{ -1795.91,-232.15,49.1,280.63 },
	{ -1769.85,-241.41,51.9,325.99 },
	{ -1760.79,-247.41,51.93,325.99 },
	{ -1758.88,-248.9,51.88,325.99 },
	{ -1751.01,-254.55,51.43,328.82 },
	{ -1767.95,-221.72,53.75,311.82 },
	{ -1769.96,-219.62,53.67,314.65 },
	{ -1742.21,-225.62,55.47,351.5 },
	{ -1746.02,-224.94,55.12,343.0 },
	{ -1749.32,-223.35,55.03,340.16 },
	{ -1759.25,-209.92,56.14,317.49 },
	{ -1757.02,-204.26,56.78,314.65 },
	{ -1759.04,-202.21,56.65,314.65 },
	{ -1731.33,-225.27,56.18,357.17 },
	{ -1714.78,-234.4,55.27,0.0 },
	{ -1624.73,-181.54,55.72,34.02 },
	{ -1622.79,-180.21,55.77,31.19 },
	{ -1639.93,-182.82,55.86,34.02 },
	{ -1637.72,-165.61,56.9,31.19 },
	{ -1642.7,-169.04,57.09,31.19 },
	{ -1640.75,-154.23,57.63,119.06 },
	{ -1642.1,-152.1,57.74,121.89 },
	{ -1661.1,-137.4,59.46,110.56 },
	{ -1659.54,-140.67,59.01,116.23 },
	{ -1655.47,-160.83,57.47,121.89 },
	{ -1656.76,-158.86,57.54,124.73 },
	{ -1683.56,-137.36,59.78,99.22 },
	{ -1682.63,-140.37,59.75,104.89 },
	{ -1681.6,-143.09,59.41,104.89 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	"ig_abigail","a_m_m_afriamer_01","ig_mp_agent14","csb_agent","ig_amandatownley",
	"s_m_y_ammucity_01","u_m_y_antonb","g_m_m_armboss_01","g_m_m_armgoon_01","g_m_m_armlieut_01","ig_ashley",
	"s_m_m_autoshop_01","ig_money","g_m_y_ballaeast_01","g_f_y_ballas_01","g_m_y_ballasout_01","s_m_y_barman_01",
	"u_m_y_baygor","a_m_o_beach_01","ig_bestmen","a_f_y_bevhills_01","a_m_m_bevhills_02","u_m_m_bikehire_01",
	"u_f_y_bikerchic","mp_f_boatstaff_01","s_m_m_bouncer_01","ig_brad","ig_bride","u_m_y_burgerdrug_01",
	"a_m_m_business_01","a_m_y_business_02","s_m_o_busker_01","ig_car3guy2","cs_carbuyer","g_m_m_chiboss_01",
	"g_m_m_chigoon_01","g_m_m_chigoon_02","u_f_y_comjane","ig_dale","ig_davenorton","s_m_y_dealer_01",
	"ig_denise","ig_devin","a_m_y_dhill_01","ig_dom","a_m_y_downtown_01","ig_dreyfuss"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CEMITERY:INITBODY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cemitery:initBody")
AddEventHandler("cemitery:initBody",function()
	if spawnPed ~= nil then
		if Selected ~= nil then
			exports["target"]:RemCircleZone("Cemitery:"..Selected)
		end

		if DoesEntityExist(spawnPed) then
			DeleteEntity(spawnPed)
			spawnPed = nil
		end
	end

	if spawnPed == nil then
		checkItem = 0
		Selected = math.random(#cCoords)
		local pSelected = math.random(#pedList)
		local mHash = GetHashKey(pedList[pSelected])

		RequestModel(mHash)
		while not HasModelLoaded(mHash) do
			Citizen.Wait(1)
		end

		if HasModelLoaded(mHash) then
			spawnPed = CreatePed(4,mHash,cCoords[Selected][1],cCoords[Selected][2],cCoords[Selected][3] - 1,cCoords[Selected][4] - 180.0,false,false)

			SetPedArmour(spawnPed,100)
			SetEntityInvincible(spawnPed,true)
			FreezeEntityPosition(spawnPed,true)
			SetBlockingOfNonTemporaryEvents(spawnPed,true)

			SetModelAsNoLongerNeeded(mHash)

			RequestAnimDict("dead")
			while not HasAnimDictLoaded("dead") do
				Citizen.Wait(1)
			end

			TaskPlayAnim(spawnPed,"dead","dead_a",8.0,0.0,-1,1,0,0,0,0)

			exports["target"]:AddCircleZone("Cemitery:"..Selected,vector3(cCoords[Selected][1],cCoords[Selected][2],cCoords[Selected][3]),0.75,{
				name = "Cemitery:"..Selected,
				heading = 3374176
			},{
				distance = 1.0,
				options = {
					{
						event = "cemitery:finishBody",
						label = "Roubar Pertences",
						tunnel = "client"
					}
				}
			})

			TriggerEvent("Notify","amarelo","Parece que estão efetuando uma limpeza em um dos túmulos, guarde essa informação e veja se você encontra alguns objetos de valor.",10000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CEMITERY:FINISHBODY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cemitery:finishBody")
AddEventHandler("cemitery:finishBody",function()
	TriggerServerEvent("inventory:makeProducts",{},"cemitery")
	checkItem = checkItem + 1

	if checkItem >= 5 then
		exports["target"]:RemCircleZone("Cemitery:"..Selected)
		Selected = nil
	end
end)