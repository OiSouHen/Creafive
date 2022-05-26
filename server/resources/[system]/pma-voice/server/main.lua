voiceData = {}
radioData = {}
callData = {}

function defaultTable(source)
	handleStateBagInitilization(source)

	return {
		radio = 0,
		call = 0,
		lastRadio = 0,
		lastCall = 0
	}
end

function handleStateBagInitilization(source)
	local plyState = Player(source).state
	if not plyState.pmaVoiceInit then 
		plyState:set("radio",0.6,true)
		plyState:set("phone",0.6,true)
		plyState:set("proximity",{},true)
		plyState:set("callChannel",0,true)
		plyState:set("radioChannel",0,true)
		plyState:set("voiceIntent","speech",true)
		plyState:set("pmaVoiceInit",true,false)
	end
end

Citizen.CreateThreadNow(function()
	local plyTbl = GetPlayers()
	for i = 1,#plyTbl do
		local ply = tonumber(plyTbl[i])
		voiceData[ply] = defaultTable(plyTbl[i])
	end

	SetConvarReplicated("voice_useNativeAudio","true")
	SetConvarReplicated("voice_useSendingRangeOnly","true")
end)

AddEventHandler("playerJoining",function()
	if not voiceData[source] then
		voiceData[source] = defaultTable(source)
	end
end)

AddEventHandler("playerDropped",function()
	local source = source
	if voiceData[source] then
		local plyData = voiceData[source]

		if plyData.radio ~= 0 then
			removePlayerFromRadio(source,plyData.radio)
		end

		if plyData.call ~= 0 then
			removePlayerFromCall(source,plyData.call)
		end

		voiceData[source] = nil
	end
end)

exports("isValidPlayer",function(source)
	return voiceData[source]
end)

function getPlayersInRadioChannel(channel)
	local returnChannel = radioData[channel]
	if returnChannel then
		return returnChannel
	end

	return {}
end
exports("getPlayersInRadioChannel",getPlayersInRadioChannel)
exports("GetPlayersInRadioChannel",getPlayersInRadioChannel)