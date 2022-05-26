-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("luckywheel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Wheel = nil
local Vehicle = nil
local Active = false
LocalPlayer["state"]["Cassino"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUCKYWHEEL:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("luckywheel:Active")
AddEventHandler("luckywheel:Active",function()
	if LocalPlayer["state"]["Cassino"] then
		Active = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCASSINO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vec3(1107.92,218.34,-49.44))
			if distance <= 25 then
				if not LocalPlayer["state"]["Cassino"] then
					LocalPlayer["state"]["Cassino"] = true

					local vehHash = GetHashKey("silvias15")
					local luckyHash = GetHashKey("vw_prop_vw_luckywheel_02a")

					RequestModel(vehHash)
					while not HasModelLoaded(vehHash) do
						Wait(10)
					end

					RequestModel(luckyHash)
					while not HasModelLoaded(luckyHash) do
						Wait(10)
					end

					Wheel = CreateObjectNoOffset(luckyHash,1111.05,229.85,-49.14,false,false,false)
					SetEntityHeading(Wheel,0.0)
					SetModelAsNoLongerNeeded(luckyHash)

					Vehicle = CreateVehicle(vehHash,1100.04,219.87,-47.75,200.0,false,false)
					SetVehicleNumberPlateText(Vehicle,"PDMSPORT")
					SetVehicleOnGroundProperly(Vehicle)
					FreezeEntityPosition(Vehicle,true)
					SetEntityInvincible(Vehicle,true)
					SetVehicleDoorsLocked(Vehicle,2)
					SetVehicleColours(Vehicle,29,1)
				end
			else
				if LocalPlayer["state"]["Cassino"] then
					LocalPlayer["state"]["Cassino"] = false

					DeleteEntity(Vehicle)
					Vehicle = nil

					DeleteEntity(Wheel)
					Wheel = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUCKYWHEEL:START
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("luckywheel:Start")
AddEventHandler("luckywheel:Start",function(Result)
	if Result ~= nil then
		if LocalPlayer["state"]["Cassino"] then
			if DoesEntityExist(Wheel) then
				SetEntityRotation(Wheel,0.0,0.0,0.0,1,true)
			end

			CreateThread(function()
				local rollingRatio = 1
				local rollingSpeed = 1.0
				local rollingAngle = (Result - 1) * 18
				local wheelAngles = rollingAngle + (360 * 8)
				local middleResult = (wheelAngles / 2)

				while rollingRatio > 0 do
					local xRot = GetEntityRotation(Wheel,1)
					if wheelAngles > middleResult then
						rollingRatio = rollingRatio + 1
					else
						rollingRatio = rollingRatio - 1

						if rollingRatio <= 0 then
							rollingRatio = 0

							if Active then
								TriggerServerEvent("luckywheel:Payment")
								Active = false
							end
						end
					end

					rollingSpeed = rollingRatio / 200
					local yRot = xRot["y"] - rollingSpeed
					wheelAngles = wheelAngles - rollingSpeed
					SetEntityRotation(Wheel,0.0,yRot,0.0,1,true)

					Wait(0)
				end
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETROLL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("luckywheel:Target")
AddEventHandler("luckywheel:Target",function()
	if LocalPlayer["state"]["Cassino"] then
		if vSERVER.checkRolling() then
			local ped = PlayerPedId()
			local aHash = "anim_casino_a@amb@casino@games@lucky7wheel@female"
			RequestAnimDict(aHash)
			while not HasAnimDictLoaded(aHash) do
				Wait(1)
			end

			local inMoviment = true
			local movePosition = vec3(1110.1,229.06,-49.64)
			TaskGoStraightToCoord(ped,movePosition["x"],movePosition["y"],movePosition["z"],1.0,-1,0.0,0.0)

			while inMoviment do
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)

				if coords["x"] >= (movePosition["x"] - 0.01) and coords["x"] <= (movePosition["x"] + 0.01) and coords["y"] >= (movePosition["y"] - 0.01) and coords["y"] <= (movePosition["y"] + 0.01) then
					inMoviment = false
				end

				Wait(0)
			end

			SetEntityHeading(ped,35.0)
			TriggerServerEvent("luckywheel:Starting")
			TaskPlayAnim(ped,aHash,"armraisedidle_to_spinningidle_high",8.0,-8.0,-1,0,0,false,false,false)

			Wait(2000)

			ClearPedTasks(ped)
		end
	end
end)