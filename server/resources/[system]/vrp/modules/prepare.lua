-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("characters/allChars","SELECT * FROM summerz_characters")
vRP.prepare("characters/getUsers","SELECT * FROM summerz_characters WHERE id = @id")
vRP.prepare("characters/getPhone","SELECT id FROM summerz_characters WHERE phone = @phone")
vRP.prepare("characters/getSerial","SELECT id FROM summerz_characters WHERE serial = @serial")
vRP.prepare("characters/updatePort","UPDATE summerz_characters SET port = @port WHERE id = @id")
vRP.prepare("characters/updatePhone","UPDATE summerz_characters SET phone = @phone WHERE id = @id")
vRP.prepare("characters/removeCharacters","UPDATE summerz_characters SET deleted = 1 WHERE id = @id")
vRP.prepare("characters/updateLocate","UPDATE summerz_characters SET locate = @locate WHERE id = @id")
vRP.prepare("characters/addFines","UPDATE summerz_characters SET fines = fines + @fines WHERE id = @id")
vRP.prepare("characters/setPrison","UPDATE summerz_characters SET prison = @prison WHERE id = @user_id")
vRP.prepare("characters/updateGarages","UPDATE summerz_characters SET garage = garage + 1 WHERE id = @id")
vRP.prepare("characters/removeFines","UPDATE summerz_characters SET fines = fines - @fines WHERE id = @id")
vRP.prepare("characters/getCharacters","SELECT * FROM summerz_characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/removePrison","UPDATE summerz_characters SET prison = prison - @prison WHERE id = @user_id")
vRP.prepare("characters/updateName","UPDATE summerz_characters SET name = @name, name2 = @name2 WHERE id = @user_id")
vRP.prepare("characters/lastCharacters","SELECT id FROM summerz_characters WHERE steam = @steam ORDER BY id DESC LIMIT 1")
vRP.prepare("characters/countPersons","SELECT COUNT(steam) as qtd FROM summerz_characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/newCharacter","INSERT INTO summerz_characters(steam,name,name2,locate,sex,phone,serial,blood) VALUES(@steam,@name,@name2,@locate,@sex,@phone,@serial,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("bank/getInfos","SELECT * FROM summerz_bank WHERE user_id = @user_id AND mode = @mode AND owner = 1")
vRP.prepare("bank/newAccount","INSERT INTO summerz_bank(user_id,value,mode,owner) VALUES(@user_id,@value,@mode,@owner)")
vRP.prepare("bank/addValue","UPDATE summerz_bank SET value = value + @value WHERE user_id = @user_id AND mode = @mode AND owner = 1")
vRP.prepare("bank/remValue","UPDATE summerz_bank SET value = value - @value WHERE user_id = @user_id AND mode = @mode AND owner = 1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("accounts/getInfos","SELECT * FROM summerz_accounts WHERE steam = @steam")
vRP.prepare("accounts/newAccount","INSERT INTO summerz_accounts(steam) VALUES(@steam)")
vRP.prepare("accounts/updateWhitelist","UPDATE summerz_accounts SET whitelist = 0 WHERE steam = @steam")
vRP.prepare("accounts/removeGems","UPDATE summerz_accounts SET gems = gems - @gems WHERE steam = @steam")
vRP.prepare("accounts/setPriority","UPDATE summerz_accounts SET priority = @priority WHERE steam = @steam")
vRP.prepare("accounts/infosUpdatechars","UPDATE summerz_accounts SET chars = chars + 1 WHERE steam = @steam")
vRP.prepare("accounts/infosUpdategems","UPDATE summerz_accounts SET gems = gems + @gems WHERE steam = @steam")
vRP.prepare("accounts/updatePremium","UPDATE summerz_accounts SET premium = premium + 2592000 WHERE steam = @steam")
vRP.prepare("accounts/setPremium","UPDATE summerz_accounts SET premium = @premium, priority = @priority WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("playerdata/getUserdata","SELECT dvalue FROM summerz_playerdata WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("playerdata/setUserdata","REPLACE INTO summerz_playerdata(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("entitydata/removeData","DELETE FROM summerz_entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/getData","SELECT dvalue FROM summerz_entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/setData","REPLACE INTO summerz_entitydata(dkey,dvalue) VALUES(@dkey,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vehicles/plateVehicles","SELECT * FROM summerz_vehicles WHERE plate = @plate")
vRP.prepare("vehicles/getVehicles","SELECT * FROM summerz_vehicles WHERE user_id = @user_id")
vRP.prepare("vehicles/removeVehicles","DELETE FROM summerz_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/selectVehicles","SELECT * FROM summerz_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/paymentArrest","UPDATE summerz_vehicles SET arrest = 0 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/moveVehicles","UPDATE summerz_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/plateVehiclesUpdate","UPDATE summerz_vehicles SET plate = @plate WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesDays","UPDATE summerz_vehicles SET rental = rental + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/countVehicles","SELECT COUNT(vehicle) as qtd FROM summerz_vehicles WHERE user_id = @user_id AND work = @work AND rental <= 0")
vRP.prepare("vehicles/arrestVehicles","UPDATE summerz_vehicles SET arrest = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/updateVehiclesTax","UPDATE summerz_vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesUpdate","UPDATE summerz_vehicles SET rental = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/addVehicles","INSERT IGNORE INTO summerz_vehicles(user_id,vehicle,plate,work,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/rentalVehicles","INSERT IGNORE INTO summerz_vehicles(user_id,vehicle,plate,work,rental,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 2592000,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/updateVehicles","UPDATE summerz_vehicles SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, nitro = @nitro WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("propertys/selling","DELETE FROM summerz_propertys WHERE name = @name")
vRP.prepare("propertys/permissions","SELECT * FROM summerz_propertys WHERE name = @name")
vRP.prepare("propertys/totalHomes","SELECT name,tax FROM summerz_propertys WHERE owner = 1")
vRP.prepare("propertys/userList","SELECT name FROM summerz_propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countUsers","SELECT COUNT(*) as qtd FROM summerz_propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countPermissions","SELECT COUNT(*) as qtd FROM summerz_propertys WHERE name = @name")
vRP.prepare("propertys/userOwnermissions","SELECT * FROM summerz_propertys WHERE name = @name AND owner = 1")
vRP.prepare("propertys/removePermissions","DELETE FROM summerz_propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/userPermissions","SELECT * FROM summerz_propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/updateOwner","UPDATE summerz_propertys SET user_id = @nuser_id WHERE user_id = @user_id AND name = @name")
vRP.prepare("propertys/updateTax","UPDATE summerz_propertys SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateVault","UPDATE summerz_propertys SET vault = vault + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateFridge","UPDATE summerz_propertys SET fridge = fridge + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/newPermissions","INSERT IGNORE INTO summerz_propertys(name,interior,user_id,owner) VALUES(@name,@interior,@user_id,@owner)")
vRP.prepare("propertys/buying","INSERT IGNORE INTO summerz_propertys(name,interior,price,user_id,tax,residents,vault,fridge,owner) VALUES(@name,@interior,@price,@user_id,UNIX_TIMESTAMP() + 604800,@residents,@vault,@fridge,1)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("prison/cleanRecords","DELETE FROM summerz_prison WHERE nuser_id = @nuser_id")
vRP.prepare("prison/getRecords","SELECT * FROM summerz_prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.prepare("prison/insertPrison","INSERT INTO summerz_prison(police,nuser_id,services,fines,text,date) VALUES(@police,@nuser_id,@services,@fines,@text,@date)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("banneds/getBanned","SELECT * FROM summerz_banneds WHERE steam = @steam")
vRP.prepare("banneds/removeBanned","DELETE FROM summerz_banneds WHERE steam = @steam")
vRP.prepare("banneds/insertBanned","INSERT INTO summerz_banneds(steam,time) VALUES(@steam,UNIX_TIMESTAMP() + 86400 * @time)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("chests/getChests","SELECT * FROM summerz_chests WHERE name = @name")
vRP.prepare("chests/upgradeChests","UPDATE summerz_chests SET weight = weight + 25 WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("races/checkResult","SELECT * FROM summerz_races WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/requestRanking","SELECT * FROM summerz_races WHERE raceid = @raceid ORDER BY points ASC LIMIT 5")
vRP.prepare("races/updateRecords","UPDATE summerz_races SET points = @points, vehicle = @vehicle WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/insertRecords","INSERT INTO summerz_races(raceid,user_id,name,vehicle,points) VALUES(@raceid,@user_id,@name,@vehicle,@points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("fidentity/getResults","SELECT * FROM summerz_fidentity WHERE id = @id")
vRP.prepare("fidentity/lastIdentity","SELECT id FROM summerz_fidentity ORDER BY id DESC LIMIT 1")
vRP.prepare("fidentity/newIdentity","INSERT INTO summerz_fidentity(name,name2,locate,blood) VALUES(@name,@name2,@locate,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANSMARTPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("smartphone/cleanCalls","DELETE FROM smartphone_calls WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 3)")
vRP.prepare("smartphone/cleanTorMessages","DELETE FROM smartphone_tor_messages WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 3)")
vRP.prepare("smartphone/cleanMessages","DELETE FROM smartphone_zipzap_messages WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 7)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("summerz/playerdata","DELETE FROM summerz_playerdata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.prepare("summerz/entitydata","DELETE FROM summerz_entitydata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.prepare("summerz/cleanBanks","DELETE FROM smartphone_bank WHERE (DATEDIFF(CURRENT_DATE,data) >= 7)")
vRP.prepare("summerz/cleanPremium","UPDATE summerz_accounts SET premium = '0', priority = '0' WHERE UNIX_TIMESTAMP() >= premium")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCLEANERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	vRP.execute("summerz/playerdata")
	vRP.execute("summerz/entitydata")
	vRP.execute("summerz/cleanBanks")
	vRP.execute("summerz/cleanPremium")
	vRP.execute("smartphone/cleanCalls")
	vRP.execute("smartphone/cleanMessages")
	vRP.execute("smartphone/cleanTorMessages")
end)