-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("inventory",cRP)
vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Weapon = ""
local Backpack = false
local weaponActive = false
local putWeaponHands = false
local storeWeaponHands = false
local timeReload = GetGameTimer()
LocalPlayer["state"]["Buttons"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Buttons")
AddEventHandler("inventory:Buttons",function(status)
	LocalPlayer["state"]["Buttons"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Buttons"] then
			timeDistance = 1
			DisableControlAction(1,75,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- throwableWeapons
-----------------------------------------------------------------------------------------------------------------------------------------
local currentWeapon = ""
RegisterNetEvent("inventory:throwableWeapons")
AddEventHandler("inventory:throwableWeapons",function(weaponName)
	currentWeapon = weaponName

	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey(currentWeapon) then
		while GetSelectedPedWeapon(ped) == GetHashKey(currentWeapon) do
			if IsPedShooting(ped) then
				vSERVER.removeThrowable(currentWeapon)
			end
			Wait(0)
		end
		currentWeapon = ""
	else
		cRP.storeWeaponHands()
		currentWeapon = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Backpack then
		Backpack = false
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("hud:Active",true)
		SendNUIMessage({ action = "hideMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	TriggerEvent("inventory:Close")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Craft",function()
	Backpack = false
	SetNuiFocus(false,false)
	TriggerEvent("hud:Active",true)
	SendNUIMessage({ action = "hideMenu" })

	TriggerEvent("crafting:openSource")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Deliver",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:Deliver",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:useItem",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:sendItem",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		vSERVER.invUpdate(data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	if MumbleIsConnected() then
		SendNUIMessage({ action = action })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:clearWeapons")
AddEventHandler("inventory:clearWeapons",function()
	if Weapon ~= "" then
		Weapon = ""
		weaponActive = false
		RemoveAllPedWeapons(PlayerPedId(),true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(splitName)
	if Weapon == splitName then
		local ped = PlayerPedId()
		local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)
		if not vSERVER.verifyWeapon(Weapon,weaponAmmo) then
			RemoveAllPedWeapons(ped,true)
			weaponActive = false
			Weapon = ""
		end
	else
		if Weapon == "" then
			vSERVER.existWeapon(splitName)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:preventWeapon")
AddEventHandler("inventory:preventWeapon",function(storeWeapons)
	if Weapon ~= "" then
		local ped = PlayerPedId()
		local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)

		vSERVER.preventWeapon(Weapon,weaponAmmo)

		weaponActive = false
		Weapon = ""

		if storeWeapons then
			RemoveAllPedWeapons(ped,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openBackpack",function(source,args,rawCommand)
	if GetEntityHealth(PlayerPedId()) > 101 and not LocalPlayer["state"]["Buttons"] and MumbleIsConnected() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
			Backpack = true
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			TriggerEvent("hud:Active",false)
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openBackpack","Manusear a mochila.","keyboard","OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				local vehTyres = {}

				for i = 0,7 do
					local Status = false

					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						Status = true
					end

					vehTyres[i] = Status
				end

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				for Tyre,Burst in pairs(vehTyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTyre")
AddEventHandler("inventory:repairTyre",function(Vehicle,Tyres,vehPlate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				local vehTyres = {}

				for i = 0,7 do
					local Status = false

					if i ~= Tyres then
						if GetTyreHealth(Vehicle,i) ~= 1000.0 then
							Status = true
						end
					end

					SetVehicleTyreFixed(Vehicle,i)

					vehTyres[i] = Status
				end

				for Tyre,Burst in pairs(vehTyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairPlayer")
AddEventHandler("inventory:repairPlayer",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleEngineHealth(Vehicle,1000.0)
				SetVehicleBodyHealth(Vehicle,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEALARM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:vehicleAlarm")
AddEventHandler("inventory:vehicleAlarm",function(vehIndex,vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleAlarm(Vehicle,true)
				StartVehicleAlarm(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.parachuteColors()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped,"GADGET_PARACHUTE",1,false,true)
	SetPedParachuteTintIndex(ped,math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local fishCoords = PolyZone:Create({
	vector2(2308.64,3906.11),
	vector2(2180.13,3885.29),
	vector2(2058.22,3883.56),
	vector2(2024.97,3942.53),
	vector2(1748.72,3964.53),
	vector2(1655.65,3886.34),
	vector2(1547.59,3830.17),
	vector2(1540.73,3826.94),
	vector2(1535.67,3816.55),
	vector2(1456.35,3756.87),
	vector2(1263.44,3670.38),
	vector2(1172.99,3648.83),
	vector2(967.98,3653.54),
	vector2(840.55,3679.16),
	vector2(633.13,3600.70),
	vector2(361.73,3626.24),
	vector2(310.58,3571.61),
	vector2(266.92,3493.13),
	vector2(173.49,3421.45),
	vector2(128.16,3442.66),
	vector2(143.41,3743.49),
	vector2(-38.59,3754.16),
	vector2(-132.62,3716.80),
	vector2(-116.73,3805.33),
	vector2(-157.23,3838.81),
	vector2(-204.70,3846.28),
	vector2(-208.28,3873.08),
	vector2(-236.88,4076.58),
	vector2(-184.11,4231.52),
	vector2(-139.54,4253.54),
	vector2(-45.38,4344.43),
	vector2(-5.96,4408.34),
	vector2(38.36,4411.02),
	vector2(150.77,4311.74),
	vector2(216.02,4342.85),
	vector2(294.16,4245.62),
	vector2(396.21,4342.24),
	vector2(438.37,4315.38),
	vector2(505.22,4178.69),
	vector2(606.65,4202.34),
	vector2(684.48,4169.83),
	vector2(773.54,4152.33),
	vector2(877.34,4172.67),
	vector2(912.20,4269.57),
	vector2(850.92,4428.91),
	vector2(922.96,4376.48),
	vector2(941.32,4328.09),
	vector2(995.318,4288.70),
	vector2(1050.33,4215.29),
	vector2(1082.27,4285.61),
	vector2(1060.97,4365.31),
	vector2(1072.62,4372.37),
	vector2(1119.24,4317.53),
	vector2(1275.27,4354.90),
	vector2(1360.96,4285.09),
	vector2(1401.09,4283.69),
	vector2(1422.33,4339.60),
	vector2(1516.60,4393.69),
	vector2(1597.58,4455.65),
	vector2(1650.81,4499.17),
	vector2(1781.12,4525.83),
	vector2(1828.69,4560.26),
	vector2(1866.59,4554.49),
	vector2(2162.70,4664.53),
	vector2(2279.31,4660.26),
	vector2(2290.52,4630.90),
	vector2(2418.64,4613.91),
	vector2(2427.06,4597.69),
	vector2(2449.86,4438.97),
	vector2(2396.62,4353.36),
	vector2(2383.66,4160.74),
	vector2(2383.05,4046.07)
},{ name = "Pescaria" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingCoords()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	if fishCoords:isPointInside(coords) and IsEntityInWater(ped) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.returnWeapon()
	if Weapon ~= "" then
		return Weapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWeapon(Hash)
	if Weapon == Hash then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:stealTrunk")
AddEventHandler("inventory:stealTrunk",function(entity)
	if Weapon == "WEAPON_CROWBAR" then
		local trunk = GetEntityBoneIndexByName(entity[3],"boot")
		if trunk ~= -1 then
			local ped = PlayerPedId()
			local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.5,0.0)
			local coordsEnt = GetWorldPositionOfEntityBone(entity[3],trunk)
			local distance = #(coords - coordsEnt)
			if distance <= 2.0 then
				vSERVER.stealTrunk(entity)
			end
		end
	else
		TriggerEvent("Notify","amarelo","<b>Pé de Cabra</b> não encontrado.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAttachs = {
	["attachsFlashlight"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_03",
		["WEAPON_PISTOL50"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH"
	},
	["attachsCrosshair"] = {
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_RAIL",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_RAIL_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_SCOPE_SMALL",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MACRO_02_MK2",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_SMALL_MK2",
		["WEAPON_SMG"] = "COMPONENT_AT_SCOPE_MACRO_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_SCOPE_MACRO"
	},
	["attachsSilencer"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_SMG"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02"
	},
	["attachsGrip"] = {
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_MUZZLE_08",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAttachs(nameItem,nameWeapon)
	return weaponAttachs[nameItem][nameWeapon]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putAttachs(nameItem,nameWeapon)
	GiveWeaponComponentToPed(PlayerPedId(),nameWeapon,weaponAttachs[nameItem][nameWeapon])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putWeaponHands(weaponName,weaponAmmo,attachs)
	if not putWeaponHands then
		if weaponAmmo == nil then
			weaponAmmo = 0
		end

		if weaponAmmo > 0 then
			weaponActive = true
		end

		putWeaponHands = true
		LocalPlayer["state"]["Cancel"] = true

		local ped = PlayerPedId()
		if HasPedGotWeapon(ped,GetHashKey("GADGET_PARACHUTE"),false) then
			RemoveAllPedWeapons(ped,true)
			cRP.parachuteColors()
		else
			RemoveAllPedWeapons(ped,true)
		end

		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("rcmjosh4")

			TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)

			Citizen.Wait(200)

			GiveWeaponToPed(ped,weaponName,weaponAmmo,false,true)

			Citizen.Wait(300)

			ClearPedTasks(ped)
		else
			GiveWeaponToPed(ped,weaponName,weaponAmmo,true,true)
		end

		if attachs ~= nil then
			for nameItem,_ in pairs(attachs) do
				cRP.putAttachs(nameItem,weaponName)
			end
		end

		LocalPlayer["state"]["Cancel"] = false
		putWeaponHands = false
		Weapon = weaponName

		if vSERVER.dropWeapons(Weapon) then
			RemoveAllPedWeapons(ped,true)
			weaponActive = false
			Weapon = ""
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeWeaponHands()
	if not storeWeaponHands then
		storeWeaponHands = true
		local ped = PlayerPedId()
		local lastWeapon = Weapon
		LocalPlayer["state"]["Cancel"] = true
		local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)

		if not IsPedInAnyVehicle(ped) then
			loadAnimDict("weapons@pistol@")

			TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)

			Citizen.Wait(450)

			ClearPedTasks(ped)
		end

		LocalPlayer["state"]["Cancel"] = false
		RemoveAllPedWeapons(ped,true)

		storeWeaponHands = false
		weaponActive = false
		Weapon = ""

		return true,weaponAmmo,lastWeapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONAMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAmmos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_SMG_MK2",
		"WEAPON_ASSAULTSMG",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_COMPACTRIFLE",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_BULLPUPRIFLE",
		"WEAPON_BULLPUPRIFLE_MK2",
		"WEAPON_ADVANCEDRIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_SAWNOFFSHOTGUN"
	},
	["WEAPON_MUSKET_AMMO"] = {
		"WEAPON_SNIPERRIFLE",
		"WEAPON_MUSKET"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGECHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeCheck(ammoType)
	local weaponHash = nil
	local ped = PlayerPedId()
	local weaponStatus = false

	if weaponAmmos[ammoType] then
		local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)

		for k,v in pairs(weaponAmmos[ammoType]) do
			if Weapon == v then
				weaponHash = Weapon
				weaponStatus = true
				break
			end
		end
	end

	return weaponStatus,weaponHash,weaponAmmo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeWeapon(weaponHash,ammoAmount)
	AddAmmoToPed(PlayerPedId(),weaponHash,ammoAmount)
	weaponActive = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		if weaponActive and Weapon ~= "" then
			timeDistance = 100
			local ped = PlayerPedId()
			local weaponAmmo = GetAmmoInPedWeapon(ped,Weapon)

			if GetGameTimer() >= timeReload and IsPedReloading(ped) then
				vSERVER.preventWeapon(Weapon,weaponAmmo)
				timeReload = GetGameTimer() + 1000
			end

			if weaponAmmo <= 0 or (Weapon == "WEAPON_PETROLCAN" and weaponAmmo <= 135 and IsPedShooting(ped)) or IsPedSwimming(ped) then
				vSERVER.preventWeapon(Weapon,weaponAmmo)
				RemoveAllPedWeapons(ped,true)
				weaponActive = false
				Weapon = ""
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local fireTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkCracker()
	if GetGameTimer() <= fireTimers then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker",function()
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			Citizen.Wait(1)
		end
	end

	local explosives = 25
	local ped = PlayerPedId()
	fireTimers = GetGameTimer() + (5 * 60000)
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.6,0.0)
	local myObject,objNet = vRPS.CreateObject("ind_prop_firework_03",coords["x"],coords["y"],coords["z"])
	if myObject then
		local spawnObjects = 0
		local uObject = NetworkGetEntityFromNetworkId(objNet)
		while not DoesEntityExist(uObject) and spawnObjects <= 1000 do
			uObject = NetworkGetEntityFromNetworkId(objNet)
			spawnObjects = spawnObjects + 1
			Citizen.Wait(1)
		end

		spawnObjects = 0
		local objectControl = NetworkRequestControlOfEntity(uObject)
		while not objectControl and spawnObjects <= 1000 do
			objectControl = NetworkRequestControlOfEntity(uObject)
			spawnObjects = spawnObjects + 1
			Citizen.Wait(1)
		end

		PlaceObjectOnGroundProperly(uObject)
		FreezeEntityPosition(uObject,true)

		SetEntityAsNoLongerNeeded(uObject)

		Citizen.Wait(10000)

		repeat
			UseParticleFxAssetNextCall("scr_indep_fireworks")
			local explode = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",coords["x"],coords["y"],coords["z"],0.0,0.0,0.0,2.5,false,false,false,false)
			explosives = explosives - 1

			Citizen.Wait(2000)
		until explosives <= 0

		TriggerServerEvent("tryDeleteObject",objNet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWater()
	return IsPedSwimming(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIMDIC
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local _,cdz = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

		TriggerServerEvent("inventory:Drops",data["item"],data["slot"],data["amount"],coords["x"],coords["y"],cdz)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Table")
AddEventHandler("drops:Table",function(Table)
	Drops = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Adicionar")
AddEventHandler("drops:Adicionar",function(Number,Table)
	Drops[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Remover")
AddEventHandler("drops:Remover",function(Number)
	if Drops[Number] then
		Drops[Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ATUALIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Atualizar")
AddEventHandler("drops:Atualizar",function(Number,Amount)
	if Drops[Number] then
		Drops[Number]["amount"] = Amount
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for _,v in pairs(Drops) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= 50 then
				timeDistance = 1
				DrawMarker(21,v["coords"][1],v["coords"][2],v["coords"][3] + 0.25,0.0,0.0,0.0,0.0,180.0,0.0,0.25,0.35,0.25,46,110,76,100,0,0,0,1)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestInventory",function(data,cb)
	local Items = {}
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local _,cdz = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

	for k,v in pairs(Drops) do
		local distance = #(vector3(coords["x"],coords["y"],cdz) - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
		if distance <= 0.9 then
			local Number = #Items + 1

			Items[Number] = v
			Items[Number]["id"] = k
		end
	end

	local inventario,invPeso,invMaxpeso = vSERVER.requestInventory()
	if inventario then
		cb({ inventario = inventario, drop = Items, invPeso = invPeso, invMaxpeso = invMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:Pickup",data["id"],data["amount"],data["target"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.wheelChair(vehPlate)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.75,0.0)
	local myVehicle = vGARAGE.serverVehicle("wheelchair",coords["x"],coords["y"],coords["z"],heading,vehPlate,0,nil,1000)

	if NetworkDoesNetworkIdExist(myVehicle) then
		local vehicleNet = NetToEnt(myVehicle)
		if NetworkDoesNetworkIdExist(vehicleNet) then
			SetVehicleOnGroundProperly(vehicleNet)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELTREADS
-----------------------------------------------------------------------------------------------------------------------------------------
local wheelChair = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(vehicle)
			if model == -1178021069 then
				if not IsEntityPlayingAnim(ped,"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester",3) then
					vRP.playAnim(true,{"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester"},true)
					wheelChair = true
				end
			end
		else
			if wheelChair then
				vRP.removeObjects("one")
				wheelChair = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARISCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
local scanTable = {}
local initSounds = {}
local soundScanner = 999
local userScanner = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local scanCoords = {
	{ -1811.94,-968.5,1.72,357.17 },
	{ -1788.29,-958.0,3.35,328.82 },
	{ -1756.9,-942.98,6.91,311.82 },
	{ -1759.97,-910.12,7.58,334.49 },
	{ -1791.44,-904.11,5.12,39.69 },
	{ -1827.87,-900.32,2.48,68.04 },
	{ -1840.76,-882.39,2.81,51.03 },
	{ -1793.4,-819.9,7.73,328.82 },
	{ -1737.69,-791.3,9.44,317.49 },
	{ -1714.6,-784.61,9.82,306.15 },
	{ -1735.88,-757.92,10.11,2.84 },
	{ -1763.22,-764.65,9.49,65.2 },
	{ -1786.23,-782.4,8.71,99.22 },
	{ -1809.5,-798.29,7.89,104.89 },
	{ -1816.35,-827.68,6.44,141.74 },
	{ -1833.23,-856.58,3.52,147.41 },
	{ -1842.88,-869.45,2.98,144.57 },
	{ -1865.34,-858.4,2.12,99.22 },
	{ -1868.01,-835.58,3.0,51.03 },
	{ -1860.76,-810.59,4.04,8.51 },
	{ -1848.85,-790.99,6.3,348.67 },
	{ -1834.31,-767.03,8.17,337.33 },
	{ -1819.3,-742.04,8.85,331.66 },
	{ -1804.76,-713.39,9.76,331.66 },
	{ -1805.32,-695.22,10.23,348.67 },
	{ -1824.32,-685.97,10.23,36.86 },
	{ -1849.16,-699.25,9.45,85.04 },
	{ -1868.9,-716.3,8.86,110.56 },
	{ -1890.07,-736.57,6.27,124.73 },
	{ -1909.8,-759.44,3.52,130.4 },
	{ -1920.19,-782.25,2.8,144.57 },
	{ -1939.84,-765.34,1.99,85.04 },
	{ -1932.96,-746.47,3.05,8.51 },
	{ -1954.69,-722.8,3.03,28.35 },
	{ -1954.53,-688.85,4.06,11.34 },
	{ -1939.8,-651.94,8.74,351.5 },
	{ -1926.48,-627.37,10.67,348.67 },
	{ -1920.73,-615.67,10.95,340.16 },
	{ -1924.48,-596.03,11.56,51.03 },
	{ -1952.53,-597.0,11.02,70.87 },
	{ -1972.12,-609.32,8.73,102.05 },
	{ -1989.01,-629.48,5.21,124.73 },
	{ -2002.97,-659.48,3.03,141.74 },
	{ -2028.03,-658.61,1.82,107.72 },
	{ -2045.57,-637.91,2.02,65.2 },
	{ -2031.42,-618.65,3.23,0.0 },
	{ -2003.74,-603.38,6.3,328.82 },
	{ -1982.79,-588.43,10.01,317.49 },
	{ -1968.4,-565.72,11.42,323.15 },
	{ -1980.98,-545.43,11.58,5.67 },
	{ -1996.36,-552.72,11.68,17.01 },
	{ -2013.33,-573.78,8.95,102.05 },
	{ -2030.05,-604.62,3.93,133.23 },
	{ -2035.79,-626.99,3.0,150.24 },
	{ -2053.05,-626.67,2.31,113.39 },
	{ -2062.58,-596.05,3.03,45.36 },
	{ -2096.8,-579.13,2.75,53.86 },
	{ -2116.49,-559.09,2.29,48.19 },
	{ -2093.8,-539.57,3.74,22.68 },
	{ -2067.11,-526.37,6.98,328.82 },
	{ -2049.71,-516.4,9.13,308.98 },
	{ -2029.87,-507.17,11.49,300.48 },
	{ -2049.27,-492.94,11.17,11.34 },
	{ -2073.38,-483.05,9.13,42.52 },
	{ -2102.99,-470.71,6.52,56.7 },
	{ -2119.62,-451.87,6.67,48.19 },
	{ -2134.43,-460.37,5.24,93.55 },
	{ -1805.06,-936.1,2.53,189.93 },
	{ -1786.4,-932.99,4.38,269.3},
	{ -1744.87,-926.96,7.65,269.3 },
	{ -1763.18,-925.72,6.99,104.89 },
	{ -1773.65,-895.76,7.35,357.17 },
	{ -1750.28,-883.7,7.75,277.8 },
	{ -1733.24,-862.29,8.17,311.82 },
	{ -1703.01,-838.56,9.03,300.48 },
	{ -1720.85,-834.19,8.95,31.19 },
	{ -1747.12,-839.86,8.39,138.9 },
	{ -1764.27,-856.95,7.75,147.41 },
	{ -1776.27,-868.44,7.78,119.06 },
	{ -1803.86,-872.72,5.34,93.55 },
	{ -1744.12,-901.55,7.7,79.38 },
	{ -1765.09,-808.12,8.58,31.19 },
	{ -1773.17,-728.07,10.01,8.51 },
	{ -1849.14,-729.09,8.85,136.07 },
	{ -1866.65,-758.66,6.96,150.24 },
	{ -1886.42,-794.12,3.25,158.75 },
	{ -1795.97,-748.07,9.17,297.64 },
	{ -1915.8,-682.79,8.0,62.37 },
	{ -1911.86,-651.71,10.26,0.0 },
	{ -1899.29,-623.49,11.34,345.83 },
	{ -1847.11,-670.69,10.45,17.01 },
	{ -1874.69,-647.34,10.92,39.69 },
	{ -1958.9,-629.78,8.34,73.71 },
	{ -1951.39,-575.59,11.53,343.0 },
	{ -1991.28,-569.55,10.72,164.41 },
	{ -2056.68,-569.32,4.57,99.22 },
	{ -2088.29,-560.62,3.27,87.88 },
	{ -2042.45,-542.51,8.46,308.98 },
	{ -2020.91,-528.58,11.12,306.15 },
	{ -2092.91,-499.58,5.37,79.38 },
	{ -2113.6,-521.59,2.27,147.41 },
	{ -2139.09,-496.06,2.27,48.19 },
	{ -2122.44,-486.23,3.56,280.63 },
	{ -2034.27,-577.42,6.74,294.81 },
	{ -2003.72,-536.62,11.78,320.32 },
	{ -2023.41,-551.31,9.59,255.12 },
	{ -2014.0,-626.04,3.76,189.93 },
	{ -1967.67,-656.53,5.24,255.12 },
	{ -1878.77,-672.36,9.76,257.96 },
	{ -1827.96,-702.26,9.67,240.95 },
	{ -1855.87,-771.67,6.94,164.41 },
	{ -1846.08,-830.98,3.79,175.75 },
	{ -1830.72,-804.5,6.67,334.49 },
	{ -1770.76,-835.92,7.84,311.82 },
	{ -1724.61,-812.2,9.25,303.31 },
	{ -1828.9,-719.11,9.3,65.2 },
	{ -1893.81,-707.65,7.73,110.56 },
	{ -1921.84,-716.82,5.22,212.6 },
	{ -1891.7,-756.03,4.95,218.27 },
	{ -1890.51,-818.0,2.95,303.31 },
	{ -1806.69,-770.32,8.29,306.15 },
	{ -1763.57,-747.01,9.81,303.31 },
	{ -1980.27,-691.34,3.02,189.93 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local amountCoords = 0
	repeat
		amountCoords = amountCoords + 1
		local rand = math.random(#scanCoords)
		scanTable[amountCoords] = scanCoords[rand]
		Citizen.Wait(1)
	until amountCoords == 25
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANNERCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateScanner")
AddEventHandler("inventory:updateScanner",function(status)
	userScanner = status
	soundScanner = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if userScanner then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)

				for k,v in pairs(scanTable) do
					local distance = #(coords - vector3(v[1],v[2],v[3]))
					if distance <= 7.25 then
						soundScanner = 1000

						if initSounds[k] == nil then
							initSounds[k] = true
						end

						if distance <= 1.25 then
							timeDistance = 1
							soundScanner = 250

							if IsControlJustPressed(1,38) and MumbleIsConnected() then
								TriggerServerEvent("inventory:makeProducts",{},"scanner")

								local rand = math.random(#scanCoords)
								scanTable[k] = scanCoords[rand]
								initSounds[k] = nil
								soundScanner = 999
							end
						end
					else
						if initSounds[k] then
							initSounds[k] = nil
							soundScanner = 999
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNERSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if userScanner and (soundScanner == 1000 or soundScanner == 250) then
			PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET")
		end

		Citizen.Wait(soundScanner)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local boxList = {
	{ 594.43,146.51,97.31,"Medic" },
	{ 660.57,268.11,102.06,"Medic" },
	{ 552.50,-197.71,53.76,"Medic" },
	{ 339.64,-581.13,73.44,"Medic" },
	{ 696.06,-966.19,23.26,"Medic" },
	{ 1152.45,-1531.43,34.66,"Medic" },
	{ 1382.03,-2081.88,51.28,"Medic" },
	{ 589.08,-2802.64,5.34,"Medic" },
	{ -452.97,-2810.19,6.59,"Medic" },
	{ -1007.09,-2835.14,13.22,"Medic" },
	{ -2018.03,-361.23,47.41,"Medic" },
	{ -1727.11,250.50,61.67,"Medic" },
	{ -1089.41,2717.06,18.35,"Medic" },
	{ 322.07,2870.01,44.33,"Medic" },
	{ 1162.30,2722.15,37.31,"Medic" },
	{ 1745.07,3325.18,40.41,"Medic" },
	{ 2013.45,3934.56,31.65,"Medic" },
	{ 2526.61,4191.89,44.57,"Medic" },
	{ 2874.13,4861.62,61.49,"Medic" },
	{ 1985.15,6200.30,41.32,"Medic" },
	{ 1549.42,6613.58,2.15,"Medic" },
	{ -300.29,6390.89,29.89,"Medic" },
	{ -815.19,5384.08,33.79,"Medic" },
	{ -1613.17,5262.20,3.25,"Medic" },
	{ -199.71,3638.30,63.72,"Medic" },
	{ -1487.49,2688.97,2.96,"Medic" },
	{ -3266.54,1139.91,1.95,"Medic" },
	{ 574.19,132.92,98.45,"Weapons" },
	{ 344.74,929.16,202.43,"Weapons" },
	{ -123.21,1896.61,196.31,"Weapons" },
	{ -1097.20,2705.98,21.97,"Weapons" },
	{ -2198.33,4242.54,46.92,"Weapons" },
	{ -1486.84,4983.19,62.66,"Weapons" },
	{ 1345.95,6396.18,32.39,"Weapons" },
	{ 2535.65,4661.52,33.06,"Weapons" },
	{ 1166.19,-1339.58,35.07,"Weapons" },
	{ 1112.41,-2500.32,32.34,"Weapons" },
	{ 259.26,-3113.36,4.80,"Weapons" },
	{ -1621.63,-1037.19,12.13,"Weapons" },
	{ -3421.65,974.54,10.89,"Weapons" },
	{ -1910.37,4624.45,56.06,"Weapons" },
	{ 895.66,3212.04,40.52,"Weapons" },
	{ 1802.75,4604.32,36.65,"Weapons" },
	{ 443.32,6456.24,27.68,"Weapons" },
	{ 64.84,6320.81,37.85,"Weapons" },
	{ -748.40,5595.82,40.64,"Weapons" },
	{ -2683.33,2303.38,20.84,"Supplies" },
	{ -2687.00,2304.36,20.84,"Supplies" },
	{ -1282.21,2559.87,17.36,"Supplies" },
	{ 160.43,3119.01,42.39,"Supplies" },
	{ 1062.20,3527.83,33.13,"Supplies" },
	{ 2364.56,3154.49,47.20,"Supplies" },
	{ 2521.62,2637.86,36.94,"Supplies" },
	{ 2572.34,477.76,107.68,"Supplies" },
	{ 1206.30,-1089.56,39.24,"Supplies" },
	{ 1039.79,-244.01,67.28,"Supplies" },
	{ 499.27,-530.36,23.73,"Supplies" },
	{ 592.17,-2114.34,4.75,"Supplies" },
	{ 513.09,-2584.10,13.34,"Supplies" },
	{ -2.98,-1299.73,28.26,"Supplies" },
	{ 182.61,-1086.84,28.26,"Supplies" },
	{ 712.27,-852.63,23.24,"Supplies" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBOXES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(boxList) do
		exports["target"]:AddCircleZone("Boxes:"..k,vector3(v[1],v[2],v[3]),1.0,{
			name = "Boxes:"..k,
			heading = 3374176,
			useZ = true
		},{
			shop = k,
			distance = 1.5,
			options = {
				{
					event = "inventory:lootSystem",
					label = "Abrir",
					tunnel = "boxes",
					service = v[4]
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop",function(resource)
	TriggerServerEvent("vRP:Print","pausou o resource "..resource)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:removeTyres")
AddEventHandler("inventory:removeTyres",function(Entity)
	if GetVehicleDoorLockStatus(Entity[3]) == 1 then
		if Weapon == "WEAPON_WRENCH" then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			for k,Tyre in pairs(tyreList) do
				local Selected = GetEntityBoneIndexByName(Entity[3],k)
				if Selected ~= -1 then
					local coordsWheel = GetWorldPositionOfEntityBone(Entity[3],Selected)
					local distance = #(coords - coordsWheel)
					if distance <= 1.0 then
						TriggerServerEvent("inventory:removeTyres",Entity,Tyre)
					end
				end
			end
		else
			TriggerEvent("Notify","amarelo","<b>Chave Inglesa</b> não encontrada.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres",function(vehNet,vehPlate,Tyre)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tyreStatus()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local Vehicle = vRP.nearVehicle(5)
		local coords = GetEntityCoords(ped)

		for k,Tyre in pairs(tyreList) do
			local Selected = GetEntityBoneIndexByName(Vehicle,k)
			if Selected ~= -1 then
				local coordsWheel = GetWorldPositionOfEntityBone(Vehicle,Selected)
				local distance = #(coords - coordsWheel)
				if distance <= 1.0 then
					return true,Tyre,VehToNet(Vehicle),GetVehicleNumberPlateText(Vehicle)
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tyreHealth(vehNet,Tyre)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle,Tyre)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local StealPeds = {}
local StealTimer = GetGameTimer()