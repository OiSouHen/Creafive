-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local uObject = nil
local uPoint = false
local animDict = nil
local animName = nil
local crouch = false
local walkSelect = nil
local animActived = false
local cdBtns = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Phone"] = false
LocalPlayer["state"]["Drunk"] = false
LocalPlayer["state"]["Cancel"] = false
LocalPlayer["state"]["Police"] = false
LocalPlayer["state"]["Paramedic"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:POLICESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:PoliceService")
AddEventHandler("vRP:PoliceService",function(status)
	LocalPlayer["state"]["Police"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PARAMEDICSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:ParamedicService")
AddEventHandler("vRP:ParamedicService",function(status)
	LocalPlayer["state"]["Paramedic"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Phone")
AddEventHandler("vRP:Phone",function(status)
	LocalPlayer["state"]["Phone"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Cancel")
AddEventHandler("vRP:Cancel",function(status)
	LocalPlayer["state"]["Cancel"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALKMODE
-----------------------------------------------------------------------------------------------------------------------------------------
local walkMode = {
	"move_m@alien","anim_group_move_ballistic","move_f@arrogant@a","move_m@brave","move_m@casual@a","move_m@casual@b","move_m@casual@c",
	"move_m@casual@d","move_m@casual@e","move_m@casual@f","move_f@chichi","move_m@confident","move_m@business@a","move_m@business@b",
	"move_m@business@c","move_m@drunk@a","move_m@drunk@slightlydrunk","move_m@buzzed","move_m@drunk@verydrunk","move_f@femme@",
	"move_characters@franklin@fire","move_characters@michael@fire","move_m@fire","move_f@flee@a","move_p_m_one","move_m@gangster@generic",
	"move_m@gangster@ng","move_m@gangster@var_e","move_m@gangster@var_f","move_m@gangster@var_i","anim@move_m@grooving@","move_f@heels@c",
	"move_m@hipster@a","move_m@hobo@a","move_f@hurry@a","move_p_m_zero_janitor","move_p_m_zero_slow","move_m@jog@","anim_group_move_lemar_alley",
	"move_heist_lester","move_f@maneater","move_m@money","move_m@posh@","move_f@posh@","move_m@quick","female_fast_runner","move_m@sad@a",
	"move_m@sassy","move_f@sassy","move_f@scared","move_f@sexy@a","move_m@shadyped@a","move_characters@jimmy@slow@","move_m@swagger",
	"move_m@tough_guy@","move_f@tough_guy@","move_p_m_two","move_m@bag","move_m@injured"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("andar",function(source,args,rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		local ped = PlayerPedId()

		if args[1] then
			local mode = parseInt(args[1])
			if walkMode[mode] then
				RequestAnimSet(walkMode[mode])
				while not HasAnimSetLoaded(walkMode[mode]) do
					Citizen.Wait(1)
				end

				SetPedMovementClipset(ped,walkMode[mode],0.25)
				walkSelect = walkMode[mode]
			end
		else
			ResetPedMovementClipset(ped,0.25)
			walkSelect = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] then
			timeDistance = 1
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,38,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,137,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMUMBLECONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if not MumbleIsConnected() then
			timeDistance = 1
			DisableControlAction(1,38,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,47,true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCELLPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if (LocalPlayer["state"]["Phone"] or animActived) and LocalPlayer["state"]["Active"] then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,68,true)
			DisableControlAction(1,70,true)
			DisableControlAction(1,91,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,143,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.request(id,text,accept,reject)
	SendNUIMessage({ act = "request", id = id, text = text, accept = accept, reject = reject })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUIPROMPT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("prompt",function(data)
	if data["act"] == "close" then
		SetNuiFocus(false,false)
		vRPS.promptResult(data["result"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROMPT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.prompt(title,text)
	SendNUIMessage({ act = "prompt", title = title, text = text })
	SetNuiFocus(true,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("request",function(data)
	if data["act"] == "response" then
		vRPS.requestResult(data["id"],data["ok"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIMSET
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.loadAnimSet(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.createObjects(newDict,newAnim,newProp,newFlag,newHands,newHeight,newPos1,newPos2,newPos3,newPos4,newPos5)
	if DoesEntityExist(uObject) then
		TriggerServerEvent("tryDeleteObject",ObjToNet(uObject))
		uObject = nil
	end

	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if newAnim ~= "" then
		tvRP.loadAnimSet(newDict)
		TaskPlayAnim(ped,newDict,newAnim,3.0,3.0,-1,newFlag,0,0,0,0)

		animActived = true
		animFlags = newFlag
		animDict = newDict
		animName = newAnim
	end

	local myObject,objNet = vRPS.CreateObject(newProp,coords["x"],coords["y"],coords["z"])
	if myObject then
		local spawnObjects = 0
		uObject = NetworkGetEntityFromNetworkId(objNet)
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

		if newHeight then
			AttachEntityToEntity(uObject,ped,GetPedBoneIndex(ped,newHands),newHeight,newPos1,newPos2,newPos3,newPos4,newPos5,true,true,false,true,1,true)
		else
			AttachEntityToEntity(uObject,ped,GetPedBoneIndex(ped,newHands),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		end

		SetEntityAsNoLongerNeeded(uObject)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if animActived and LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if not IsEntityPlayingAnim(ped,animDict,animName,3) then
				TaskPlayAnim(ped,animDict,animName,3.0,3.0,-1,animFlags,0,0,0,0)
				timeDistance = 1
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.removeObjects(status)
	if status == "one" then
		tvRP.stopAnim(true)
	elseif status == "two" then
		tvRP.stopAnim(false)
	else
		tvRP.stopAnim(true)
		tvRP.stopAnim(false)
	end

	animActived = false
	TriggerEvent("camera")
	TriggerEvent("binoculos")
	if DoesEntityExist(uObject) then
		TriggerServerEvent("tryDeleteObject",ObjToNet(uObject))
		uObject = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POINT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		if uPoint and LocalPlayer["state"]["Active"] then
			timeDistance = 1
			local ped = PlayerPedId()
			local camPitch = GetGameplayCamRelativePitch()

			if camPitch < -70.0 then
				camPitch = -70.0
			elseif camPitch > 42.0 then
				camPitch = 42.0
			end
			camPitch = (camPitch + 70.0) / 112.0

			local camHeading = GetGameplayCamRelativeHeading()
			local cosCamHeading = Cos(camHeading)
			local sinCamHeading = Sin(camHeading)
			if camHeading < -180.0 then
				camHeading = -180.0
			elseif camHeading > 180.0 then
				camHeading = 180.0
			end
			camHeading = (camHeading + 180.0) / 360.0

			local nn = 0
			local blocked = 0
			local coords = GetOffsetFromEntityInWorldCoords(ped,(cosCamHeading*-0.2)-(sinCamHeading*(0.4*camHeading+0.3)),(sinCamHeading*-0.2)+(cosCamHeading*(0.4*camHeading+0.3)),0.6)
			local ray = Cast_3dRayPointToPoint(coords["x"],coords["y"],coords["z"]-0.2,coords.x,coords.y,coords.z+0.2,0.4,95,ped,7);
			nn,blocked,coords,coords = GetRaycastResult(ray)

			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Pitch",camPitch)
			Citizen.InvokeNative(0xD5BB4025AE449A4E,ped,"Heading",camHeading * -1.0 + 1.0)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isBlocked",blocked)
			Citizen.InvokeNative(0xB0A6CFD2C69C1088,ped,"isFirstPerson",Citizen.InvokeNative(0xEE778F8C7E1142E2,Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELF6
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cRcancelf6",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns and LocalPlayer["state"]["Active"] and MumbleIsConnected() then
		cdBtns = GetGameTimer() + 1000

		local ped = PlayerPedId()
		if not IsPauseMenuActive() and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and GetEntityHealth(ped) > 101 and not LocalPlayer["state"]["Phone"] and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(ped) then
			TriggerServerEvent("inventory:Cancel")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cRhandsup",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedInAnyVehicle(ped) and not LocalPlayer["state"]["Phone"] and GetEntityHealth(ped) > 101 and not LocalPlayer["state"]["Cancel"] and LocalPlayer["state"]["Active"] and MumbleIsConnected() and not IsPedReloading(ped) then
		if IsEntityPlayingAnim(ped,"random@mugging3","handsup_standing_base",3) then
			StopAnimTask(ped,"random@mugging3","handsup_standing_base",2.0)
			tvRP.stopActived()
		else
			tvRP.playAnim(true,{"random@mugging3","handsup_standing_base"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cRpoint",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Cancel"] and not LocalPlayer["state"]["Phone"] and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 101 and LocalPlayer["state"]["Active"] and MumbleIsConnected() and not IsPedReloading(ped) then
		tvRP.loadAnimSet("anim@mp_point")

		if not uPoint then
			tvRP.stopActived()
			SetPedConfigFlag(ped,36,true)
			TaskMoveNetwork(ped,"task_mp_pointing",0.5,0,"anim@mp_point",24)
			uPoint = true
		else
			Citizen.InvokeNative(0xD01015C7316AE176,ped,"Stop")
			if not IsPedInjured(ped) then
				ClearPedSecondaryTask(ped)
			end

			SetPedConfigFlag(ped,36,false)
			ClearPedSecondaryTask(ped)
			uPoint = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIGARVEH / AGACHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cRenginecrouch",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns and LocalPlayer["state"]["Active"] and MumbleIsConnected() then
		cdBtns = GetGameTimer() + 1000

		local ped = PlayerPedId()
		if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(ped) > 101 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(ped) then
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsUsing(ped)
				if GetPedInVehicleSeat(vehicle,-1) == ped then
					tvRP.removeObjects("two")

					local running = GetIsVehicleEngineRunning(vehicle)
					SetVehicleEngineOn(vehicle,not running,true,true)
					if running then
						SetVehicleUndriveable(vehicle,true)
					else
						SetVehicleUndriveable(vehicle,false)
					end
				end
			elseif not LocalPlayer["state"]["Drunk"] then
				RequestAnimSet("move_ped_crouched")
				while not HasAnimSetLoaded("move_ped_crouched") do
					Citizen.Wait(1)
				end

				if crouch then
					ResetPedMovementClipset(ped,0.25)
					crouch = false

					if walkSelect ~= nil then
						RequestAnimSet(walkSelect)
						while not HasAnimSetLoaded(walkSelect) do
							Citizen.Wait(1)
						end

						SetPedMovementClipset(ped,walkSelect,0.25)
					end
				else
					SetPedMovementClipset(ped,"move_ped_crouched",0.25)
					crouch = true
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cRbind",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns and LocalPlayer["state"]["Active"] and MumbleIsConnected() then
		cdBtns = GetGameTimer() + 1000

		local ped = PlayerPedId()
		if not IsPauseMenuActive() and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Phone"] and GetEntityHealth(ped) > 101 and not LocalPlayer["state"]["Cancel"] and not IsPedReloading(ped) then
			if parseInt(args[1]) >= 1 and parseInt(args[1]) <= 5 then
				TriggerServerEvent("inventory:useItem",args[1],1)
			elseif args[1] == "6" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					if IsEntityPlayingAnim(ped,"anim@heists@heist_corona@single_team","single_team_loop_boss",3) then
						StopAnimTask(ped,"anim@heists@heist_corona@single_team","single_team_loop_boss",2.0)
						tvRP.stopActived()
					else
						tvRP.playAnim(true,{"anim@heists@heist_corona@single_team","single_team_loop_boss"},true)
					end
				end
			elseif args[1] == "7" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					if IsEntityPlayingAnim(ped,"mini@strip_club@idles@bouncer@base","base",3) then
						StopAnimTask(ped,"mini@strip_club@idles@bouncer@base","base",2.0)
						tvRP.stopActived()
					else
						tvRP.playAnim(true,{"mini@strip_club@idles@bouncer@base","base"},true)
					end
				end
			elseif args[1] == "8" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					if IsEntityPlayingAnim(ped,"anim@mp_player_intupperfinger","idle_a_fp",3) then
						StopAnimTask(ped,"anim@mp_player_intupperfinger","idle_a_fp",2.0)
						tvRP.stopActived()
					else
						tvRP.playAnim(true,{"anim@mp_player_intupperfinger","idle_a_fp"},true)
					end
				end
			elseif args[1] == "9" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					if IsEntityPlayingAnim(ped,"random@arrests@busted","idle_a",3) then
						StopAnimTask(ped,"random@arrests@busted","idle_a",2.0)
						tvRP.stopActived()
					else
						tvRP.playAnim(true,{"random@arrests@busted","idle_a"},true)
					end
				end
			elseif args[1] == "left" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					tvRP.playAnim(true,{"anim@mp_player_intupperthumbs_up","enter"},false)
				end
			elseif args[1] == "right" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					tvRP.playAnim(true,{"anim@mp_player_intcelebrationmale@face_palm","face_palm"},false)
				end
			elseif args[1] == "up" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					tvRP.playAnim(true,{"anim@mp_player_intcelebrationmale@salute","salute"},false)
				end
			elseif args[1] == "down" then
				if not IsPedInAnyVehicle(ped) and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
					tvRP.playAnim(true,{"rcmnigel1c","hailing_whistle_waive_a"},false)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCEPT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cRaccept",function(source,args,rawCommand)
	SendNUIMessage({ act = "event", event = "Y" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cRreject",function(source,args,rawCommand)
	SendNUIMessage({ act = "event", event = "U" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCKVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("lockVehicles",function(source,args,rawCommand)
	if GetGameTimer() >= cdBtns and LocalPlayer["state"]["Active"] and MumbleIsConnected() then
		cdBtns = GetGameTimer() + 1000

		local ped = PlayerPedId()
		if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPedSwimming(ped) and GetEntityHealth(ped) > 101 and not IsPedReloading(ped) then
			local vehicle,vehNet,vehPlate = tvRP.vehList(5)
			if vehicle then
				TriggerServerEvent("garages:lockVehicle",vehNet,vehPlate)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("cRcancelf6","Cancelar todas as ações.","keyboard","F6")
RegisterKeyMapping("cRhandsup","Levantar as mãos.","keyboard","X")
RegisterKeyMapping("cRpoint","Apontar os dedos.","keyboard","B")
RegisterKeyMapping("cRenginecrouch","Agachar/Ligar o veículo.","keyboard","Z")
RegisterKeyMapping("cRbind 1","Interação do botão 1.","keyboard","1")
RegisterKeyMapping("cRbind 2","Interação do botão 2.","keyboard","2")
RegisterKeyMapping("cRbind 3","Interação do botão 3.","keyboard","3")
RegisterKeyMapping("cRbind 4","Interação do botão 4.","keyboard","4")
RegisterKeyMapping("cRbind 5","Interação do botão 5.","keyboard","5")
RegisterKeyMapping("cRbind 6","Interação do botão 6.","keyboard","6")
RegisterKeyMapping("cRbind 7","Interação do botão 7.","keyboard","7")
RegisterKeyMapping("cRbind 8","Interação do botão 8.","keyboard","8")
RegisterKeyMapping("cRbind 9","Interação do botão 9.","keyboard","9")
RegisterKeyMapping("cRbind left","Interação da seta esquerda.","keyboard","LEFT")
RegisterKeyMapping("cRbind right","Interação da seta direita.","keyboard","RIGHT")
RegisterKeyMapping("cRbind up","Interação da seta pra cima.","keyboard","UP")
RegisterKeyMapping("cRbind down","Interação da seta pra baixo.","keyboard","DOWN")
RegisterKeyMapping("cRaccept","Aceitar as notificações.","keyboard","Y")
RegisterKeyMapping("cRreject","Rejeitar as notificações.","keyboard","U")
RegisterKeyMapping("lockVehicles","Trancar/Destrancar o veículo.","keyboard","L")