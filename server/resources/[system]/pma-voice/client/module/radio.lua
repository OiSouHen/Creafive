local radioChannel = 0
local radioNames = {}

function syncRadioData(radioTable,localPlyRadioName)
	radioData = radioTable

	for tgt,enabled in pairs(radioTable) do
		if tgt ~= playerServerId then
			toggleVoice(tgt,enabled,"radio")
		end
	end

	radioNames[playerServerId] = localPlyRadioName
end

RegisterNetEvent("pma-voice:syncRadioData",syncRadioData)

function setTalkingOnRadio(plySource,enabled)
	toggleVoice(plySource,enabled,"radio")
	radioData[plySource] = enabled
end

RegisterNetEvent("pma-voice:setTalkingOnRadio",setTalkingOnRadio)

function addPlayerToRadio(plySource,plyRadioName)
	radioData[plySource] = false
	radioNames[plySource] = plyRadioName
	if radioPressed then
		playerTargets(radioData,MumbleIsPlayerTalking(PlayerId()) and callData or {})
	end
end

RegisterNetEvent("pma-voice:addPlayerToRadio",addPlayerToRadio)

function removePlayerFromRadio(plySource)
	if plySource == playerServerId then
		for tgt,_ in pairs(radioData) do
			if tgt ~= playerServerId then
				toggleVoice(tgt,false,"radio")
			end
		end

		radioNames = {}
		radioData = {}
		playerTargets(MumbleIsPlayerTalking(PlayerId()) and callData or {})
	else
		toggleVoice(plySource,false)

		if radioPressed then
			playerTargets(radioData,MumbleIsPlayerTalking(PlayerId()) and callData or {})
		end

		radioData[plySource] = nil
		radioNames[plySource] = nil
	end
end

RegisterNetEvent("pma-voice:removePlayerFromRadio",removePlayerFromRadio)

function setRadioChannel(channel)
	radioEnabled = true
	type_check({ channel,"number" })
	TriggerServerEvent("pma-voice:setPlayerRadio",channel)
	radioChannel = channel

	sendUIMessage({ radioChannel = channel, radioEnabled = radioEnabled })
end

exports("setRadioChannel",setRadioChannel)
exports("SetRadioChannel",setRadioChannel)

exports("removePlayerFromRadio",function()
	radioEnabled = false
	setRadioChannel(0)
end)

exports("addPlayerToRadio",function(_radio)
	local radio = tonumber(_radio)
	if radio then
		setRadioChannel(radio)
	end
end)

RegisterCommand("+radiotalk",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if IsPedSwimming(ped) or LocalPlayer["state"]["Handcuff"] or IsPlayerFreeAiming(PlayerId()) or not MumbleIsConnected() then
		return
	end

	if not radioPressed and radioEnabled then
		if radioChannel > 0 then
			playerTargets(radioData,MumbleIsPlayerTalking(PlayerId()) and callData or {})
			TriggerServerEvent("pma-voice:setTalkingOnRadio",true)
			radioPressed = true
			playMicClicks(true)

			RequestAnimDict("random@arrests")
			while not HasAnimDictLoaded("random@arrests") do
				Citizen.Wait(1)
			end
			TaskPlayAnim(ped,"random@arrests","generic_radio_chatter",8.0,0.0,-1,49,0,0,0,0)

			Citizen.CreateThread(function()
				TriggerEvent("pma-voice:radioActive",true)

				while radioPressed do
					Wait(0)
					SetControlNormal(0,249,1.0)
					SetControlNormal(1,249,1.0)
					SetControlNormal(2,249,1.0)
					DisableControlAction(1,24,true)
					DisableControlAction(1,25,true)
					DisableControlAction(1,257,true)
					DisableControlAction(1,140,true)
					DisableControlAction(1,142,true)
				end
			end)
		end
	end
end,false)

RegisterCommand("-radiotalk",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if IsPedSwimming(ped) or LocalPlayer["state"]["Handcuff"] or IsPlayerFreeAiming(PlayerId()) or not MumbleIsConnected() then
		return
	end

	if radioChannel > 0 or radioEnabled and radioPressed then
		radioPressed = false
		MumbleClearVoiceTargetPlayers(voiceTarget)
		playerTargets(MumbleIsPlayerTalking(PlayerId()) and callData or {})
		TriggerEvent("pma-voice:radioActive",false)
		playMicClicks(false)

		StopAnimTask(ped,"random@arrests","generic_radio_chatter",-4.0)
		TriggerServerEvent("pma-voice:setTalkingOnRadio",false)
	end
end,false)

RegisterKeyMapping("+radiotalk","Dialogar no rádio.","keyboard","CAPITAL")

function syncRadio(_radioChannel)
	radioChannel = _radioChannel
end

RegisterNetEvent("pma-voice:clSetPlayerRadio",syncRadio)

local uiReady = promise.new()
function sendUIMessage(message)
	Citizen.Await(uiReady)
	SendNUIMessage(message)
end

RegisterNUICallback("uiReady",function(data,cb)
	uiReady:resolve(true)

	cb("ok")
end)