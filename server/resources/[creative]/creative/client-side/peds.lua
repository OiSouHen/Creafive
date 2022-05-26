-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	{ -- Concessionária
		distance = 30,
		coords = { 1230.03,2733.74,38.03,93.55 },
		model = { 0x45753032,"ig_ramp_hic" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- TowDriver
		distance = 100,
		coords = { -273.96,6121.63,31.41,130.4 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- TowDriver
		distance = 100,
		coords = { 1737.95,3709.1,34.14,19.85 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- TowDriver
		distance = 30,
		coords = { -193.23,-1162.39,23.67,274.97 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- WeedShop
		distance = 30,
		coords = { -1171.3,-1571.12,4.67,127.56 },
		model = { 0xE83B93B7,"g_m_y_famca_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Coveiro
		distance = 100,
		coords = { -1745.92,-204.83,57.39,320.32 },
		model = { 0xF1E823A2,"g_m_m_armboss_01" },
		anim = { "timetable@trevor@smoking_meth@base","base" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2440.58,4736.35,34.29,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2432.5,4744.58,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2424.47,4752.37,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2416.28,4760.8,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2408.6,4768.88,34.31,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2400.32,4777.48,34.53,317.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2432.46,4802.66,34.83,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2440.62,4794.22,34.66,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2448.65,4786.57,34.64,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2456.88,4778.08,34.49,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2464.53,4770.04,34.37,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2473.38,4760.98,34.31,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2495.03,4762.77,34.37,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2503.13,4754.08,34.31,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2511.34,4746.04,34.31,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Leiteiro
		distance = 100,
		coords = { 2519.56,4737.35,34.29,137.50 },
		model = { 0xFCFA9E1E,"a_c_cow" }
	},
	{ -- Agricultor
		distance = 100,
		coords = { 2301.09,5064.78,45.81,170.08 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Imobiliária
		distance = 100,
		coords = { 1655.27,4874.31,42.04,280.63 },
		model = { 0x3293B9CE,"mp_f_boatstaff_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Imobiliária
		distance = 100,
		coords = { -308.09,-163.93,40.42,238.12 },
		model = { 0x3293B9CE,"mp_f_boatstaff_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Salary
		distance = 30,
		coords = { -110.16,6468.93,31.63,133.23 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { -111.21,6469.98,31.63,133.23 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { -112.25,6471.08,31.63,133.23 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { 254.05,222.73,106.30,158.75 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { 252.26,223.39,106.30,158.75 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { 248.95,224.59,106.30,158.75 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { 247.15,225.25,106.30,158.75 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { 243.82,226.46,106.30,158.75 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Salary
		distance = 30,
		coords = { 242.02,227.11,106.30,158.75 },
		model = { 0x5D71A46F,"s_f_y_airhostess_01" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -544.78,-185.86,52.2,300.48 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -551.1,-191.07,38.22,221.11 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Prefeitura
		distance = 30,
		coords = { -553.3,-192.34,38.22,206.93 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@prison_heistig1_p1_guard_checks_bus","loop" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.86,4967.66,42.34,133.23 },
		model = { 0xF42EE883,"g_m_y_ballaeast_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.09,4970.72,42.34,42.52 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2436.08,4965.39,42.34,226.78 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2434.4,4963.8,42.34,229.61 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2432.44,4964.06,42.34,178.59 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2431.57,4965.22,42.34,124.73 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@world_human_bum_wash@male@high@base","base" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2428.67,4969.51,42.34,133.23 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2437.05,4967.61,42.34,317.49 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2433.09,4971.51,42.34,320.32 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2432.67,4970.29,42.34,226.78 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Black Market
		distance = 20,
		coords = { 2435.28,4969.27,42.34,317.49 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" }
	},
	{ -- Taxi
		distance = 50,
		coords = { -1039.34,-2730.8,20.2,235.28 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 301.4,-195.29,61.57,158.75 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 169.28,-1536.23,29.25,311.82 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 487.56,-1456.11,29.28,272.13 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 154.66,-1472.9,29.35,325.99 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 389.69,-942.1,29.42,175.75 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 475.1,3555.28,33.23,263.63 },
		model = { 0x158C439C,"g_f_y_ballas_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 112.41,3373.68,35.25,59.53 },
		model = { 0xF42EE883,"g_m_y_ballaeast_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 2013.95,4990.88,41.21,133.23 },
		model = { 0x23B88069,"g_m_y_ballasout_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { 186.9,6374.75,32.33,206.93 },
		model = { 0xE83B93B7,"g_m_y_famca_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Ilegal
		distance = 100,
		coords = { -653.2,-1502.18,5.24,201.26 },
		model = { 0xDB729238,"g_m_y_famdnf_01" },
		anim = { "amb@lo_res_idles@","world_human_lean_male_foot_up_lo_res_base" }
	},
	{ -- Police
		distance = 100,
		coords = { 392.56,-1632.1,29.28,28.35 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 381.17,-1634.05,29.28,343.0 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 382.12,-1617.63,29.28,232.45 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 377.58,791.66,187.64,130.4 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 1855.19,3714.64,33.97,161.58 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 1809.04,3687.51,33.97,257.96 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { -479.48,6011.12,31.29,175.75 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { -459.37,6016.01,31.49,42.52 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 463.15,-982.33,43.69,87.88 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Police
		distance = 100,
		coords = { 443.49,-974.47,25.7,181.42 },
		model = { 0x15F8700D,"s_f_y_cop_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { -271.7,6321.75,32.42,0.0 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { -253.92,6339.42,32.42,5.67 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { 338.19,-586.91,74.16,252.29 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Paramedic
		distance = 100,
		coords = { 340.08,-576.19,28.8,73.71 },
		model = { 0xB353629E,"s_m_m_paramedic_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 24.9,-1346.8,29.49,269.3 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 2556.74,381.24,108.61,357.17 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1164.82,-323.65,69.2,96.38 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -706.15,-914.53,19.21,85.04 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -47.38,-1758.68,29.42,42.52 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 373.1,326.81,103.56,257.96 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { -3242.75,1000.46,12.82,354.34 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1728.47,6415.46,35.03,240.95 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1960.2,3740.68,32.33,297.64 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 2677.8,3280.04,55.23,331.66 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1697.31,4923.49,42.06,325.99 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { -1819.52,793.48,138.08,127.56 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 6,
		coords = { 1391.69,3605.97,34.98,198.43 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -2966.41,391.55,15.05,85.04 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -3039.54,584.79,7.9,14.18 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1134.33,-983.11,46.4,274.97 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 1165.28,2710.77,38.15,175.75 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -1486.72,-377.55,40.15,130.4 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -1221.45,-907.92,12.32,31.19 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 161.2,6641.66,31.69,223.94 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { 548.7,2670.73,42.16,96.38 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Departament Store
		distance = 10,
		coords = { -160.61,6320.88,31.58,314.65 },
		model = { 0x18CE57D0,"mp_m_shopkeep_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 1696.88,3758.39,34.69,133.23 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 248.17,-51.78,69.94,340.16 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 841.18,-1030.12,28.19,266.46 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -327.07,6082.22,31.46,130.4 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -659.18,-938.47,21.82,85.04 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -1309.43,-394.56,36.7,343.0 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -1113.41,2698.19,18.55,127.56 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 2564.83,297.46,108.73,269.3 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { -3168.32,1087.46,20.84,150.24 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 16.91,-1107.56,29.79,158.75 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		distance = 12,
		coords = { 814.84,-2155.14,29.62,357.17 },
		model = { 0x467415E9,"ig_dale" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Life Invader
		distance = 20,
		coords = { -1083.15,-245.88,37.76,209.77 },
		model = { 0x2F8845A3,"ig_barry" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { -172.89,6381.32,31.48,223.94 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 30,
		coords = { 1690.07,3581.68,35.62,212.6 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 326.5,-1074.43,29.47,0.0 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pharmacy Store
		distance = 15,
		coords = { 114.39,-4.85,67.82,204.1 },
		model = { 0x5244247D,"u_m_y_baygor" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 50,
		coords = { 46.65,-1749.7,29.62,51.03 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Crafting
		distance = 50,
		coords = { 47.5,-1748.22,29.64,82.21 },
		model = { 0x3521A8D2,"a_m_y_genstreet_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Central
		distance = 50,
		coords = { 2747.31,3473.07,55.67,249.45 },
		model = { 0xE6631195,"ig_cletus" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mercado Crafting
		distance = 50,
		coords = { 2746.88,3471.43,55.67,274.97 },
		model = { 0x3521A8D2,"a_m_y_genstreet_02" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { -428.54,-1728.29,19.78,70.87 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { 180.07,2793.29,45.65,283.47 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Recycling Sell
		distance = 50,
		coords = { -195.42,6264.62,31.49,42.52 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bar
		distance = 15,
		coords = { 129.71,-1284.65,29.27,119.06 },
		model = { 0x780C01BD,"s_f_y_bartender_01" },
		anim = { "amb@prop_human_bum_shopping_cart@male@base","base" }
	},
	{ -- Arcade
		distance = 25,
		coords = { -1653.78,-1062.18,12.15,138.9 },
		model = { 0x780C01BD,"s_f_y_bartender_01" },
		anim = { "amb@prop_human_bum_shopping_cart@male@base","base" }
	},
	{ -- Bowling
		distance = 25,
		coords = { 756.32,-768.02,26.34,90.71 },
		model = { 0x780C01BD,"s_f_y_bartender_01" },
		anim = { "amb@prop_human_bum_shopping_cart@male@base","base" }
	},
	{ -- Bar
		distance = 15,
		coords = { -561.75,286.7,82.18,266.46 },
		model = { 0xE11A9FB4,"ig_josef" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Jewelry
		distance = 15,
		coords = { -628.79,-238.7,38.05,311.82 },
		model = { 0xC314F727,"cs_gurk" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Oxy Store
		distance = 30,
		coords = { -1636.74,-1092.17,13.08,320.32 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Moto Club
		distance = 12,
		coords = { 987.46,-95.61,74.85,226.78 },
		model = { 0x6CCFE08A,"ig_clay" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Moto Club
		distance = 30,
		coords = { 2512.3,4098.11,38.59,243.78 },
		model = { 0x6CCFE08A,"ig_clay" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Transportador
		distance = 30,
		coords = { 354.14,270.56,103.02,345.83 },
		model = { 0xE0FA2554,"ig_casey" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 30,
		coords = { -840.64,5398.94,34.61,303.31 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lenhador
		distance = 30,
		coords = { -842.92,5403.49,34.61,300.48 },
		model = { 0x1C95CB0B,"u_m_m_markfost" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Minerador
		distance = 30,
		coords = { 2964.43,2752.88,43.32,215.44 },
		model = { 0xD7DA9E99,"s_m_y_construct_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Mergulhador
		distance = 20,
		coords = { 1520.56,3780.08,34.46,274.97 },
		model = { 0xC79F6928,"a_f_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Garagem The Boat House
		distance = 50,
		coords = { 1509.64,3788.7,33.51,266.46 },
		model = { 0xC79F6928,"a_f_y_beach_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Colheita
		distance = 30,
		coords = { 406.08,6526.17,27.75,87.88 },
		model = { 0x94562DD7,"a_m_m_farmer_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Motorista
		distance = 30,
		coords = { 452.97,-607.75,28.59,266.46 },
		model = { 0x2A797197,"u_m_m_edtoh" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 82.98,-1553.55,29.59,51.03 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { 287.77,2843.9,44.7,121.89 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Lixeiro
		distance = 50,
		coords = { -413.97,6171.58,31.48,320.32 },
		model = { 0xEE75A00F,"s_m_y_garbage" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1127.26,-1439.35,5.22,303.31 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 78.26,-1388.91,29.37,178.59 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -706.73,-151.38,37.41,116.23 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -166.69,-301.55,39.73,249.45 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -817.5,-1074.03,11.32,119.06 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1197.33,-778.98,17.32,31.19 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1447.84,-240.03,49.81,45.36 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -0.07,6511.8,31.88,311.82 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 1691.6,4818.47,42.06,2.84 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 123.21,-212.34,54.56,255.12 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 621.24,2753.37,42.09,90.71 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { 1200.68,2707.35,38.22,85.04 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -3172.39,1055.31,20.86,246.62 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Roupas
		distance = 20,
		coords = { -1096.53,2711.1,19.11,127.56 },
		model = { 0x689C2A80,"a_f_y_epsilon_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 1324.38,-1650.09,52.27,127.56 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -1152.27,-1423.81,4.95,124.73 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 319.84,180.89,103.58,246.62 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -3170.41,1073.06,20.83,334.49 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { 1862.58,3748.52,33.03,28.35 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Loja de Tatuagem
		distance = 6,
		coords = { -292.02,6199.72,31.49,223.94 },
		model = { 0x1475B827,"a_f_y_hippie_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 894.9,-179.15,74.7,240.95 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxista
		distance = 30,
		coords = { 1696.19,4785.25,42.02,93.55 },
		model = { 0x8674D5FC,"a_m_y_stlat_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 10,
		coords = { -679.13,5839.52,17.32,226.78 },
		model = { 0xCE1324DE,"ig_hunter" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caçador
		distance = 30,
		coords = { -695.56,5802.12,17.32,65.2 },
		model = { 0x1536D95A,"a_m_o_ktown_01" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Animal Park
		distance = 15,
		coords = { 563.19,2752.92,42.87,187.09 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Pescador
		distance = 30,
		coords = { 1524.77,3783.84,34.49,187.09 },
		model = { 0x51C03FA4,"a_f_y_eastsa_03" },
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for k,v in pairs(pedList) do
			local distance = #(coords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= v["distance"] then
				if localPeds[k] == nil then
					local mHash = GetHashKey(v["model"][2])

					RequestModel(mHash)
					while not HasModelLoaded(mHash) do
						Citizen.Wait(1)
					end

					if HasModelLoaded(mHash) then
						localPeds[k] = CreatePed(4,v["model"][1],v["coords"][1],v["coords"][2],v["coords"][3] - 1,v["coords"][4],false,false)
						SetPedArmour(localPeds[k],100)
						SetEntityInvincible(localPeds[k],true)
						FreezeEntityPosition(localPeds[k],true)
						SetBlockingOfNonTemporaryEvents(localPeds[k],true)

						SetModelAsNoLongerNeeded(mHash)

						if v["anim"] ~= nil then
							RequestAnimDict(v["anim"][1])
							while not HasAnimDictLoaded(v["anim"][1]) do
								Citizen.Wait(1)
							end

							TaskPlayAnim(localPeds[k],v["anim"][1],v["anim"][2],8.0,0.0,-1,1,0,0,0,0)
						end
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)