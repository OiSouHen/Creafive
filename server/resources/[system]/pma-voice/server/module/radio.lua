local radioChecks = {}

function canJoinChannel(source,radioChannel)
	if radioChecks[radioChannel] then
		return radioChecks[radioChannel](source)
	end

	return true
end

function addChannelCheck(channel,cb)
	radioChecks[channel] = cb
end
exports("addChannelCheck",addChannelCheck)

local function radioNameGetter_orig(source)
	return GetPlayerName(source)
end
local radioNameGetter = radioNameGetter_orig

function overrideRadioNameGetter(channel,cb)
	local cbType = type(cb)
	radioNameGetter = cb
end
exports("overrideRadioNameGetter",overrideRadioNameGetter)

function addPlayerToRadio(source,radioChannel)
	if not canJoinChannel(source,radioChannel) then
		return TriggerClientEvent("pma-voice:removePlayerFromRadio",source,source)
	end

	radioData[radioChannel] = radioData[radioChannel] or {}
	local plyName = radioNameGetter(source)
	for player,_ in pairs(radioData[radioChannel]) do
		TriggerClientEvent("pma-voice:addPlayerToRadio",player,source,plyName)
	end

	voiceData[source] = voiceData[source] or defaultTable(source)

	voiceData[source].radio = radioChannel
	radioData[radioChannel][source] = false
	TriggerClientEvent("pma-voice:syncRadioData",source,radioData[radioChannel],plyName)
end

function removePlayerFromRadio(source, radioChannel)
	radioData[radioChannel] = radioData[radioChannel] or {}
	for player,_ in pairs(radioData[radioChannel]) do
		TriggerClientEvent("pma-voice:removePlayerFromRadio",player,source)
	end

	radioData[radioChannel][source] = nil
	voiceData[source] = voiceData[source] or defaultTable(source)
	voiceData[source].radio = 0
end

function setPlayerRadio(source,_radioChannel)
	voiceData[source] = voiceData[source] or defaultTable(source)
	local isResource = GetInvokingResource()
	local plyVoice = voiceData[source]
	local radioChannel = tonumber(_radioChannel)

	if not radioChannel then
		if not isResource then
			return
		end
	end

	if isResource then
		TriggerClientEvent("pma-voice:clSetPlayerRadio",source,radioChannel)
	end

	Player(source).state.radioChannel = radioChannel

	if radioChannel ~= 0 and plyVoice.radio == 0 then
		addPlayerToRadio(source,radioChannel)
	elseif radioChannel == 0 then
		removePlayerFromRadio(source,plyVoice.radio)
	elseif plyVoice.radio > 0 then
		removePlayerFromRadio(source,plyVoice.radio)
		addPlayerToRadio(source,radioChannel)
	end
end
exports("setPlayerRadio",setPlayerRadio)

RegisterNetEvent("pma-voice:setPlayerRadio",function(radioChannel)
	setPlayerRadio(source,radioChannel)
end)

function setTalkingOnRadio(talking)
	voiceData[source] = voiceData[source] or defaultTable(source)
	local plyVoice = voiceData[source]
	local radioTbl = radioData[plyVoice.radio]
	if radioTbl then
		radioTbl[source] = talking
		for player,_ in pairs(radioTbl) do
			if player ~= source then
				TriggerClientEvent("pma-voice:setTalkingOnRadio",player,source,talking)
			end
		end
	end
end
RegisterNetEvent("pma-voice:setTalkingOnRadio",setTalkingOnRadio)

AddEventHandler("onResourceStop",function(resource)
	for channel,cfxFunctionRef in pairs(radioChecks) do
		local functionRef = cfxFunctionRef.__cfx_functionReference
		local functionResource = string.match(functionRef,resource)
		if functionResource then
			radioChecks[channel] = nil
		end
	end

	if type(radioNameGetter) == "table" then
		local radioRef = radioNameGetter.__cfx_functionReference
		if radioRef then
			local isResource = string.match(functionRef,resource)
			if isResource then
				radioNameGetter = radioNameGetter_orig
			end
		end
	end
end)