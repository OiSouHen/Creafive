local volumes = {
	["radio"] = 0.6,
	["phone"] = 0.6
}

mode = 2
radioPressed = false
radioEnabled = false
radioData = {}
callData = {}

function setVolume(volume,volumeType)
	type_check({ volume, "number" })
	local volume = volume

	volume = volume / 100

	if volumeType then
		local volumeTbl = volumes[volumeType]
		if volumeTbl then
			LocalPlayer.state:set(volumeType,volume,true)
			volumes[volumeType] = volume
		end
	else
		for _type,vol in pairs(volumes) do
			volumes[_type] = volume
			LocalPlayer.state:set(_type,volume,true)
		end
	end
end

exports("setRadioVolume",function(vol)
	setVolume(vol,"radio")
end)

exports("getRadioVolume",function()
	return volumes["radio"]
end)

exports("setCallVolume",function(vol)
	setVolume(vol,"phone")
end)

exports("getCallVolume",function()
	return volumes["phone"]
end)

local radioEffectId = CreateAudioSubmix("Radio")
SetAudioSubmixEffectRadioFx(radioEffectId,0)
SetAudioSubmixEffectParamInt(radioEffectId,0,GetHashKey("default"),1)
AddAudioSubmixOutput(radioEffectId,0)

local phoneEffectId = CreateAudioSubmix("Phone")
SetAudioSubmixEffectRadioFx(phoneEffectId,1)
SetAudioSubmixEffectParamInt(phoneEffectId,1,GetHashKey("default"),1)
SetAudioSubmixEffectParamFloat(phoneEffectId,1,GetHashKey("freq_low"),300.0)
SetAudioSubmixEffectParamFloat(phoneEffectId,1,GetHashKey("freq_hi"),6000.0)
AddAudioSubmixOutput(phoneEffectId,1)

local submixFunctions = {
	["radio"] = function(plySource)
		MumbleSetSubmixForServerId(plySource,radioEffectId)
	end,
	["phone"] = function(plySource)
		MumbleSetSubmixForServerId(plySource,phoneEffectId)
	end
}

local disableSubmixReset = {}
function toggleVoice(plySource,enabled,moduleType)
	if enabled then
		MumbleSetVolumeOverrideByServerId(plySource,enabled and volumes[moduleType])
		if moduleType then
			disableSubmixReset[plySource] = true
			submixFunctions[moduleType](plySource)
		else
			MumbleSetSubmixForServerId(plySource,-1)
		end
	else
		disableSubmixReset[plySource] = nil

		SetTimeout(250,function()
			if not disableSubmixReset[plySource] then
				MumbleSetSubmixForServerId(plySource,-1)
			end
		end)

		MumbleSetVolumeOverrideByServerId(plySource,-1.0)
	end
end

function playerTargets(...)
	local targets = {...}
	local addedPlayers = {
		[playerServerId] = true
	}

	for i = 1,#targets do
		for id,_ in pairs(targets[i]) do
			if addedPlayers[id] and id ~= playerServerId then
				goto skip_loop
			end

			if not addedPlayers[id] then
				addedPlayers[id] = true
				MumbleAddVoiceTargetPlayerByServerId(voiceTarget,id)
			end

			::skip_loop::
		end
	end
end

function playMicClicks(clickType)
	if micClicks ~= "true" then
		return
	end

	sendUIMessage({
		sound = (clickType and "audio_on" or "audio_off"),
		volume = (clickType and (volumes["radio"]) or 0.05)
	})
end

function setVoiceProperty(type,value)
	if type == "radioEnabled" then
		radioEnabled = value
		sendUIMessage({ radioEnabled = value })
	elseif type == "micClicks" then
		local val = tostring(value)
		micClicks = val
		SetResourceKvp("pma-voice_enableMicClicks",val)
	end
end

exports("setVoiceProperty",setVoiceProperty)
exports("SetMumbleProperty",setVoiceProperty)
exports("SetTokoProperty",setVoiceProperty)