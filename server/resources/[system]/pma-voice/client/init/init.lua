AddEventHandler("onClientResourceStart",function(resource)
	if resource ~= GetCurrentResourceName() then
		return
	end

	local success = pcall(function()
		local micClicksKvp = GetResourceKvpString("pma-voice_enableMicClicks")
		if not micClicksKvp then
			SetResourceKvp("pma-voice_enableMicClicks","true")
		else
			micClicks = micClicksKvp
		end
	end)

	if not success then
		SetResourceKvp("pma-voice_enableMicClicks","true")
		micClicks = "true"
	end

	sendUIMessage({ uiEnabled = true, voiceModes = json.encode(Cfg.voiceModes), voiceMode = mode - 1 })

	if LocalPlayer.state.radioChannel ~= 0 then
		setRadioChannel(LocalPlayer.state.radioChannel)
	end

	if LocalPlayer.state.callChannel ~= 0 then
		setCallChannel(LocalPlayer.state.callChannel)
	end
end)