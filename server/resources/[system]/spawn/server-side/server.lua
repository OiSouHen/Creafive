-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("spawn",cRP)
vCLIENT = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local charActived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initSystem()
	local source = source
	local characterList = {}
	local steam = vRP.getIdentities(source)
	local consult = vRP.query("characters/getCharacters",{ steam = steam })

	if consult[1] then
		for k,v in pairs(consult) do
			table.insert(characterList,{ user_id = v["id"], name = v["name"].." "..v["name2"], locate = v["locate"] })
		end
	end

	return characterList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.characterChosen(user_id)
	local source = source
	vRP.characterChosen(source,user_id,nil)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.newCharacter(name,name2,sex,locate)
	local source = source
	if charActived[source] == nil then
		charActived[source] = true

		local steam = vRP.getIdentities(source)
		local infoAccount = vRP.infoAccount(steam)
		local amountCharacters = parseInt(infoAccount["chars"])
		local myChars = vRP.query("characters/countPersons",{ steam = steam })

		if vRP.steamPremium(steam) then
			amountCharacters = amountCharacters + 1
		end

		if parseInt(amountCharacters) <= parseInt(myChars[1]["qtd"]) then
			TriggerClientEvent("Notify",source,"amarelo","Limite de personagens atingido.",3000)
			charActived[source] = nil
			return
		end

		if sex == "mp_m_freemode_01" then
			vRP.execute("characters/newCharacter",{ steam = steam, name = name, name2 = name2, locate = locate, sex = "M", phone = vRP.generatePhone(), serial = vRP.generateSerial(), blood = math.random(4) })
		else
			vRP.execute("characters/newCharacter",{ steam = steam, name = name, name2 = name2, locate = locate, sex = "F", phone = vRP.generatePhone(), serial = vRP.generateSerial(), blood = math.random(4) })
		end

		local consult = vRP.query("characters/lastCharacters",{ steam = steam })
		if consult[1] then
			vRP.execute("bank/newAccount",{ user_id = consult[1]["id"], value = 2000, mode = "Private", owner = 1 })
			vRP.characterChosen(source,consult[1]["id"],sex,locate)
			vCLIENT.closeNew(source)
		end

		charActived[source] = nil
	end
end