-----------------------------------------------------------------------------------------------------------------------------------------
-- USERBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userBank(user_id,mode)
	local user_id = parseInt(user_id)
	local bankInfos = vRP.query("bank/getInfos",{ user_id = user_id, mode = mode })
	return bankInfos[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addBank(user_id,amount,mode)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("bank/addValue",{ user_id = user_id, value = amount, mode = mode })

		if vRP.userInfos[user_id] and mode == "Private" then
			vRP.userInfos[user_id]["bank"] = vRP.userInfos[user_id]["bank"] + amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delBank(user_id,amount,mode)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("bank/remValue",{ user_id = user_id, value = amount, mode = mode })

		if vRP.userInfos[user_id] and mode == "Private" then
			vRP.userInfos[user_id]["bank"] = vRP.userInfos[user_id]["bank"] - amount

			if vRP.userInfos[user_id]["bank"] < 0 then
				vRP.userInfos[user_id]["bank"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getBank(user_id)
	local user_id = parseInt(user_id)
	if vRP.userInfos[user_id] then
		return vRP.userInfos[user_id]["bank"]
	else
		local identity = vRP.userIdentity(user_id)
		if identity then
			return identity["bank"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getFines(user_id)
	local user_id = parseInt(user_id)
	if vRP.userInfos[user_id] then
		return vRP.userInfos[user_id]["fines"]
	else
		local identity = vRP.userIdentity(user_id)
		if identity then
			return identity["fines"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addFines(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("characters/addFines",{ id = user_id, fines = amount })

		if vRP.userInfos[user_id] then
			vRP.userInfos[user_id]["fines"] = vRP.userInfos[user_id]["fines"] + amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delFines(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("characters/removeFines",{ id = user_id, fines = amount })

		if vRP.userInfos[user_id] then
			vRP.userInfos[user_id]["fines"] = vRP.userInfos[user_id]["fines"] - amount

			if vRP.userInfos[user_id]["fines"] < 0 then
				vRP.userInfos[user_id]["fines"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentGems(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id] then
			if vRP.userGemstone(vRP.userInfos[user_id]["steam"]) >= amount then
				vRP.execute("accounts/removeGems",{ steam = vRP.userInfos[user_id]["steam"], gems = amount })
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentBank(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id] then
			if vRP.userInfos[user_id]["bank"] >= amount then
				vRP.delBank(user_id,amount,"Private")

				local source = vRP.userSource(user_id)
				if source then
					TriggerClientEvent("itensNotify",source,{ "pagou","dollars",parseFormat(amount),"Dólares" })
				end

				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentFull(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.tryGetInventoryItem(user_id,"dollars",amount,true) then
			return true
		else
			if vRP.userInfos[user_id] then
				if vRP.userInfos[user_id]["bank"] >= amount then
					vRP.delBank(user_id,amount,"Private")

					local source = vRP.userSource(user_id)
					if source then
						TriggerClientEvent("itensNotify",source,{ "pagou","dollars",parseFormat(amount),"Dólares" })
					end

					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.withdrawCash(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id]["bank"] >= amount then
			vRP.generateItem(user_id,"dollars",amount,true)
			vRP.delBank(user_id,amount,"Private")

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.getBankMoney = vRP.getBank
function vRP.setBankMoney(user_id, amount)
	local dif = amount - vRP.getBank(user_id)
	vRP.execute("bank/addValue",{ user_id, value = dif, mode = 'Private' })
	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["bank"] = amount
	end
end