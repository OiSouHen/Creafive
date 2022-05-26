-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCLEARVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryClearVehicle")
AddEventHandler("tryClearVehicle",function(entIndex)
	local Vehicle = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
		SetVehicleDirtLevel(Vehicle,0.0)
	end
end)