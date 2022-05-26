-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_min = 5.0
local fov_max = 70.0
local cameras = false
local binoculos = false
local tratamento = false
local fov = (fov_max + fov_min) * 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLEDANCES
-----------------------------------------------------------------------------------------------------------------------------------------
local poleDances = {
	{ 108.98,-1289.45,29.25,252.29 },
	{ 102.40,-1290.06,29.25,320.32 },
	{ 104.95,-1294.35,29.25,323.15 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ 1631638868,0.0,0.0 },
	{ 2117668672,0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local animacoes = {
	["encostar3"] = { dict = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", andar = false, loop = true },
	["encostar4"] = { dict = "anim@amb@casino@out_of_money@ped_female@02b@base", anim = "base", andar = false, loop = true },
	["encostar5"] = { dict = "anim@amb@casino@hangout@ped_male@stand@03b@base", anim = "base", andar = true, loop = true },
	["encostar6"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02b@base", anim = "base", andar = false, loop = true },
	["encostar7"] = { dict = "anim@amb@casino@hangout@ped_female@stand@02a@base", anim = "base", andar = false, loop = true },
	["encostar8"] = { dict = "anim@amb@clubhouse@bar@bartender@", anim = "base_bartender", andar = false, loop = true },
	["encostar9"] = { dict = "missclothing", anim = "idle_a", andar = false, loop = true },
	["encostar10"] = { dict = "misscarstealfinale", anim = "packer_idle_1_trevor", andar = false, loop = true },
	["encostar11"] = { dict = "missarmenian1leadinoutarm_1_ig_14_leadinout", anim = "leadin_loop", andar = false, loop = true },
	["wtf"] = { dict = "anim@mp_player_intcelebrationfemale@face_palm", anim = "face_palm", andar = true, loop = false },
	["wtf2"] = { dict = "random@car_thief@agitated@idle_a", anim = "agitated_idle_a", andar = true, loop = false },
	["wtf3"] = { dict = "missminuteman_1ig_2", anim = "tasered_2", andar = true, loop = false },
	["wtf4"] = { dict = "anim@mp_player_intupperface_palm", anim = "idle_a", andar = true, loop = false },
	["cortaessa"] = { dict = "gestures@m@standing@casual", anim = "gesture_no_way", andar = false, loop = false },
	["joia"] = { dict = "anim@mp_player_intincarthumbs_uplow@ds@", anim = "enter", andar = false, loop = false },
	["joia2"] = { dict = "anim@mp_player_intselfiethumbs_up", anim = "idle_a", andar = false, loop = false },
	["carona"] = { dict = "random@hitch_lift", anim = "idle_f", andar = false, loop = false },
	["escorregar"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_a_player_a", andar = false, loop = false },
	["escorregar2"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_c_player_a", andar = false, loop = false },
	["passa"] = { dict = "mini@strip_club@lap_dance@ld_girl_a_approach", anim = "ld_girl_a_approach_f", andar = false, loop = false },
	["cachorro"] = { dict = "random@peyote@dog", anim = "wakeup", andar = false, loop = false },
	["karate"] = { dict = "anim@mp_player_intcelebrationfemale@karate_chops", anim = "karate_chops", andar = false, loop = false },
	["karate2"] = { dict = "anim@mp_player_intcelebrationmale@karate_chops", anim = "karate_chops", andar = false, loop = false },
	["alongar3"] = { dict = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_d", andar = false, loop = false },
	["alongar4"] = { dict = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_c", andar = false, loop = false },
	["alongar5"] = { dict = "mini@triathlon", anim = "idle_f", andar = false, loop = true },
	["alongar6"] = { dict = "mini@triathlon", anim = "idle_d", andar = false, loop = true },
	["alongar7"] = { dict = "rcmfanatic1maryann_stretchidle_b", anim = "idle_e", andar = false, loop = true },
	["alongar8"] = { dict = "timetable@reunited@ig_2", anim = "jimmy_getknocked", andar = false, loop = true },
	["casalm"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedontknowwhy_trevor", andar = false, loop = true },
	["casalf"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedontknowwhy_patricia", andar = false, loop = true },
	["casalm2"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedesertissobeautiful_trevor", andar = false, loop = true },
	["casalf2"] = { dict = "timetable@trevor@ig_1", anim = "ig_1_thedesertissobeautiful_patricia", andar = false, loop = true },
	["dormir4"] = { dict = "mp_sleep", anim = "sleep_loop", andar = false, loop = true },
	["dormir5"] = { dict = "missarmenian2", anim = "drunk_loop", andar = false, loop = true },
	["sentar8"] = { dict = "timetable@tracy@ig_14@", anim = "ig_14_base_tracy", andar = false, loop = true },
	["deitar6"] = { dict = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_girl", andar = false, loop = true },
	["deitar7"] = { dict = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_guy", andar = false, loop = true },
	["palmas5"] = { dict = "anim@mp_player_intupperslow_clap", anim = "idle_a", andar = false, loop = true },
	["celebrar"] = { dict = "rcmfanatic1celebrate", anim = "celebrate", andar = false, loop = false },
	["rebolar"] = { dict = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_idle_stripper", andar = false, loop = true },
	["pneu"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "imp_prop_impexp_tyre_01a", flag = 49, mao = 28422, altura = -0.02, pos1 = -0.1, pos2 = 0.2, pos3 = 10.0, pos4 = 0.0, pos5 = 0.0 },
	["bong"] = { dict = "anim@safehouse@bong", anim = "bong_stage1", prop = "prop_bong_01", flag = 49, mao = 18905, altura = 0.10, pos1 = -0.25, pos2 = 0.0, pos3 = 95.0, pos4 = 190.0, pos5 = 180.0 },
	["mic"] = { dict = "missfra1", anim = "mcs2_crew_idle_m_boom", prop = "prop_v_bmike_01", flag = 50, mao = 28422, altura = -0.08, pos1 = 0.0, pos2 = 0.0, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["mic2"] = { dict = "missmic4premiere", anim = "interview_short_lazlow", prop = "p_ing_microphonel_01", flag = 50, mao = 28422 },
	["mic3"] = { dict = "anim@random@shop_clothes@watches", anim = "base", prop = "p_ing_microphonel_01", flag = 49, mao = 60309, altura = 0.10, pos1 = 0.04, pos2 = 0.012, pos3 = -60.0, pos4 = 60.0, pos5 = -30.0 },
	["megaphone"] = { dict = "anim@random@shop_clothes@watches", anim = "base", prop = "prop_megaphone_01", flag = 49, mao = 60309, altura = 0.10, pos1 = 0.04, pos2 = 0.012, pos3 = -60.0, pos4 = 100.0, pos5 = -30.0 },
	["livro"] = { dict = "cellphone@", anim = "cellphone_text_read_base", prop = "prop_novel_01", flag = 49, mao = 6286, altura = 0.15, pos1 = 0.03, pos2 = -0.065, pos3 = 0.0, pos4 = 180.0, pos5 = 90.0 },
	["radio2"] = { prop = "prop_boombox_01", flag = 50, mao = 57005, altura = 0.30, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa"] = { prop = "prop_ld_case_01", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa2"] = { prop = "prop_ld_case_01_s", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa3"] = { prop = "prop_security_case_01", flag = 50, mao = 57005, altura = 0.16, pos1 = 0, pos2 = -0.01, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["bolsa4"] = { prop = "w_am_case", flag = 50, mao = 57005, altura = 0.08, pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["caixa2"] = { prop = "prop_tool_box_04", flag = 50, mao = 57005, altura = 0.45, pos1 = 0, pos2 = 0.05, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["lixo"] = { prop = "prop_cs_rub_binbag_01", flag = 50, mao = 57005, altura = 0.11, pos1 = 0, pos2 = 0.0, pos3 = 0, pos4 = 260.0, pos5 = 60.0 },
	["prebeber"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber2"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "prop_ld_flow_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber3"] = { dict = "amb@code_human_wander_drinking@beer@male@base", anim = "static", prop = "prop_cs_bs_cup", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["prebeber4"] = { dict = "anim@heists@humane_labs@finale@keycards", anim = "ped_a_enter_loop", prop = "prop_drink_champ", flag = 49, mao = 18905, altura = 0.10, pos1 = -0.05, pos2 = 0.03, pos3 = -100.0, pos4 = 0.0, pos5 = -10.0 },
	["verificar"] = { dict = "amb@medic@standing@tendtodead@idle_a", anim = "idle_a", andar = false, loop = true },
	["mexer"] = { dict = "amb@prop_human_parking_meter@female@idle_a", anim = "idle_a_female", andar = true, loop = true },
	["cuidar"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_pumpchest", andar = true, loop = true },
	["cuidar2"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_kol", andar = true, loop = true },
	["cuidar3"] = { dict = "mini@cpr@char_a@cpr_str", anim = "cpr_kol_idle", andar = true, loop = true },
	["cansado"] = { dict = "rcmbarry", anim = "idle_d", andar = false, loop = true },
	["alongar2"] = { dict = "mini@triathlon", anim = "idle_e", andar = false, loop = true },
	["poledance"] = { dict = "mini@strip_club@pole_dance@pole_dance1", anim = "pd_dance_01", andar = false, loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(poleDances) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 1 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,1,0,0,0)
				break
			end
		end
	end },
	["poledance2"] = { dict = "mini@strip_club@pole_dance@pole_dance2", anim = "pd_dance_02", andar = false, loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(poleDances) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 1 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,1,0,0,0)
				break
			end
		end
	end },
	["poledance3"] = { dict = "mini@strip_club@pole_dance@pole_dance3", anim = "pd_dance_03", andar = false, loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(poleDances) do
			local distance = #(coords - vector3(v[1],v[2],v[3]))
			if distance <= 1 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,1,0,0,0)
				break
			end
		end
	end },
	["meleca"] = { dict = "anim@mp_player_intuppernose_pick", anim = "idle_a", andar = true, loop = true },
	["bora"] = { dict = "missfam4", anim = "say_hurry_up_a_trevor", andar = true, loop = false },
	["limpar"] = { dict = "missfbi3_camcrew", anim = "final_loop_guy", andar = true, loop = false },
	["galinha"] = { dict = "random@peyote@chicken", anim = "wakeup", andar = true, loop = true },
	["amem"] = { dict = "rcmepsilonism8", anim = "worship_base", andar = true, loop = true },
	["nervoso"] = { dict = "rcmme_tracey1", anim = "nervous_loop", andar = true, loop = true },
	["ajoelhar"] = { dict = "amb@medic@standing@kneel@idle_a", anim = "idle_a", andar = false, loop = true },
	["sinalizar"] = { dict = "amb@world_human_car_park_attendant@male@base", anim = "base", prop = "prop_parking_wand_01", flag = 49, mao = 28422 },
	["placa"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_01", flag = 49, mao = 28422 },
	["placa2"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_03", flag = 49, mao = 28422 },
	["placa3"] = { dict = "amb@world_human_bum_freeway@male@base", anim = "base", prop = "prop_beggers_sign_04", flag = 49, mao = 28422 },
	["abanar"] = { dict = "timetable@amanda@facemask@base", anim = "base", andar = true, loop = true },
	["cocada"] = { dict = "mp_player_int_upperarse_pick", anim = "mp_player_int_arse_pick", andar = true, loop = true },
	["cocada2"] = { dict = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch", andar = true, loop = true },
	["lero"] = { dict = "anim@mp_player_intselfiejazz_hands", anim = "idle_a", andar = true, loop = false },
	["dj2"] = { dict = "anim@mp_player_intupperair_synth", anim = "idle_a_fp", andar = false, loop = true },
	["beijo"] = { dict = "anim@mp_player_intselfieblow_kiss", anim = "exit", andar = true, loop = false },
	["malicia"] = { dict = "anim@mp_player_intupperdock", anim = "idle_a", andar = true, loop = false },
	["ligar"] = { dict = "cellphone@", anim = "cellphone_call_in", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["radio"] = { dict = "cellphone@", anim = "cellphone_call_in", prop = "prop_cs_hand_radio", flag = 50, mao = 28422 },
	["cafe"] = { dict = "amb@world_human_aa_coffee@base", anim = "base", prop = "p_amb_coffeecup_01", flag = 50, mao = 28422 },
	["cafe2"] = { dict = "amb@world_human_aa_coffee@idle_a", anim = "idle_a", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422 },
	["cafe3"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "p_amb_coffeecup_01", flag = 49, mao = 28422 },
	["caixa"] = { dict = "anim@heists@box_carry@", anim = "idle", prop = "hei_prop_heist_box", flag = 50, mao = 28422 },
	["chuva"] = { dict = "amb@world_human_drinking@coffee@male@base", anim = "base", prop = "p_amb_brolly_01", flag = 50, mao = 28422 },
	["chuva2"] = { dict = "amb@world_human_drinking@coffee@male@base", anim = "base", prop = "p_amb_brolly_01_s", flag = 50, mao = 28422 },
	["comer"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_cs_burger_01", flag = 49, mao = 28422 },
	["comer2"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_cs_hotdog_01", flag = 49, mao = 28422 },
	["comer3"] = { dict = "amb@code_human_wander_eating_donut@male@idle_a", anim = "idle_c", prop = "prop_amb_donut", flag = 49, mao = 28422 },
	["comer4"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_choc_ego", flag = 49, mao = 60309 },
	["comer5"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_sandwich_01", flag = 49, mao = 18905, altura = 0.13, pos1 = 0.05, pos2 = 0.02, pos3 = -50.0, pos4 = 16.0, pos5 = 60.0 },
	["comer6"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_taco_01", flag = 49, mao = 18905, altura = 0.16, pos1 = 0.06, pos2 = 0.02, pos3 = -50.0, pos4 = 220.0, pos5 = 60.0 },
	["comer7"] = { dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", prop = "prop_food_bs_chips", flag = 49, mao = 18905, altura = 0.10, pos1 = 0.0, pos2 = 0.08, pos3 = 150.0, pos4 = 320.0, pos5 = 160.0 },
	["beber"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "p_cs_bottle_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber2"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_energy_drink", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber3"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_amb_beer_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber4"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "p_whiskey_notop", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber5"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_beer_logopen", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber6"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_beer_blr", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = -0.10, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber7"] = { dict = "amb@world_human_drinking@beer@male@idle_a", anim = "idle_a", prop = "prop_ld_flow_bottle", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.05, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber8"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "prop_plastic_cup_02", flag = 49, mao = 28422 },
	["beber9"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "prop_food_bs_juice03", flag = 49, mao = 28422, altura = 0.0, pos1 = -0.01, pos2 = -0.15, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["beber10"] = { dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", prop = "ng_proc_sodacan_01b", flag = 49, mao = 28422, altura = 0.0, pos1 = -0.01, pos2 = -0.08, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	["digitar"] = { dict = "anim@heists@prison_heistig1_p1_guard_checks_bus", anim = "loop", andar = false, loop = true },
	["continencia"] = { dict = "mp_player_int_uppersalute", anim = "mp_player_int_salute", andar = true, loop = true },
	["atm"] = { dict = "amb@prop_human_atm@male@idle_a", anim = "idle_a", andar = false, loop = false },
	["no"] = { dict = "mp_player_int_upper_nod", anim = "mp_player_int_nod_no", andar = true, loop = true },
	["palmas"] = { dict = "anim@mp_player_intcelebrationfemale@slow_clap", anim = "slow_clap", andar = true, loop = false },
	["palmas2"] = { dict = "amb@world_human_cheering@male_b", anim = "base", andar = true, loop = true },
	["palmas3"] = { dict = "amb@world_human_cheering@male_d", anim = "base", andar = true, loop = true },
	["palmas4"] = { dict = "amb@world_human_cheering@male_e", anim = "base", andar = true, loop = true },
	["postura"] = { dict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_a_idle", andar = true, loop = true },
	["postura2"] = { dict = "amb@world_human_cop_idles@female@base", anim = "base", andar = true, loop = true },
	["varrer"] = { dict = "amb@world_human_janitor@male@idle_a", anim = "idle_a", prop = "prop_tool_broom", flag = 49, mao = 28422 },
	["musica"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_01", flag = 49, mao = 60309 },
	["musica2"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_02", flag = 49, mao = 60309 },
	["musica3"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_el_guitar_03", flag = 49, mao = 60309 },
	["musica4"] = { dict = "amb@world_human_musician@guitar@male@base", anim = "base", prop = "prop_acc_guitar_01", flag = 49, mao = 60309 },
	["musica5"] = { dict = "switch@trevor@guitar_beatdown", anim = "001370_02_trvs_8_guitar_beatdown_idle_busker", prop = "prop_acc_guitar_01", flag = 49, mao = 24818, altura = -0.05, pos1 = 0.31, pos2 = 0.1, pos3 = 0.0, pos4 = 20.0, pos5 = 150.0 },
	["camera"] = { dict = "missfinale_c2mcs_1", anim = "fin_c2_mcs_1_camman", prop = "prop_v_cam_01", flag = 49, mao = 28422 },
	["prancheta"] = { dict = "amb@world_human_clipboard@male@base", anim = "base", prop = "p_amb_clipboard_01", flag = 50, mao = 60309 },
	["mapa"] = { dict = "amb@world_human_clipboard@male@base", anim = "base", prop = "prop_tourist_map_01", flag = 50, mao = 60309 },
	["anotar"] = { dict = "amb@medic@standing@timeofdeath@base", anim = "base", prop = "prop_notepad_01", flag = 49, mao = 60309 },
	["peace"] = { dict = "mp_player_int_upperpeace_sign", anim = "mp_player_int_peace_sign", andar = true, loop = true },
	["deitar"] = { dict = "anim@gangops@morgue@table@", anim = "body_search", andar = false, loop = true },
	["deitar2"] = { dict = "amb@world_human_sunbathe@female@front@idle_a", anim = "idle_a", andar = false, loop = true },
	["deitar3"] = { dict = "amb@world_human_sunbathe@male@back@idle_a", anim = "idle_a", andar = false, loop = true },
	["deitar4"] = { dict = "amb@world_human_sunbathe@male@front@idle_a", anim = "idle_a", andar = false, loop = true },
	["deitar5"] = { dict = "amb@world_human_sunbathe@female@back@idle_a", anim = "idle_a", andar = false, loop = true },
	["debrucar"] = { dict = "amb@prop_human_bum_shopping_cart@male@base", anim = "base", andar = false, loop = true },
	["debrucar2"] = { dict = "anim@amb@clubhouse@bar@drink@idle_a", anim = "idle_a_bartender", andar = true, loop = true },
	["dancar"] = { dict = "rcmnigel1bnmt_1b", anim = "dance_loop_tyler", andar = false, loop = true },
	["dancar2"] = { dict = "mp_safehouse", anim = "lap_dance_girl", andar = false, loop = true },
	["dancar3"] = { dict = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", andar = false, loop = true },
	["dancar4"] = { dict = "mini@strip_club@private_dance@part1", anim = "priv_dance_p1", andar = false, loop = true },
	["dancar5"] = { dict = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2", andar = false, loop = true },
	["dancar6"] = { dict = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3", andar = false, loop = true },
	["dancar7"] = { dict = "special_ped@mountain_dancer@monologue_2@monologue_2a", anim = "mnt_dnc_angel", andar = false, loop = true },
	["dancar8"] = { dict = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", andar = false, loop = true },
	["dancar9"] = { dict = "missfbi3_sniping", anim = "dance_m_default", andar = false, loop = true },
	["dancar10"] = { dict = "anim@amb@nightclub@dancers@black_madonna_entourage@", anim = "hi_dance_facedj_09_v2_male^5", andar = false, loop = true },
	["dancar11"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^1", andar = false, loop = true },
	["dancar12"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^2", andar = false, loop = true },
	["dancar13"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^3", andar = false, loop = true },
	["dancar14"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^4", andar = false, loop = true },
	["dancar15"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^5", andar = false, loop = true },
	["dancar16"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^6", andar = false, loop = true },
	["dancar17"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^1", andar = false, loop = true },
	["dancar18"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^2", andar = false, loop = true },
	["dancar19"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^3", andar = false, loop = true },
	["dancar20"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^4", andar = false, loop = true },
	["dancar21"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^5", andar = false, loop = true },
	["dancar22"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_male^6", andar = false, loop = true },
	["dancar23"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^1", andar = false, loop = true },
	["dancar24"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^2", andar = false, loop = true },
	["dancar25"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^3", andar = false, loop = true },
	["dancar26"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^4", andar = false, loop = true },
	["dancar27"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^5", andar = false, loop = true },
	["dancar28"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^6", andar = false, loop = true },
	["dancar29"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^1", andar = false, loop = true },
	["dancar30"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^2", andar = false, loop = true },
	["dancar31"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^3", andar = false, loop = true },
	["dancar32"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^4", andar = false, loop = true },
	["dancar33"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^5", andar = false, loop = true },
	["dancar34"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_male^6", andar = false, loop = true },
	["dancar35"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^1", andar = false, loop = true },
	["dancar36"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^2", andar = false, loop = true },
	["dancar37"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^3", andar = false, loop = true },
	["dancar38"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^4", andar = false, loop = true },
	["dancar39"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^5", andar = false, loop = true },
	["dancar40"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_female^6", andar = false, loop = true },
	["dancar41"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^1", andar = false, loop = true },
	["dancar42"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^2", andar = false, loop = true },
	["dancar43"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^3", andar = false, loop = true },
	["dancar44"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^4", andar = false, loop = true },
	["dancar45"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^5", andar = false, loop = true },
	["dancar46"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v1_male^6", andar = false, loop = true },
	["dancar47"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^1", andar = false, loop = true },
	["dancar48"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^2", andar = false, loop = true },
	["dancar49"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^3", andar = false, loop = true },
	["dancar50"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^4", andar = false, loop = true },
	["dancar51"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^5", andar = false, loop = true },
	["dancar52"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_female^6", andar = false, loop = true },
	["dancar53"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^1", andar = false, loop = true },
	["dancar54"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^2", andar = false, loop = true },
	["dancar55"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^3", andar = false, loop = true },
	["dancar56"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^4", andar = false, loop = true },
	["dancar57"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^5", andar = false, loop = true },
	["dancar58"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_11_v2_male^6", andar = false, loop = true },
	["dancar59"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^1", andar = false, loop = true },
	["dancar60"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^2", andar = false, loop = true },
	["dancar61"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^3", andar = false, loop = true },
	["dancar62"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^4", andar = false, loop = true },
	["dancar63"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^5", andar = false, loop = true },
	["dancar64"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_female^6", andar = false, loop = true },
	["dancar65"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^1", andar = false, loop = true },
	["dancar66"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^2", andar = false, loop = true },
	["dancar67"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^3", andar = false, loop = true },
	["dancar68"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^4", andar = false, loop = true },
	["dancar69"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^5", andar = false, loop = true },
	["dancar70"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v1_male^6", andar = false, loop = true },
	["dancar71"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^1", andar = false, loop = true },
	["dancar72"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^2", andar = false, loop = true },
	["dancar73"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^3", andar = false, loop = true },
	["dancar74"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^4", andar = false, loop = true },
	["dancar75"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^5", andar = false, loop = true },
	["dancar76"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_female^6", andar = false, loop = true },
	["dancar77"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^1", andar = false, loop = true },
	["dancar78"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^2", andar = false, loop = true },
	["dancar79"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^3", andar = false, loop = true },
	["dancar80"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^4", andar = false, loop = true },
	["dancar81"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^5", andar = false, loop = true },
	["dancar82"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_13_v2_male^6", andar = false, loop = true },
	["dancar83"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^1", andar = false, loop = true },
	["dancar84"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^2", andar = false, loop = true },
	["dancar85"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^3", andar = false, loop = true },
	["dancar86"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^4", andar = false, loop = true },
	["dancar87"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^5", andar = false, loop = true },
	["dancar88"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_female^6", andar = false, loop = true },
	["dancar89"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^1", andar = false, loop = true },
	["dancar90"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^2", andar = false, loop = true },
	["dancar91"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^3", andar = false, loop = true },
	["dancar92"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^4", andar = false, loop = true },
	["dancar93"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^5", andar = false, loop = true },
	["dancar94"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v1_male^6", andar = false, loop = true },
	["dancar95"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^1", andar = false, loop = true },
	["dancar96"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^2", andar = false, loop = true },
	["dancar97"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^3", andar = false, loop = true },
	["dancar98"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^4", andar = false, loop = true },
	["dancar99"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^5", andar = false, loop = true },
	["dancar100"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_female^6", andar = false, loop = true },
	["dancar101"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^1", andar = false, loop = true },
	["dancar102"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^2", andar = false, loop = true },
	["dancar103"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^3", andar = false, loop = true },
	["dancar104"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^4", andar = false, loop = true },
	["dancar105"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^5", andar = false, loop = true },
	["dancar106"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_15_v2_male^6", andar = false, loop = true },
	["dancar107"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^1", andar = false, loop = true },
	["dancar108"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^2", andar = false, loop = true },
	["dancar109"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^3", andar = false, loop = true },
	["dancar110"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^4", andar = false, loop = true },
	["dancar111"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^5", andar = false, loop = true },
	["dancar112"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_female^6", andar = false, loop = true },
	["dancar113"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^1", andar = false, loop = true },
	["dancar114"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^2", andar = false, loop = true },
	["dancar115"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^3", andar = false, loop = true },
	["dancar116"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^4", andar = false, loop = true },
	["dancar117"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^5", andar = false, loop = true },
	["dancar118"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v1_male^6", andar = false, loop = true },
	["dancar119"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^1", andar = false, loop = true },
	["dancar120"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^2", andar = false, loop = true },
	["dancar121"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^3", andar = false, loop = true },
	["dancar122"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^4", andar = false, loop = true },
	["dancar123"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^5", andar = false, loop = true },
	["dancar124"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_female^6", andar = false, loop = true },
	["dancar125"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^1", andar = false, loop = true },
	["dancar126"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^2", andar = false, loop = true },
	["dancar127"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^3", andar = false, loop = true },
	["dancar128"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^4", andar = false, loop = true },
	["dancar129"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^5", andar = false, loop = true },
	["dancar130"] = { dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_17_v2_male^6", andar = false, loop = true },
	["dancar131"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^1", andar = false, loop = true },
	["dancar132"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^2", andar = false, loop = true },
	["dancar133"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^3", andar = false, loop = true },
	["dancar134"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^4", andar = false, loop = true },
	["dancar135"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^5", andar = false, loop = true },
	["dancar136"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^6", andar = false, loop = true },
	["dancar137"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^1", andar = false, loop = true },
	["dancar138"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^2", andar = false, loop = true },
	["dancar139"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^3", andar = false, loop = true },
	["dancar140"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^4", andar = false, loop = true },
	["dancar141"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^5", andar = false, loop = true },
	["dancar142"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_male^6", andar = false, loop = true },
	["dancar143"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^1", andar = false, loop = true },
	["dancar144"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^2", andar = false, loop = true },
	["dancar145"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^3", andar = false, loop = true },
	["dancar146"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^4", andar = false, loop = true },
	["dancar147"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^5", andar = false, loop = true },
	["dancar148"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_female^6", andar = false, loop = true },
	["dancar149"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^1", andar = false, loop = true },
	["dancar150"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^2", andar = false, loop = true },
	["dancar151"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^3", andar = false, loop = true },
	["dancar152"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^4", andar = false, loop = true },
	["dancar153"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^5", andar = false, loop = true },
	["dancar154"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v2_male^6", andar = false, loop = true },
	["dancar155"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^1", andar = false, loop = true },
	["dancar156"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^2", andar = false, loop = true },
	["dancar157"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^3", andar = false, loop = true },
	["dancar158"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^4", andar = false, loop = true },
	["dancar159"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^5", andar = false, loop = true },
	["dancar160"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_female^6", andar = false, loop = true },
	["dancar161"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^1", andar = false, loop = true },
	["dancar162"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^2", andar = false, loop = true },
	["dancar163"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^3", andar = false, loop = true },
	["dancar164"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^4", andar = false, loop = true },
	["dancar165"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^5", andar = false, loop = true },
	["dancar166"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_11_v1_male^6", andar = false, loop = true },
	["dancar167"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^1", andar = false, loop = true },
	["dancar168"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^2", andar = false, loop = true },
	["dancar169"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^3", andar = false, loop = true },
	["dancar170"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^4", andar = false, loop = true },
	["dancar171"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^5", andar = false, loop = true },
	["dancar172"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_female^6", andar = false, loop = true },
	["dancar173"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^1", andar = false, loop = true },
	["dancar174"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^2", andar = false, loop = true },
	["dancar175"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^3", andar = false, loop = true },
	["dancar176"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^4", andar = false, loop = true },
	["dancar177"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^5", andar = false, loop = true },
	["dancar178"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_13_v2_male^6", andar = false, loop = true },
	["dancar179"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^1", andar = false, loop = true },
	["dancar180"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^2", andar = false, loop = true },
	["dancar181"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^3", andar = false, loop = true },
	["dancar182"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^4", andar = false, loop = true },
	["dancar183"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^5", andar = false, loop = true },
	["dancar184"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_female^6", andar = false, loop = true },
	["dancar185"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^1", andar = false, loop = true },
	["dancar186"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^2", andar = false, loop = true },
	["dancar187"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^3", andar = false, loop = true },
	["dancar188"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^4", andar = false, loop = true },
	["dancar189"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^5", andar = false, loop = true },
	["dancar190"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v1_male^6", andar = false, loop = true },
	["dancar191"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^1", andar = false, loop = true },
	["dancar192"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^2", andar = false, loop = true },
	["dancar193"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^3", andar = false, loop = true },
	["dancar194"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^4", andar = false, loop = true },
	["dancar195"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^5", andar = false, loop = true },
	["dancar196"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_female^6", andar = false, loop = true },
	["dancar197"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^1", andar = false, loop = true },
	["dancar198"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^2", andar = false, loop = true },
	["dancar199"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^3", andar = false, loop = true },
	["dancar200"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^4", andar = false, loop = true },
	["dancar201"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^5", andar = false, loop = true },
	["dancar202"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_15_v2_male^6", andar = false, loop = true },
	["dancar203"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^1", andar = false, loop = true },
	["dancar204"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^2", andar = false, loop = true },
	["dancar205"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^3", andar = false, loop = true },
	["dancar206"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^4", andar = false, loop = true },
	["dancar207"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^5", andar = false, loop = true },
	["dancar208"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_female^6", andar = false, loop = true },
	["dancar209"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^1", andar = false, loop = true },
	["dancar210"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^2", andar = false, loop = true },
	["dancar211"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^3", andar = false, loop = true },
	["dancar212"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^4", andar = false, loop = true },
	["dancar213"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^5", andar = false, loop = true },
	["dancar214"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v1_male^6", andar = false, loop = true },
	["dancar215"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^1", andar = false, loop = true },
	["dancar216"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^2", andar = false, loop = true },
	["dancar217"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^3", andar = false, loop = true },
	["dancar218"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^4", andar = false, loop = true },
	["dancar219"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^5", andar = false, loop = true },
	["dancar220"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_female^6", andar = false, loop = true },
	["dancar221"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^1", andar = false, loop = true },
	["dancar222"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^2", andar = false, loop = true },
	["dancar223"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^3", andar = false, loop = true },
	["dancar224"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^4", andar = false, loop = true },
	["dancar225"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^5", andar = false, loop = true },
	["dancar226"] = { dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_17_v2_male^6", andar = false, loop = true },
	["dancar227"] = { dict = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_buttwiggle_b_laz", andar = false, loop = true },
	["dancar228"] = { dict = "timetable@tracy@ig_5@idle_a", anim = "idle_a", andar = false, loop = true },
	["dancar229"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_down", andar = false, loop = true },
	["dancar230"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar231"] = { dict = "anim@mp_player_intupperfind_the_fish", anim = "idle_a", andar = true, loop = true },
	["dancar232"] = { dict = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_buttwiggle_b_laz", andar = false, loop = true },
	["dancar233"] = { dict = "move_clown@p_m_two_idles@", anim = "fidget_short_dance", andar = false, loop = true },
	["dancar234"] = { dict = "move_clown@p_m_zero_idles@", anim = "fidget_short_dance", andar = false, loop = true },
	["dancar235"] = { dict = "misschinese2_crystalmazemcs1_ig", anim = "dance_loop_tao", andar = false, loop = true },
	["dancar236"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar237"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", andar = false, loop = true },
	["dancar238"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center", andar = false, loop = true },
	["dancar239"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar240"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center", andar = true, loop = true },
	["dancar241"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar242"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar243"] = { dict = "anim@amb@nightclub@dancers@podium_dancers@", anim = "hi_dance_facedj_17_v2_male^5", andar = false, loop = true },
	["dancar244"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar245"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", andar = false, loop = true },
	["dancar246"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center", andar = false, loop = true },
	["dancar247"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", andar = false, loop = true },
	["dancar248"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar249"] = { dict = "anim@amb@nightclub@dancers@solomun_entourage@", anim = "mi_dance_facedj_17_v1_female^1", andar = false, loop = true },
	["dancar250"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar251"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center", andar = false, loop = true },
	["dancar252"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center", andar = false, loop = true },
	["dancar253"] = { dict = "mini@strip_club@private_dance@idle", anim = "priv_dance_idle", andar = false, loop = true },
	["dancar254"] = { dict = "mini@strip_club@lap_dance_2g@ld_2g_p1", anim = "ld_2g_p1_s2", andar = false, loop = true },
	["dancar255"] = { dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f", andar = false, loop = true },
	["dancar256"] = { dict = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "dancecrowd_li_11_hu_shimmy_laz", andar = false, loop = true },
	["dancar257"] = { dict = "anim@amb@nightclub@lazlow@hi_dancefloor@", anim = "crowddance_hi_11_handup_laz", andar = false, loop = true },
	["dancar258"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left_down", andar = false, loop = true },
	["dancar259"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", andar = false, loop = true },
	["dancar260"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right", andar = false, loop = true },
	["dancar261"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right_down", andar = false, loop = true },
	["dancar262"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_right_up", andar = false, loop = true },
	["dancar263"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center", andar = false, loop = true },
	["dancar264"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center_down", andar = false, loop = true },
	["dancar265"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_center_up", andar = false, loop = true },
	["dancar266"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left", andar = false, loop = true },
	["dancar267"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left_down", andar = false, loop = true },
	["dancar268"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_left_up", andar = false, loop = true },
	["dancar269"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right", andar = false, loop = true },
	["dancar270"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right_down", andar = false, loop = true },
	["dancar271"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left", andar = false, loop = true },
	["dancar272"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_down", andar = false, loop = true },
	["dancar273"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_left_up", andar = false, loop = true },
	["dancar274"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right", andar = false, loop = true },
	["dancar275"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right_down", andar = false, loop = true },
	["dancar276"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_right_up", andar = false, loop = true },
	["dancar277"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center", andar = false, loop = true },
	["dancar278"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center_down", andar = false, loop = true },
	["dancar279"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_center_up", andar = false, loop = true },
	["dancar280"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left", andar = false, loop = true },
	["dancar281"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_down", andar = false, loop = true },
	["dancar282"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_left_up", andar = false, loop = true },
	["dancar283"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right", andar = false, loop = true },
	["dancar284"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_down", andar = false, loop = true },
	["dancar285"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "med_right_up", andar = false, loop = true },
	["dancar286"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar287"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center_down", andar = false, loop = true },
	["dancar288"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_center_up", andar = false, loop = true },
	["dancar289"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left", andar = false, loop = true },
	["dancar290"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left_down", andar = false, loop = true },
	["dancar291"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_left_up", andar = false, loop = true },
	["dancar292"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right", andar = false, loop = true },
	["dancar293"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right_down", andar = false, loop = true },
	["dancar294"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "high_right_up", andar = false, loop = true },
	["dancar295"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "med_right_up", andar = false, loop = true },
	["dancar296"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center_down", andar = false, loop = true },
	["dancar297"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_center_up", andar = false, loop = true },
	["dancar298"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left", andar = false, loop = true },
	["dancar299"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left_down", andar = false, loop = true },
	["dancar300"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_left_up", andar = false, loop = true },
	["dancar301"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right", andar = false, loop = true },
	["dancar302"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right_down", andar = false, loop = true },
	["dancar303"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "low_right_up", andar = false, loop = true },
	["dancar304"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center", andar = false, loop = true },
	["dancar305"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_down", andar = false, loop = true },
	["dancar306"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar307"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left", andar = false, loop = true },
	["dancar308"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left_down", andar = false, loop = true },
	["dancar309"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_left_up", andar = false, loop = true },
	["dancar310"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right", andar = false, loop = true },
	["dancar311"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right_down", andar = false, loop = true },
	["dancar312"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", anim = "med_right_up", andar = false, loop = true },
	["dancar313"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center", andar = false, loop = true },
	["dancar314"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_down", andar = false, loop = true },
	["dancar315"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar316"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left", andar = false, loop = true },
	["dancar317"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left_down", andar = false, loop = true },
	["dancar318"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_left_up", andar = false, loop = true },
	["dancar319"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right", andar = false, loop = true },
	["dancar320"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right_down", andar = false, loop = true },
	["dancar321"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_right_up", andar = false, loop = true },
	["dancar322"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar323"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center_down", andar = false, loop = true },
	["dancar324"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center_up", andar = false, loop = true },
	["dancar325"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left", andar = false, loop = true },
	["dancar326"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left_down", andar = false, loop = true },
	["dancar327"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_left_up", andar = false, loop = true },
	["dancar328"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right", andar = false, loop = true },
	["dancar329"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right_down", andar = false, loop = true },
	["dancar330"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_right_up", andar = false, loop = true },
	["dancar331"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center", andar = false, loop = true },
	["dancar332"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center_down", andar = false, loop = true },
	["dancar333"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_center_up", andar = false, loop = true },
	["dancar334"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left", andar = false, loop = true },
	["dancar335"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left_down", andar = false, loop = true },
	["dancar336"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_left_up", andar = false, loop = true },
	["dancar337"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right", andar = false, loop = true },
	["dancar338"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right_down", andar = false, loop = true },
	["dancar339"] = { dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "med_right_up", andar = false, loop = true },
	["dancar340"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center", andar = false, loop = true },
	["dancar341"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center_down", andar = false, loop = true },
	["dancar342"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_center_up", andar = false, loop = true },
	["dancar343"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left", andar = false, loop = true },
	["dancar344"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left_down", andar = false, loop = true },
	["dancar345"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_left_up", andar = false, loop = true },
	["dancar346"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right", andar = false, loop = true },
	["dancar347"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right_down", andar = false, loop = true },
	["dancar348"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "high_right_up", andar = false, loop = true },
	["dancar349"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center", andar = false, loop = true },
	["dancar350"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center_down", andar = false, loop = true },
	["dancar351"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_center_up", andar = false, loop = true },
	["dancar352"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left", andar = false, loop = true },
	["dancar353"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left_down", andar = false, loop = true },
	["dancar354"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_left_up", andar = false, loop = true },
	["dancar355"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right", andar = false, loop = true },
	["dancar356"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right_down", andar = false, loop = true },
	["dancar357"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "low_right_up", andar = false, loop = true },
	["dancar358"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center_up", andar = false, loop = true },
	["dancar359"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center_down", andar = false, loop = true },
	["dancar360"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_center_up", andar = false, loop = true },
	["dancar361"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left", andar = false, loop = true },
	["dancar362"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left_down", andar = false, loop = true },
	["dancar363"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_left_up", andar = false, loop = true },
	["dancar364"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right", andar = false, loop = true },
	["dancar365"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right_down", andar = false, loop = true },
	["dancar366"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@", anim = "med_right_up", andar = false, loop = true },
	["dancar367"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_left", andar = false, loop = true },
	["dancar368"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center_down", andar = false, loop = true },
	["dancar369"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center_up", andar = false, loop = true },
	["dancar370"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left", andar = false, loop = true },
	["dancar371"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left_down", andar = false, loop = true },
	["dancar372"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_left_up", andar = false, loop = true },
	["dancar373"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right", andar = false, loop = true },
	["dancar374"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right_down", andar = false, loop = true },
	["dancar375"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_right_up", andar = false, loop = true },
	["dancar376"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center", andar = false, loop = true },
	["dancar377"] = { dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "low_center_down", andar = false, loop = true },

	["argue"] = { dict = "misscarsteal4@actor", anim = "actor_berating_loop", andar = true, loop = true },
	["bird"] = { dict = "random@peyote@bird", anim = "wakeup", andar = true, loop = true },
	["blowkiss"] = { dict = "anim@mp_player_intcelebrationfemale@blow_kiss", anim = "blow_kiss", andar = true, loop = true },
	["bringiton"] = { dict = "misscommon@response", anim = "bring_it_on", andar = true, loop = false },
	["chill"] = { dict = "switch@trevor@scares_tramp", anim = "trev_scares_tramp_idle_tramp", andar = false, loop = true },
	["clapangry"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_a_player_a", andar = true, loop = true },
	["comeatmebro"] = { dict = "mini@triathlon", anim = "want_some_of_this", andar = true, loop = true },
	["crawl"] = { dict = "move_injured_ground", anim = "front_loop", andar = false, loop = true },
	["flip"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "cap_a_player_a", andar = false, loop = false },
	["flip2"] = { dict = "anim@arena@celeb@flat@solo@no_props@", anim = "flip_a_player_a", andar = false, loop = false },
	["meditate"] = { dict = "rcmcollect_paperleadinout@", anim = "meditiate_idle", andar = false, loop = true },
	["peace2"] = { dict = "anim@mp_player_intupperpeace", anim = "idle_a", andar = true, loop = true },
	["prone"] = { dict = "missfbi3_sniping", anim = "prone_dave", andar = false, loop = true },
	["inspect"] = { dict = "random@train_tracks", anim = "idle_e", andar = false, loop = false },
	["sentar7"] = { dict = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_phoneputdown_idle_nowork", andar = false, loop = true },
	["sitchair"] = { dict = "timetable@ron@ig_5_p3", anim = "ig_5_p3_base", andar = false, loop = true },
	["sitchair2"] = { dict = "timetable@reunited@ig_10", anim = "base_amanda", andar = false, loop = true },
	["sitchair3"] = { dict = "timetable@ron@ig_3_couch", anim = "base", andar = false, loop = true },
	["sitchair4"] = { dict = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_tracy", andar = false, loop = true },
	["sitchair5"] = { dict = "timetable@maid@couch@", anim = "base", andar = false, loop = true },
	["superhero"] = { dict = "rcmbarry", anim = "base", andar = true, loop = true },
	["type"] = { dict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_b_idle", andar = true, loop = true },
	["yeah"] = { dict = "anim@mp_player_intupperair_shagging", anim = "idle_a", andar = true, loop = true },
	["sexo"] = { dict = "rcmpaparazzo_2", anim = "shag_loop_poppy", andar = false, loop = true },
	["sexo2"] = { dict = "rcmpaparazzo_2", anim = "shag_loop_a", andar = false, loop = true },
	["sexo3"] = { dict = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging", andar = false, loop = true },
	["sexo4"] = { dict = "oddjobs@towing", anim = "m_blow_job_loop", andar = false, loop = true, cars = true },
	["sexo5"] = { dict = "oddjobs@towing", anim = "f_blow_job_loop", andar = false, loop = true, cars = true },
	["sexo6"] = { dict = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female", andar = false, loop = true, cars = true },
	["sentar"] = { anim = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },
	["sentar2"] = { dict = "amb@world_human_picnic@male@base", anim = "base", andar = false, loop = true },
	["sentar3"] = { dict = "anim@heists@fleeca_bank@ig_7_jetski_owner", anim = "owner_idle", andar = false, loop = true },
	["sentar4"] = { dict = "amb@world_human_stupor@male@base", anim = "base", andar = false, loop = true },
	["sentar5"] = { dict = "amb@world_human_picnic@female@base", anim = "base", andar = false, loop = true },
	["sentar6"] = { dict = "anim@amb@nightclub@lazlow@lo_alone@", anim = "lowalone_base_laz", andar = false, loop = true },
	["beijar"] = { dict = "mp_ped_interaction", anim = "kisses_guy_a", andar = false, loop = false },
	["striper"] = { dict = "mini@strip_club@idles@stripper", anim = "stripper_idle_02", andar = false, loop = true },
	["escutar"] = { dict = "mini@safe_cracking", anim = "idle_base", andar = false, loop = true },
	["alongar"] = { dict = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e", andar = false, loop = true },
	["dj"] = { dict = "anim@mp_player_intupperdj", anim = "idle_a", andar = true, loop = true },
	["rock"] = { dict = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar", andar = false, loop = true },
	["rock2"] = { dict = "mp_player_introck", anim = "mp_player_int_rock", andar = false, loop = false },
	["abracar"] = { dict = "mp_ped_interaction", anim = "hugs_guy_a", andar = false, loop = false },
	["abracar2"] = { dict = "mp_ped_interaction", anim = "kisses_guy_b", andar = false, loop = false },
	["peitos"] = { dict = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b", andar = false, loop = false },
	["espernear"] = { dict = "missfam4leadinoutmcs2", anim = "tracy_loop", andar = false, loop = true },
	["arrumar"] = { dict = "anim@amb@business@coc@coc_packing_hi@", anim = "full_cycle_v1_pressoperator", andar = false, loop = true },
	["bebado"] = { dict = "missfam5_blackout", anim = "pass_out", andar = false, loop = false },
	["bebado2"] = { dict = "missheist_agency3astumble_getup", anim = "stumble_getup", andar = false, loop = false },
	["bebado3"] = { dict = "missfam5_blackout", anim = "vomit", andar = false, loop = false },
	["yoga"] = { dict = "missfam5_yoga", anim = "f_yogapose_a", andar = false, loop = true },
	["yoga2"] = { dict = "amb@world_human_yoga@male@base", anim = "base_a", andar = false, loop = true },
	["abdominal"] = { dict = "amb@world_human_sit_ups@male@base", anim = "base", andar = false, loop = true },
	["pensativo"] = { anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" },
	["britadeira"] = { dict = "amb@world_human_const_drill@male@drill@base", anim = "base", prop = "prop_tool_jackham", flag = 15, mao = 28422 },
	["cerveja"] = { anim = "WORLD_HUMAN_PARTYING" },
	["churrasco"] = { anim = "PROP_HUMAN_BBQ" },
	["consertar"] = { anim = "WORLD_HUMAN_WELDING" },
	["bracos"] = { dict = "anim@heists@heist_corona@single_team", anim = "single_team_loop_boss", andar = true, loop = true },
	["postura3"] = { dict = "mini@strip_club@idles@bouncer@base", anim = "base", andar = true, loop = true },
	["dedos"] = { dict = "anim@mp_player_intupperfinger", anim = "idle_a_fp", andar = true, loop = true },
	["dormir"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_a", andar = false, loop = true },
	["dormir2"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_e", andar = false, loop = true },
	["dormir3"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_react_die_loop_ped_h", andar = false, loop = true },
	["encostar"] = { dict = "amb@lo_res_idles@", anim = "world_human_lean_male_foot_up_lo_res_base", andar = false, loop = true },
	["encostar2"] = { dict = "bs_2a_mcs_10-0", anim = "hc_gunman_dual-0", andar = false, loop = true },
	["estatua"] = { dict = "amb@world_human_statue@base", anim = "base", andar = false, loop = true },
	["flexao"] = { dict = "amb@world_human_push_ups@male@base", anim = "base", andar = false, loop = true },
	["fumar"] = { anim = "WORLD_HUMAN_SMOKING" },
	["fumar2"] = { anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" },
	["fumar3"] = { anim = "WORLD_HUMAN_AA_SMOKE" },
	["fumar4"] = { anim = "WORLD_HUMAN_SMOKING_POT" },
	["fumar5"] = { dict = "amb@world_human_aa_smoke@male@idle_a", anim = "idle_c", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["fumar6"] = { dict = "amb@world_human_aa_smoke@male@idle_a", anim = "idle_b", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["fumar7"] = { dict = "amb@world_human_smoking@female@idle_a", anim = "idle_b", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	["malhar"] = { dict = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base", prop = "prop_curl_bar_01", flag = 49, mao = 28422 },
	["malhar2"] = { dict = "amb@prop_human_muscle_chin_ups@male@base", anim = "base", andar = false, loop = true },
	["martelo"] = { dict = "amb@world_human_hammering@male@base", anim = "base", prop = "prop_tool_hammer", flag = 49, mao = 28422 },
	["pescar"] = { dict = "amb@world_human_stand_fishing@base", anim = "base", prop = "prop_fishing_rod_01", flag = 49, mao = 60309 },
	["pescar2"] = { dict = "amb@world_human_stand_fishing@idle_a", anim = "idle_c", prop = "prop_fishing_rod_01", flag = 49, mao = 60309 },
	["plantar"] = { dict = "amb@world_human_gardener_plant@female@base", anim = "base_female", andar = false, loop = true },
	["plantar2"] = { dict = "amb@world_human_gardener_plant@female@idle_a", anim = "idle_a_female", andar = false, loop = true },
	["procurar"] = { dict = "amb@world_human_bum_wash@male@high@base", anim = "base", andar = false, loop = true },
	["soprador"] = { dict = "amb@code_human_wander_gardener_leaf_blower@base", anim = "static", prop = "prop_leaf_blower_01", flag = 49, mao = 28422 },
	["soprador2"] = { dict = "amb@code_human_wander_gardener_leaf_blower@idle_a", anim = "idle_a", prop = "prop_leaf_blower_01", flag = 49, mao = 28422 },
	["soprador3"] = { dict = "amb@code_human_wander_gardener_leaf_blower@idle_a", anim = "idle_b", prop = "prop_leaf_blower_01", flag = 49, mao = 28422 },
	["tragar"] = { anim = "WORLD_HUMAN_DRUG_DEALER" },
	["trotar"] = { dict = "amb@world_human_jog_standing@male@fitidle_a", anim = "idle_a", andar = false, loop = true },
	["esquentar"] = { anim = "WORLD_HUMAN_STAND_FIRE" },
	["tablet"] = { dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base", anim = "base", prop = "prop_cs_tablet", flag = 50, mao = 28422 },
	["selfie"] = { dict = "cellphone@self", anim = "selfie_in_from_text", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["selfie2"] = { dict = "cellphone@", anim = "cellphone_text_read_base_cover_low", prop = "prop_npc_phone_02", flag = 50, mao = 28422 },
	["mecanico"] = { dict = "amb@world_human_vehicle_mechanic@male@idle_a", anim = "idle_a", andar = false, loop = true },
	["mecanico2"] = { dict = "mini@repair", anim = "fixing_a_player", andar = false, loop = true },
	["mecanico3"] = { dict = "mini@repair", anim = "fixing_a_ped", andar = false, loop = true },
	["mecanico4"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", andar = false, loop = true },
	["mecanico5"] = { dict = "amb@prop_human_movie_bulb@base", anim = "base", andar = true, loop = true },
	["xiu"] = { dict = "anim@mp_player_intincarshushbodhi@ds@", anim = "idle_a_fp", andar = true, loop = true },
	["tapa"] = { dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_slap", andar = false, loop = false },
	["hotwired"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", andar = true, loop = true, cars = true },
	["pano2"] = { dict = "timetable@floyd@clean_kitchen@base", anim = "base", prop = "prop_rag_01", flag = 49, mao = 28422, extra = function()
		local vehicle = vRP.nearVehicle(10)
		if vehicle then
			TriggerEvent("Progress",10000)
			SetTimeout(10000,function()
				TriggerServerEvent("tryClearVehicle",VehToNet(vehicle))
				vRP.removeObjects("one")
			end)
		end
	end },
	["pano"] = { dict = "timetable@maid@cleaning_window@base", anim = "base", prop = "prop_rag_01", flag = 49, mao = 28422, extra = function()
		local vehicle = vRP.nearVehicle(10)
		if vehicle then
			TriggerEvent("Progress",10000)
			SetTimeout(10000,function()
				TriggerServerEvent("tryClearVehicle",VehToNet(vehicle))
				vRP.removeObjects("one")
			end)
		end
	end },
	["cruzar"] = { dict = "random@street_race", anim = "_car_b_lookout", andar = true, loop = true },
	["cruzar2"] = { dict = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", andar = true, loop = true },
	["wait"] = { dict = "random@shop_tattoo", anim = "_idle_a", andar = true, loop = true },
	["wait2"] = { dict = "rcmnigel1cnmt_1c", anim = "base", andar = true, loop = true },
	["wait3"] = { dict = "rcmjosh1", anim = "idle", andar = true, loop = true },
	["wait4"] = { dict = "timetable@amanda@ig_3", anim = "ig_3_base_tracy", andar = true, loop = true },
	["wait5"] = { dict = "misshair_shop@hair_dressers", anim = "keeper_base", andar = true, loop = true },
	["wait6"] = { dict = "jh_1_ig_3-2", anim = "cs_jewelass_dual-2", andar = true, loop = true },
	["knucklecrunch"] = { dict = "anim@mp_player_intcelebrationfemale@knuckle_crunch", anim = "knuckle_crunch", andar = true, loop = false },
	["leanside"] = { dict = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", andar = true, loop = true },
	["no2"] = { dict = "anim@heists@ornate_bank@chat_manager", anim = "fail", andar = true, loop = false },
	["ok"] = { dict = "anim@mp_player_intselfiedock", anim = "idle_a", andar = true, loop = false },
	["screwyou"] = { dict = "misscommon@response", anim = "screw_you", andar = true, loop = false },
	["think"] = { dict = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director", andar = true, loop = true },
	["think2"] = { dict = "missheist_jewelleadinout", anim = "jh_int_outro_loop_a", andar = true, loop = true },
	["think3"] = { dict = "timetable@tracy@ig_8@base", anim = "base", andar = true, loop = true },
	["wave"] = { dict = "random@mugging5", anim = "001445_01_gangintimidation_1_female_idle_b", andar = true, loop = true },
	["wave2"] = { dict = "friends@fra@ig_1", anim = "over_here_idle_a", andar = true, loop = true },
	["wave3"] = { dict = "friends@frj@ig_1", anim = "wave_e", andar = true, loop = true },
	["gangsign"] = { dict = "mp_player_int_uppergang_sign_a", anim = "mp_player_int_gang_sign_a", andar = true, loop = true },
	["gangsign2"] = { dict = "mp_player_int_uppergang_sign_b", anim = "mp_player_int_gang_sign_b", andar = true, loop = true },
	["flipoff"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_c_1st", andar = true, loop = true },
	["bow"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_1st", andar = true, loop = false },
	["headbutt"] = { dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_headbutt", andar = true, loop = false },
	["airplane"] = { dict = "missfbi1", anim = "ledge_loop", andar = true, loop = true },
	["cough"] = { dict = "timetable@gardener@smoking_joint", anim = "idle_cough", andar = true, loop = true },
	["stretch"] = { dict = "mini@triathlon", anim = "idle_f", andar = true, loop = true },
	["punching"] = { dict = "rcmextreme2", anim = "loop_punching", andar = true, loop = true },
	["mindcontrol"] = { dict = "rcmbarry", anim = "bar_1_attack_idle_aln", andar = true, loop = true },
	["clown"] = { dict = "rcm_barry2", anim = "clown_idle_0", andar = false, loop = true },
	["clown2"] = { dict = "rcm_barry2", anim = "clown_idle_1", andar = false, loop = true },
	["clown3"] = { dict = "rcm_barry2", anim = "clown_idle_3", andar = false, loop = true },
	["namaste"] = { dict = "timetable@amanda@ig_4", anim = "ig_4_base", andar = false, loop = true },
	["wave4"] = { dict = "anim@mp_player_intcelebrationfemale@wave", anim = "wave", andar = true, loop = false },
	["wave5"] = { dict = "friends@frj@ig_1", anim = "wave_c", andar = true, loop = false },
	["wave6"] = { dict = "friends@frj@ig_1", anim = "wave_d", andar = true, loop = false },
	["ajustar"] = { dict = "missmic4", anim = "michael_tux_fidget", andar = true, loop = false },
	["argumentar"] = { dict = "oddjobs@assassinate@vice@hooker", anim = "argue_a", andar = true, loop = true },
	["argumentar2"] = { dict = "oddjobs@bailbond_mountain", anim = "excited_idle_b", andar = true, loop = true },
	["argumentar3"] = { dict = "oddjobs@bailbond_hobohang_out_street_c", anim = "idle_c", andar = false, loop = true },
	["argumentar4"] = { dict = "oddjobs@assassinate@old_lady", anim = "looking_for_help", andar = false, loop = true },
	["bow2"] = { dict = "anim@arena@celeb@podium@no_prop@", anim = "regal_a_1st", andar = true, loop = false },
	["boxing"] = { dict = "anim@mp_player_intcelebrationfemale@shadow_boxing", anim = "shadow_boxing", andar = true, loop = true },
	["cop"] = { dict = "amb@code_human_police_investigate@idle_a", anim = "idle_b", andar = true, loop = true },
	["countdown"] = { dict = "random@street_race", anim = "grid_girl_race_start", andar = true, loop = false },
	["crossarms"] = { dict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a", anim = "idle_a", andar = true, loop = true },
	["crossarms2"] = { dict = "amb@world_human_hang_out_street@male_c@idle_a", anim = "idle_b", andar = true, loop = true },
	["crossarms3"] = { dict = "random@shop_gunstore", anim = "_idle", andar = true, loop = true },
	["crossarms4"] = { dict = "rcmnigel1a_band_groupies", anim = "base_m2", andar = true, loop = true },
	["reverencia"] = { dict = "anim@mp_player_intcelebrationpaired@f_f_sarcastic", anim = "sarcastic_left", andar = true, loop = true },
	["cutthroat2"] = { dict = "anim@mp_player_intcelebrationfemale@cut_throat", anim = "cut_throat", andar = true, loop = false },
	["damn"] = { dict = "gestures@m@standing@casual", anim = "gesture_damn", andar = true, loop = false },
	["damn2"] = { dict = "misscommon@response", anim = "damn", andar = true, loop = false },
	["handshake"] = { dict = "mp_ped_interaction", anim = "handshake_guy_a", andar = true, loop = false },
	["handshake2"] = { dict = "mp_ped_interaction", anim = "handshake_guy_b", andar = true, loop = false },
	["parado"] = { dict = "anim@heists@heist_corona@team_idles@male_a", anim = "idle", andar = true, loop = true },
	["parado2"] = { dict = "anim@heists@heist_corona@team_idles@female_a", anim = "idle", andar = true, loop = true },
	["parado3"] = { dict = "anim@heists@humane_labs@finale@strip_club", anim = "ped_b_celebrate_loop", andar = true, loop = true },
	["parado4"] = { dict = "anim@mp_celebration@idles@female", anim = "celebration_idle_f_a", andar = true, loop = true },
	["parado5"] = { dict = "anim@mp_corona_idles@female_b@idle_a", anim = "idle_a", andar = true, loop = true },
	["parado6"] = { dict = "anim@mp_corona_idles@male_c@idle_a", anim = "idle_a", andar = true, loop = true },
	["parado7"] = { dict = "anim@mp_corona_idles@male_d@idle_a", anim = "idle_a", andar = true, loop = true },
	["parado8"] = { dict = "amb@world_human_hang_out_street@male_b@idle_a", anim = "idle_b", andar = true, loop = true },
	["parado9"] = { dict = "friends@fra@ig_1", anim = "base_idle", andar = true, loop = true },
	["parado10"] = { dict = "mp_move@prostitute@m@french", anim = "idle", andar = true, loop = true },
	["parado11"] = { dict = "random@countrysiderobbery", anim = "idle_a", andar = true, loop = true },
	["idledrunk"] = { dict = "random@drunk_driver_1", anim = "drunk_driver_stand_loop_dd1", andar = true, loop = true },
	["idledrunk2"] = { dict = "random@drunk_driver_1", anim = "drunk_driver_stand_loop_dd2", andar = true, loop = true },
	["idledrunk3"] = { dict = "missarmenian2", anim = "standing_idle_loop_drunk", andar = true, loop = true },
	["jog3"] = { dict = "amb@world_human_jog_standing@female@idle_a", anim = "idle_a", andar = true, loop = true },
	["lean2"] = { dict = "amb@world_human_leaning@female@wall@back@hand_up@idle_a", anim = "idle_a", andar = true, loop = true },
	["lean3"] = { dict = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", anim = "idle_a", andar = true, loop = true },
	["leanbar"] = { dict = "amb@prop_human_bum_shopping_cart@male@idle_a", anim = "idle_c", andar = true, loop = true },
	["leanbar2"] = { dict = "anim@amb@nightclub@lazlow@ig1_vip@", anim = "clubvip_base_laz", andar = true, loop = true },
	["leanbar3"] = { dict = "anim@heists@prison_heist", anim = "ped_b_loop_a", andar = true, loop = true },
	["me"] = { dict = "gestures@f@standing@casual", anim = "gesture_me_hard", andar = true, loop = false },
	["mecanico6"] = { dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", andar = true, loop = true },
	["metal"] = { dict = "anim@mp_player_intincarrockstd@ps@", anim = "idle_a", andar = true, loop = true },
	["mindblown"] = { dict = "anim@mp_player_intcelebrationmale@mind_blown", anim = "mind_blown", andar = true, loop = true },
	["mindblown2"] = { dict = "anim@mp_player_intcelebrationfemale@mind_blown", anim = "mind_blown", andar = true, loop = true },
	["mindcontrol2"] = { dict = "rcmbarry", anim = "mind_control_b_loop", andar = true, loop = true },
	["nervoso2"] = { dict = "amb@world_human_bum_standing@twitchy@idle_a", anim = "idle_c", andar = true, loop = true },
	["nervoso3"] = { dict = "mp_missheist_countrybank@nervous", anim = "nervous_idle", andar = true, loop = true },
	["olhadinha"] = { dict = "random@paparazzi@peek", anim = "left_peek_a", andar = true, loop = true },
	["pointdown"] = { dict = "gestures@f@standing@casual", anim = "gesture_hand_down", andar = true, loop = false },
	["banho"] = { dict = "mp_safehouseshower@male@", anim = "male_shower_idle_a", andar = true, loop = true },
	["cokecut"] = { dict = "anim@amb@business@coc@coc_unpack_cut@", anim = "fullcut_cycle_v6_cokecutter", andar = true, loop = true },
	["taxi"] = { dict = "taxi_hail", anim = "hail_taxi", andar = true, loop = false },
	["medo"] = { dict = "amb@code_human_cower@male@base", anim = "base", andar = true, loop = true },
	["preocupado"] = { dict = "random@homelandsecurity", anim = "knees_loop_girl", andar = true, loop = true },
	["conv"] = { dict = "special_ped@jessie@monologue_5@monologue_5c", anim = "jessie_ig_1_p5_heressomthinginteresting_2", andar = true, loop = false },
	["conv2"] = { dict = "special_ped@jessie@monologue_11@monologue_11c", anim = "jessie_ig_1_p11_canyouimagine_2", andar = true, loop = true },
	["conv3"] = { dict = "rcmjosh4", anim = "beckon_a_cop_b", andar = true, loop = true },
	["ohno"] = { dict = "misscommon@response", anim = "numbnuts", andar = true, loop = false },
	["ohno2"] = { dict = "misscommon@response", anim = "give_me_a_break", andar = true, loop = false },
	["limpar2"] = { dict = "move_m@_idles@shake_off", anim = "shakeoff_1", andar = true, loop = false },
	["ferido"] = { dict = "random@dealgonewrong", anim = "idle_a", andar = false, loop = true },
	["sleep"] = { dict = "timetable@tracy@sleep@", anim = "idle_c", andar = false, loop = true, },
	["fedor"] = { dict = "anim@mp_player_intcelebrationfemale@stinker", anim = "stinker", andar = true, loop = false },
	["estatua2"] = { dict = "fra_0_int-1", anim = "cs_lamardavis_dual-1", andar = false, loop = true },
	["estatua3"] = { dict = "club_intro2-0", anim = "csb_englishdave_dual-0", andar = false, loop = true },
	["shrug"] = { dict = "gestures@m@standing@casual", anim = "gesture_shrug_hard", andar = true, loop = false },
	["sitscared"] = { dict = "anim@heists@ornate_bank@hostages@hit", anim = "hit_loop_ped_b", andar = false, loop = true },
	["sitscared2"] = { dict = "anim@heists@ornate_bank@hostages@ped_c@", anim = "flinch_loop", andar = false, loop = true },
	["sitscared3"] = { dict = "anim@heists@ornate_bank@hostages@ped_e@", anim = "flinch_loop", andar = false, loop = true },
	["sitscared4"] = { dict = "amb@code_human_cower@male@base", anim = "base", andar = false, loop = true },
	["stunned"] = { dict = "stungun@standing", anim = "damage", andar = false, loop = true },
	["think5"] = { dict = "mp_cp_welcome_tutthink", anim = "b_think", andar = true, loop = false },
	["joia3"] = { dict = "anim@mp_player_intupperthumbs_up", anim = "idle_a", andar = true, loop = false },
	["tryclothes"] = { dict = "mp_clothing@female@trousers", anim = "try_trousers_neutral_a", andar = false, loop = false },
	["tryclothes2"] = { dict = "mp_clothing@female@shirt", anim = "try_shirt_positive_a", andar = false, loop = false },
	["tryclothes3"] = { dict = "mp_clothing@female@shoes", anim = "try_shoes_positive_a", andar = false, loop = false },
	["tryclothes4"] = { dict = "clothingtie", anim = "try_tie_neutral_c", andar = false, loop = false },
	["tryclothes5"] = { dict = "clothingtie", anim = "try_tie_neutral_d", andar = false, loop = false },
	["washhand"] = { dict = "missheist_agency3aig_23", anim = "urinal_sink_loop", andar = false, loop = true },
	["checkout"] = { dict = "anim@amb@carmeet@checkout_car@male_a@idles", anim = "idle_b", andar = false, loop = false },
	["checkout2"] = { dict = "anim@amb@carmeet@checkout_car@male_c@idles", anim = "idle_a", andar = false, loop = true },
	["dj3"] = { dict = "anim@scripted@nightclub@dj@dj_moodm@", anim = "moodm_cdj_left_a_12", andar = false, loop = true },
	["dj4"] = { dict = "anim@amb@nightclub_island@dancers@crowddance_facedj_transitions@from_low_intensity", anim = "trans_dance_facedj_li_to_mi_11_v1_male^3", andar = false, loop = true },
	["noway"] = { dict = "oddjobs@towingpleadingbase", anim = "base", andar = false, loop = false },
	["noway2"] = { dict = "gestures@m@car@std@casual@ds", anim = "gesture_no_way", andar = false, loop = false },
	["why"] = { dict = "random@shop_robbery_reactions@", anim = "is_this_it", andar = false, loop = false },
	["shock"] = { dict = "random@shop_robbery_reactions@", anim = "shock", andar = false, loop = false },
	["good"] = { dict = "missclothing", anim = "good_choice_storeclerk", andar = false, loop = false },
	["sunbathem"] = { dict = "amb@world_human_sunbathe@male@back@idle_a", anim = "idle_c", andar = false, loop = true },
	["jogger"] = { dict = "move_f@jogger", anim = "idle", andar = false, loop = true },
	["jogger2"] = { dict = "move_m@jogger", anim = "idle", andar = false, loop = true },
	["swatch"] = { dict = "amb@world_human_strip_watch_stand@male_c@idle_a", anim = "idle_b", andar = false, loop = true },
	["wait7"] = { dict = "oddjobs@taxi@", anim = "idle_a", andar = false, loop = true },
	["wait8"] = { dict = "amb@world_human_bum_standing@twitchy@base", anim = "base", andar = true, loop = true },
	["musculo"] = { dict = "oddjobs@assassinate@multi@", anim = "idle_a", andar = false, loop = false },
	["lookplan"] = { dict = "missheist_agency2aig_4", anim = "look_plan_c_worker2", andar = false, loop = true },
	["thanks"] = { dict = "random@arrests", anim = "thanks_male_05", andar = false, loop = false },
	["sexo7"] = { dict = "timetable@trevor@skull_loving_bear", anim = "skull_loving_bear", andar = false, loop = true },
	["sitchair6"] = { dict = "timetable@reunited@ig_10", anim = "isthisthebest_jimmy", andar = false, loop = true },
	["sitchair7"] = { dict = "timetable@michael@on_sofabase", anim = "sit_sofa_base", andar = false, loop = true },
	["sitchair8"] = { dict = "timetable@trevor@smoking_meth@base", anim = "base", andar = false, loop = true }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("emotes")
AddEventHandler("emotes",function(nome)
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()

		if animacoes[nome] and not IsPedArmed(ped,6) and not IsPedSwimming(ped) then
			if GetEntityHealth(ped) > 101 and vSERVER.checkInventory() then
				vRP.removeObjects("one")

				if not IsPedInAnyVehicle(ped) and not animacoes[nome]["cars"] then
					if animacoes[nome]["extra"] then
						animacoes[nome].extra()
					end

					if animacoes[nome]["altura"] and animacoes[nome]["anim"] == nil then
						vRP.createObjects("","",animacoes[nome]["prop"],animacoes[nome]["flag"],animacoes[nome]["mao"],animacoes[nome]["altura"],animacoes[nome]["pos1"],animacoes[nome]["pos2"],animacoes[nome]["pos3"],animacoes[nome]["pos4"],animacoes[nome]["pos5"])
					elseif animacoes[nome]["altura"] and animacoes[nome]["anim"] then
						vRP.createObjects(animacoes[nome]["dict"],animacoes[nome]["anim"],animacoes[nome]["prop"],animacoes[nome]["flag"],animacoes[nome]["mao"],animacoes[nome]["altura"],animacoes[nome]["pos1"],animacoes[nome]["pos2"],animacoes[nome]["pos3"],animacoes[nome]["pos4"],animacoes[nome]["pos5"])
					elseif animacoes[nome]["prop"] then
						vRP.createObjects(animacoes[nome]["dict"],animacoes[nome]["anim"],animacoes[nome]["prop"],animacoes[nome]["flag"],animacoes[nome]["mao"])
					elseif animacoes[nome]["dict"] then
						vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
					else
						vRP.playAnim(false,{ task = animacoes[nome]["anim"] },false)
					end
				else
					if IsPedInAnyVehicle(ped) and animacoes[nome]["cars"] then
						local vehicle = GetVehiclePedIsUsing(ped)

						if (GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,1) == ped) and nome == "sexo4" then
							vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
						elseif (GetPedInVehicleSeat(vehicle,0) == ped or GetPedInVehicleSeat(vehicle,2) == ped) and (nome == "sexo5" or nome == "sexo6") then
							vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
						elseif nome == "hotwired" then
							vRP.playAnim(animacoes[nome]["andar"],{animacoes[nome]["dict"],animacoes[nome]["anim"]},animacoes[nome]["loop"])
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if (binoculos or cameras) then
			timeDistance = 1

			local ped = PlayerPedId()
			local scaleform = RequestScaleformMovie("BINOCULARS")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(1)
			end

			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,ped,0.0,0.0,1.0,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(ped))
			SetCamFov(cam,fov)
			RenderScriptCams(true,false,0,1,0)

			while (binoculos or cameras) and true do
				Citizen.Wait(1)

				local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
				CheckInputRotation(cam,zoomvalue)
				HandleZoom(cam)

				if binoculos then
					DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
				end

				if IsPedArmed(PlayerPedId(),6) then
					TriggerServerEvent("inventory:Cancel")
					binoculos = false
					cameras = false
				end
			end

			fov = (fov_max + fov_min) * 0.5
			RenderScriptCams(false,false,0,1,0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam,false)
			SetNightvision(false)
			SetSeethrough(false)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEBINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("useBinoculos")
AddEventHandler("useBinoculos",function()
	binoculos = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEBINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("useCamera")
AddEventHandler("useCamera",function()
	cameras = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("binoculos")
AddEventHandler("binoculos",function()
	if IsEntityPlayingAnim(PlayerPedId(),"amb@world_human_binoculars@male@enter","enter",3) then
		binoculos = true
	else
		binoculos = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINOCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("camera")
AddEventHandler("camera",function()
	if IsEntityPlayingAnim(PlayerPedId(),"amb@world_human_paparazzi@male@base","base",3) then
		cameras = true
	else
		cameras = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * 8.0 * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0,rotation["x"] + rightAxisY * -1.0 * 8.0 * (zoomvalue + 0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(cam)
	if IsControlJustPressed(1,241) then
		fov = math.max(fov - 10.0,fov_min)
	end

	if IsControlJustPressed(1,242) then
		fov = math.min(fov + 10.0,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam,current_fov + (fov - current_fov) * 0.05)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local treatmentTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= treatmentTimers then
			treatmentTimers = GetGameTimer() + 5000

			if tratamento then
				local ped = PlayerPedId()
				local health = GetEntityHealth(ped)

				if health < 200 then
					SetEntityHealth(ped,health + 1)
				else
					tratamento = false
					ClearPedBloodDamage(ped)
					LocalPlayer["state"]["Cancel"] = false
					LocalPlayer["state"]["Commands"] = false
					TriggerEvent("Notify","verde","Tratamento concluido.",3000)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)