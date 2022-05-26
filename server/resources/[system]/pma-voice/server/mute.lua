RegisterServerEvent("pma-voice:toggleMute")
AddEventHandler("pma-voice:toggleMute",function(status)
	local source = source
	if exports["pma-voice"]:isValidPlayer(source) then
		MumbleSetPlayerMuted(source,status)
	end
end)