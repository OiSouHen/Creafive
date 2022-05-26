-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local engineDelta = 0.0
local engineScaled = 0.0
local engineNew = 1000.0
local engineLast = 1000.0
local engineCurrent = 1000.0
-----------------------------------------------------------------------------------------------------------------------------------------
-- BODYABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local bodyDelta = 0.0
local bodyScaled = 0.0
local bodyNew = 1000.0
local bodyLast = 1000.0
local bodyCurrent = 1000.0
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local lastVehicle = nil
local sameVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSDAMAGE
-----------------------------------------------------------------------------------------------------------------------------------------
local classDamage = { 1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.0,1.5,1.5,1.5,1.5,0.0,0.0,1.5,1.5,1.5,1.5,1.5,1.5,1.5 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHVEH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehClass = GetVehicleClass(vehicle)
			if vehClass ~= 13 and vehClass ~= 14 then
				timeDistance = 1

				if sameVehicle then
					local engineTorque = 1.0
					if engineNew < 900 then
						engineTorque = (engineNew + 200.0) / 1100
					end

					SetVehicleEngineTorqueMultiplier(vehicle,engineTorque)
				end

				if GetPedInVehicleSeat(vehicle,-1) == ped then
					local vehRoll = GetEntityRoll(vehicle)
					if vehRoll > 75.0 or vehRoll < -75.0 then
						DisableControlAction(1,59,true)
						DisableControlAction(1,60,true)
					end
				end

				engineCurrent = GetVehicleEngineHealth(vehicle)
				if engineCurrent >= 1000 then
					engineLast = 1000.0
				end

				engineNew = engineCurrent
				engineDelta = engineLast - engineCurrent
				engineScaled = engineDelta * 0.6 * classDamage[vehClass + 1]

				bodyCurrent = GetVehicleBodyHealth(vehicle)
				if bodyCurrent >= 1000 then
					bodyLast = 1000.0
				end

				bodyNew = bodyCurrent
				bodyDelta = bodyLast - bodyCurrent
				bodyScaled = bodyDelta * 0.6 * classDamage[vehClass + 1]

				if engineCurrent > 101.0 and bodyCurrent > 101.0 then
					SetVehicleUndriveable(vehicle,false)
				end

				if engineCurrent <= 101.0 or bodyCurrent <= 101.0 then
					SetVehicleUndriveable(vehicle,true)
				end

				if vehicle ~= lastVehicle then
					sameVehicle = false
				end

				if sameVehicle then
					if engineCurrent ~= 1000.0 or bodyCurrent ~= 1000.0 then
						local engineCombine = math.max(engineScaled,bodyScaled)
						if engineCombine > (engineCurrent - 100.0) then
							engineCombine = engineCombine * 0.7
						end

						if engineCombine > engineCurrent then
							engineCombine = engineCurrent - (210.0 / 5)
						end
						engineNew = engineLast - engineCombine

						if engineNew > 210.0 and engineNew < 350.0 then
							engineNew = engineNew - (0.038 * 7.4)
						end

						if engineNew < 210.0 then
							engineNew = engineNew - (0.1 * 1.5)
						end

						if engineNew < 100.0 then
							engineNew = 100.0
						end

						if bodyNew < 0 then
							bodyNew = 0.0
						end
					end
				else
					if bodyCurrent < 100.0 then
						bodyNew = 100.0
					end

					if engineCurrent < 100.0 then
						engineNew = 100.0
					end

					sameVehicle = true
				end

				if engineNew ~= engineCurrent then
					SetVehicleEngineHealth(vehicle,engineNew)
				end

				if bodyNew ~= bodyCurrent then
					SetVehicleBodyHealth(vehicle,bodyNew)
				end

				SetVehiclePetrolTankHealth(vehicle,1000.0)

				bodyLast = bodyNew
				engineLast = engineNew
				lastVehicle = vehicle
			end
		else
			sameVehicle = false
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREEXPLOSION
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local Vehicle = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(Vehicle,-1) == ped then
				local vehRoll = GetEntityRoll(Vehicle)
				if vehRoll > 75.0 or vehRoll < -75.0 then
					if math.random(100) <= 50 and GetVehicleClass(Vehicle) ~= 8 then
						local Tyre = math.random(4)

						if Tyre == 1 then
							if GetTyreHealth(Vehicle,0) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,0,true,1000.0)
							end
						elseif Tyre == 2 then
							if GetTyreHealth(Vehicle,1) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,1,true,1000.0)
							end
						elseif Tyre == 3 then
							if GetTyreHealth(Vehicle,4) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,4,true,1000.0)
							end
						elseif Tyre == 4 then
							if GetTyreHealth(Vehicle,5) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,5,true,1000.0)
							end
						end
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)