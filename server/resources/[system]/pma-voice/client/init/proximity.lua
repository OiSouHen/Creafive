local disableUpdates = false
local isListenerEnabled = false
local plyCoords = GetEntityCoords(PlayerPedId())

function orig_addProximityCheck(ply)
	local tgtPed = GetPlayerPed(ply)
	local voiceModeData = Cfg.voiceModes[mode]
	local distance = voiceModeData[1]

	return #(plyCoords - GetEntityCoords(tgtPed)) < distance
end
local addProximityCheck = orig_addProximityCheck

exports("overrideProximityCheck",function(fn)
	addProximityCheck = fn
end)

exports("resetProximityCheck",function()
	addProximityCheck = orig_addProximityCheck
end)

function addNearbyPlayers()
	if disableUpdates then
		return
	end

	local ped = PlayerPedId()
	plyCoords = GetEntityCoords(ped)
	local distance = Cfg.voiceModes[mode][1]
	MumbleClearVoiceTargetChannels(voiceTarget)

	local players = GetActivePlayers()
	for i = 1,#players do
		local ply = players[i]
		local serverId = GetPlayerServerId(ply)

		if serverId == playerServerId then
			goto skip_loop
		end

		if addProximityCheck(ply) then
			if isTarget then goto skip_loop end
			MumbleAddVoiceTargetChannel(voiceTarget,serverId)
		end

		::skip_loop::
	end
end

function setSpectatorMode(enabled)
	isListenerEnabled = enabled
	local players = GetActivePlayers()
	if isListenerEnabled then
		for i = 1,#players do
			local ply = players[i]
			local serverId = GetPlayerServerId(ply)
			if serverId == playerServerId then
				goto skip_loop
			end

			MumbleAddVoiceChannelListen(serverId)

			::skip_loop::
		end
	else
		for i = 1,#players do
			local ply = players[i]
			local serverId = GetPlayerServerId(ply)

			if serverId == playerServerId then
				goto skip_loop
			end

			MumbleRemoveVoiceChannelListen(serverId)

			::skip_loop::
		end
	end
end

RegisterNetEvent("onPlayerJoining",function(serverId)
	if isListenerEnabled then
		MumbleAddVoiceChannelListen(serverId)
	end
end)

RegisterNetEvent("onPlayerDropped",function(serverId)
	if isListenerEnabled then
		MumbleRemoveVoiceChannelListen(serverId)
	end
end)

local lastRadioStatus = false
local lastTalkingStatus = false
local voiceState = "proximity"

Citizen.CreateThread(function()
	while true do
		while not MumbleIsConnected() do
			Wait(100)
		end

		local curTalkingStatus = MumbleIsPlayerTalking(PlayerId()) == 1

		if lastRadioStatus ~= radioPressed or lastTalkingStatus ~= curTalkingStatus then
			lastRadioStatus = radioPressed
			lastTalkingStatus = curTalkingStatus
		end

		if voiceState == "proximity" then
			addNearbyPlayers()
			local isSpectating = NetworkIsInSpectatorMode()
			if isSpectating and not isListenerEnabled then
				setSpectatorMode(true)
			elseif not isSpectating and isListenerEnabled then
				setSpectatorMode(false)
			end
		end

		Wait(200)
	end
end)

exports("setVoiceState",function(_voiceState,channel)
	voiceState = _voiceState
	if voiceState == "channel" then
		type_check({ channel,"number" })
		channel = channel + 65535
		MumbleSetVoiceChannel(channel)

		while MumbleGetVoiceChannelFromServerId(playerServerId) ~= channel do
			Wait(250)
		end

		MumbleAddVoiceTargetChannel(voiceTarget,channel)
	elseif voiceState == "proximity" then
		handleInitialState()
	end
end)

AddEventHandler("onClientResourceStop",function(resource)
	if type(addProximityCheck) == "table" then
		local proximityCheckRef = addProximityCheck.__cfx_functionReference
		if proximityCheckRef then
			local isResource = string.match(proximityCheckRef,resource)
			if isResource then
				addProximityCheck = orig_addProximityCheck
			end
		end
	end
end)