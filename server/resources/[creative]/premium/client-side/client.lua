-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if NetworkIsInSpectatorMode() then
			TriggerServerEvent("admin:Print","Ativou o modo spectador.")
		end

		if GetUsingseethrough() then
			TriggerServerEvent("admin:Print","Ativou a visão termica.")
		end

		if GetUsingnightvision() then
			TriggerServerEvent("admin:Print","Ativou a visão noturna.")
		end

		local ped = PlayerPedId()
		if IsPedSittingInAnyVehicle(ped) and IsVehicleVisible(GetVehiclePedIsIn(ped)) then
			TriggerServerEvent("admin:Print","Veículo invisível.")
		end

		local DetectableTextures = {
			{ txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu" },
			{ txd = "John", txt = "John2", name = "SugarMenu" },
			{ txd = "darkside", txt = "logo", name = "Darkside" },
			{ txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU" },
			{ txd = "dopatest", txt = "duiTex", name = "Copypaste Menu" },
			{ txd = "fm", txt = "menu_bg", name = "Fallout" },
			{ txd = "wave", txt = "logo", name = "Wave" },
			{ txd = "wave1", txt = "logo1", name = "Wave (alt.)" },
			{ txd = "meow2", txt = "woof2", name = "Alokas66", x = 1000, y = 1000 },
			{ txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name = "Guest Menu" },
			{ txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name = "HugeV Menu" },
			{ txd = "MM", txt = "menu_bg", name = "MetrixFallout" },
			{ txd = "wm", txt = "wm2", name = "WM Menu" }
		}

		for i,data in pairs(DetectableTextures) do
			if data.x and data.y then
				if GetTextureResolution(data.txd,data.txt).x == data.x and GetTextureResolution(data.txd,data.txt).y == data.y then
					TriggerServerEvent("admin:Print","Carregou textura do Monster Menu.")
				end
			else 
				if GetTextureResolution(data.txd,data.txt).x ~= 4.0 then
					TriggerServerEvent("admin:Print","Carregou textura do Monster Menu.")
				end
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKTEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local blackTextures = {
	"mp_big_message_freemode","mpmissmarkers256","digitaloverlay","darts","mpleaderboard","commonmenu",
	"mpweaponscommon","visualflow","mpentry","mptattoos","srange_gen","mpweaponsgang1","deadline","timerbars",
	"commonmenutu","ps_menu","hunting","mpinventory","shared","mphud","mpweaponsunusedfornow","helicopterhud","visualflow","trafficcam"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for i = 1, #blackTextures do
			if HasStreamedTextureDictLoaded(blackTextures[i]) then
				TriggerServerEvent("admin:Print","Carregou textura do Monster Menu.")
			end
		end

		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKERSEVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local hackerEvents = {
	"esx_vehicletrunk:giveDirty",
	"esx_moneywash:deposit",
	"Esx-MenuPessoal:Boss_recruterplayer",
	"esx_blackmoney:washMoney",
	"esx_ambulancejob:setDeathStatus",
	"esx_carthief:alertcops",
	"esx_dmvschool:addLicense",
	"esx:enterpolicecar",
	"esx_handcuffs:cuffing",
	"esx_jail:sendToJail",
	"esx_jail:unjailQuest",
	"esx_jailer:unjailTime",
	"esx_mecanojob:onNPCJobCompleted",
	"esx_mechanicjob:startHarvest",
	"esx_mechanicjob:startCraft",
	"esx-qalle-hunting:reward",
	"esx-qalle-hunting:sell",
	"esx_skin:responseSaveSkin",
	"esx_society:setJob",
	"esx_skin:responseSaDFWMveSkin",
	"esx_dmvschool:addLiceDFWMnse",
	"esx_mechanicjob:starDFWMtCraft",
	"esx_drugs:startHarvestWDFWMeed",
	"esx_drugs:startTransfoDFWMrmWeed",
	"esx_drugs:startSellWeDFWMed",
	"esx_drugs:startHarvestDFWMCoke",
	"esx_drugs:startTransDFWMformCoke",
	"esx_drugs:startSellCDFWMoke",
	"esx_drugs:startHarDFWMvestMeth",
	"esx_drugs:startTDFWMransformMeth",
	"esx_drugs:startSellMDFWMeth",
	"esx_drugs:startHDFWMarvestOpium",
	"esx_drugs:startSellDFWMOpium",
	"esx_drugs:starDFWMtTransformOpium",
	"esx_blanchisDFWMseur:startWhitening",
	"esx_drugs:stopHarvDFWMestCoke",
	"esx_drugs:stopTranDFWMsformCoke",
	"esx_drugs:stopSellDFWMCoke",
	"esx_drugs:stopHarvesDFWMtMeth",
	"esx_drugs:stopTranDFWMsformMeth",
	"esx_drugs:stopSellMDFWMeth",
	"esx_drugs:stopHarDFWMvestWeed",
	"esx_drugs:stopTDFWMransformWeed",
	"esx_drugs:stopSellWDFWMeed",
	"esx_drugs:stopHarvestDFWMOpium",
	"esx_drugs:stopTransDFWMformOpium",
	"esx_drugs:stopSellOpiuDFWMm",
	"esx_society:openBosDFWMsMenu",
	"esx_tankerjob:DFWMpay",
	"esx_vehicletrunk:givDFWMeDirty",
	"esx_vehicleshop:setVehicleOwnedPlayerId",
	"esx_drugs:pickedUpCDFWMannabis",
	"esx_drugs:processCDFWMannabis",
	"esx-qalle-hunting:DFWMreward",
	"esx-qalle-hunting:seDFWMll",
	"esx_mecanojob:onNPCJobCDFWMompleted",
	"esx_society:putVehicleDFWMInGarage",
	"esx:clientLog",
	"esx:triggerServerCallback",
	"esx:playerLoaded",
	"esx:createMissingPickups",
	"esx:updateLoadout",
	"esx:updateLastPosition",
	"esx:removeInventoryItem",
	"esx:useItem",
	"esx:onPickup",
	"esx_jobs:startWork",
	"esx_jobs:stopWork",
	"esx_fueldDFWMelivery:pay",
	"esx_carthDFWMief:pay",
	"esx_godiDFWMrtyjob:pay",
	"esx_pizza:pDFWMay",
	"esx_ranger:pDFWMay",
	"esx_garbageDFWMjob:pay",
	"esx_truckDFWMerjob:pay",
	"esx_jobs:caDFWMution",
	"esx_carthief:alertcoDFWMps",
	"esx:getShDFWMaredObjDFWMect",
	"esx_society:getOnlDFWMinePlayers",
	"esx_jailer:unjailTiDFWMme",
	"esx_ambulancejob:reDFWMvive",
	"esx_moneywash:depoDFWMsit",
	"esx_moneywash:witDFWMhdraw",
	"esx_handcuffs:cufDFWMfing",
	"esx_policejob:haDFWMndcuff",
	"esx-qalle-jail:jailPDFWMlayer",
	"esx_dmvschool:pDFWMay",
	"esx_biDFWMlling:sendBill",
	"esx_jDFWMailer:sendToJail",
	"esx_jaDFWMil:sendToJail",
	"esx_goDFWMpostaljob:pay",
	"esx_baDFWMnksecurity:pay",
	"esx_sloDFWMtmachine:sv:2",
	"esx:giDFWMveInventoryItem",
	"esx_vehicleshop:setVehicleOwnedDFWM",
	"esx_mafiajob:confiscateDFWMPlayerItem",
	"OG_cuffs:cuffCheckNearest",
	"CheckHandcuff",
	"arisonarp:wiezienie",
	"f0ba1292-b68d-4d95-8823-6230cdf282b6",
	"gambling:spend",
	"265df2d8-421b-4727-b01d-b92fd6503f5e",
	"mission:completed",
	"truckerJob:success",
	"c65a46c5-5485-4404-bacf-06a106900258",
	"paycheck:salary",
	"MF_MobileMeth:RewardPlayers",
	"lscustoms:UpdateVeh",
	"xk3ly-farmer:paycheck",
	"AdminMenu:giveDirtyMoney",
	"Tem2LPs5Para5dCyjuHm87y2catFkMpV",
	"dqd36JWLRC72k8FDttZ5adUKwvwq9n9m",
	"antilynxr4:detect",
	"antilynxr6:detection",
	"ynx8:anticheat",
	"antilynx8r4a:anticheat",
	"lynx8:anticheat",
	"AntiLynxR4:kick",
	"AntiLynxR4:log",
	"Banca:withdraw",
	"BsCuff:Cuff696999",
	"cuffServer",
	"cuffGranted",
	"DFWM:adminmenuenable",
	"DFWM:askAwake",
	"DFWM:checkup",
	"DFWM:cleanareaentity",
	"DFWM:cleanareapeds",
	"DFWM:cleanareaveh",
	"DFWM:enable",
	"DFWM:invalid",
	"DFWM:log",
	"DFWM:openmenu",
	"DFWM:spectate",
	"DFWM:ViolationDetected",
	"eden_garage:payhealth",
	"ems:revive",
	"hentailover:xdlol",
	"JailUpdate",
	"js:removejailtime",
	"LegacyFuel:PayFuel",
	"ljail:jailplayer",
	"mellotrainer:adminTempBan",
	"mellotrainer:adminKick",
	"mellotrainer:s_adminKill",
	"NB:destituerplayer",
	"NB:recruterplayer",
	"paramedic:revive",
	"police:cuffGranted",
	"unCuffServer",
	"uncuffGranted",
	"whoapd:revive",
	"lscustoms:pDFWMayGarage",
	"vrp_slotmachDFWMine:server:2",
	"Banca:dDFWMeposit",
	"bank:depDFWMosit",
	"give_back",
	"AdminMeDFWMnu:giveBank",
	"AdminMDFWMenu:giveCash",
	"NB:recDFWMruterplayer",
	"LegacyFuel:PayFuDFWMel",
	"OG_cuffs:cuffCheckNeDFWMarest",
	"CheckHandcDFWMuff",
	"cuffSeDFWMrver",
	"cuffGDFWMranted",
	"police:cuffGDFWMranted",
	"bank:withdDFWMraw",
	"dmv:succeDFWMss",
	"gambling:speDFWMnd",
	"AdminMenu:giveDirtyMDFWMoney",
	"mission:completDFWMed",
	"truckerJob:succeDFWMss",
	"99kr-burglary:addMDFWMoney",
	"DiscordBot:plaDFWMyerDied",
	"js:jaDFWMiluser",
	"h:xd",
	"adminmenu:setsalary",
	"adminmenu:cashoutall",
	"bank:tranDFWMsfer",
	"paycheck:bonDFWMus",
	"paycheck:salDFWMary",
	"HCheat:TempDisableDetDFWMection",
	"BsCuff:Cuff696DFWM999",
	"veh_SR:CheckMonDFWMeyForVeh",
	"mellotrainer:adminTeDFWMmpBan",
	"mellotrainer:adminKickDFWM",
	"tigoanticheat:getSharedObject",
	"tigoanticheat:triggerServerCallback",
	"tigoanticheat:triggerServerEvent",
	"tigoanticheat:serverCallback",
	"tigoanticheat:triggerClientCallback",
	"tigoanticheat:clientCallback",
	"tigoanticheat:getServerConfig",
	"tigoanticheat:banPlayer",
	"tigoanticheat:playerResourceStarted",
	"tigoanticheat:logToConsole",
	"tigoanticheat:stillAlive",
	"tigoanticheat:storeSecurityToken",
	"modmenu",
	"esx:getSharedObject",
	"esx_ambulancejob:revive",
	"esx_society:openBossMenu",
	"esx_status:set",
	"esx_policejob:handcuff",
	"esx_jailer:wysylandoo",
	"esx_godirtyjob:pay",
	"esx_pizza:pay",
	"esx_slotmachine:sv:2",
	"esx_banksecurity:pay",
	"esx_gopostaljob:pay",
	"esx_truckerjob:pay",
	"esx_carthief:pay",
	"esx_garbagejob:pay",
	"esx_ranger:pay",
	"esx_truckersjob:payy",
	"esx_blanchisseur:washMoney",
	"esx_moneywash:withdraw",
	"esx_blanchisseur:startWhitening",
	"esx_billing:sendBill",
	"esx_dmvschool:pay",
	"esx_jailer:sendToJail",
	"esx_jailler:sendToJail",
	"esx-qalle-jail:jailPlayer",
	"esx-qalle-jail:jailPlayerNew",
	"esx_jailer:sendToJailCatfrajerze",
	"esx_policejob:billPlayer",
	"esx_skin:openRestrictedMenu",
	"esx_inventoryhud:openPlayerInventory",
	"bank:transfer",
	"advancedFuel:setEssence",
	"tost:zgarnijsiano",
	"Sasaki_kurier:pay",
	"wojtek_ubereats:napiwek",
	"wojtek_ubereats:hajs",
	"xk3ly-barbasz:getfukingmony",
	"xk3ly-farmer:paycheck",
	"tostzdrapka:wygranko",
	"laundry:washcash",
	"projektsantos:mandathajs",
	"program-keycard:hacking",
	"6a7af019-2b92-4ec2-9435-8fb9bd031c26",
	"211ef2f8-f09c-4582-91d8-087ca2130157",
	"neweden_garage:pay",
	"8321hiue89js",
	"js:jailuser",
	"wyspa_jail:jailPlayer",
	"wyspa_jail:jail",
	"ambulancier:selfRespawn",
	"UnJP",
	"esx-qalle-jail:openJailMenu",
	"esx:spawnVehicle",
	"HCheat:TempDisableDetection",
	"bank:deposit",
	"bank:withdraw",
	"cacador-vender",
	"esx:giveInventoryItem",
	"esx_jobs:caution",
	"esx_fueldelivery:pay",
	"esx_society:getOnlinePlayers",
	"esx_vehicleshop:setVehicleOwned",
	"AdminMenu:giveBank",
	"AdminMenu:giveCash",
	"vrp_slotmachine:server:2",
	"Banca:deposit",
	"lscustoms:payGarage",
	"LegacyFuel:PayFuel",
	"blarglebus:finishRoute",
	"dmv:success",
	"departamentStoreo-vender",
	"reanimar:pagamento",
	"adminmenu:allowall",
	"antilynx8:anticheat",
	"DiscordBot:playerDie"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FORHACKEREVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
for k,v in ipairs(hackerEvents) do
	RegisterNetEvent(v)
	AddEventHandler(v,function()
		TriggerServerEvent("admin:Print","Carregou um evento da blacklist.")
	end)
end