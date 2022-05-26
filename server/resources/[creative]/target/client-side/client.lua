-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local innerEntity = {}
local sucessTarget = false
local targetActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATELOCS
-----------------------------------------------------------------------------------------------------------------------------------------
local locateLocs = {
	{ -832.41,-393.87,31.32,"Desmanche" },
	{ 2645.42,4253.48,44.79,"Desmanche" },
	{ 963.18,-1856.79,31.19,"Desmanche" },
	{ -142.24,-1174.19,23.76,"Reboque" },
	{ 1724.84,3715.31,34.22,"Reboque" },
	{ -305.45,6117.62,31.49,"Reboque" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddCircleZone("callTaxi",vector3(-1038.98,-2731.16,20.17),0.75,{
		name = "callTaxi",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "smartphone:callTaxi",
				label = "Chamar Taxi",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("bankSalary01",vector3(241.43,225.46,106.29),0.75,{
		name = "bankSalary01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary02",vector3(243.21,224.77,106.29),0.75,{
		name = "bankSalary02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary03",vector3(246.62,223.61,106.29),0.75,{
		name = "bankSalary03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary04",vector3(248.43,222.95,106.29),0.75,{
		name = "bankSalary04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary05",vector3(251.79,221.73,106.29),0.75,{
		name = "bankSalary05",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary06",vector3(253.59,221.08,106.29),0.75,{
		name = "bankSalary06",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary07",vector3(-113.01,6470.21,31.63),0.75,{
		name = "bankSalary07",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary08",vector3(-111.99,6469.15,31.63),0.75,{
		name = "bankSalary08",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary09",vector3(-110.92,6468.1,31.63),0.75,{
		name = "bankSalary09",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("treatment01",vector3(-253.92,6331.07,32.42),0.75,{
		name = "treatment01",
		heading = 3374176
	},{
		shop = "Paleto",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment02",vector3(1833.21,3676.09,34.27),0.75,{
		name = "treatment02",
		heading = 3374176
	},{
		shop = "Sandy",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment03",vector3(307.03,-595.12,43.29),0.75,{
		name = "treatment03",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment04",vector3(350.92,-587.68,28.8),0.75,{
		name = "treatment04",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment05",vector3(1768.67,2570.59,45.73),0.75,{
		name = "treatment05",
		heading = 3374176
	},{
		shop = "Bolingbroke",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment06",vector3(-469.26,6289.48,13.61),0.75,{
		name = "treatment06",
		heading = 3374176
	},{
		shop = "Clandestine",
		distance = 1.0,
		options = {
			{
				event = "checkin:initCheck",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher",
				tunnel = "police",
				service = "emptybottle"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddCircleZone("Yoga01",vec3(-492.83,-217.31,35.61),0.75,{
		name = "Yoga01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga02",vec3(-492.87,-219.03,36.55),0.75,{
		name = "Yoga02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga03",vec3(-492.89,-220.68,36.51),0.75,{
		name = "Yoga03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga04",vec3(-490.21,-220.91,36.51),0.75,{
		name = "Yoga04",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga05",vec3(-490.18,-219.24,36.58),0.75,{
		name = "Yoga05",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga06",vec3(-490.16,-217.33,36.63),0.75,{
		name = "Yoga06",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddTargetModel({ 1631638868,2117668672,-1498379115,-1519439119,-289946279 },{
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:burgerMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -272361894 },{
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -832573324,-1430839454,1457690978,1682622302,402729631,-664053099,1794449327,307287994,-1323586730,111281960,-541762431,-745300483,-417505688 },{
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "police"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 1281992692,1158960338,1511539537,-78626473 },{
		options = {
			{
				event = "hup:phoneObject",
				label = "Ligar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ -206690185,666561306,218085040,-58485588,1511880420,682791951 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			},
			{
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1211559620,1363150739,-1186769817,261193082,-756152956,-1383056703,720581693 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Jornaleiro"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -2007231801,1339433404,1694452750,1933174915,-462817101,-469694731,-164877493 },{
		options = {
			{
				event = "crafting:fuelShop",
				label = "Combustível",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddCircleZone("foodJuice01",vector3(-1190.78,-904.23,13.99),0.5,{
		name = "foodJuice01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodJuice02",vector3(-1190.12,-905.16,13.99),0.5,{
		name = "foodJuice02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodJuice03",vector3(1585.82,6459.13,26.02),0.5,{
		name = "foodJuice03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodJuice04",vector3(810.69,-764.42,26.77),0.5,{
		name = "foodJuice04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	AddCircleZone("foodBurger01",vector3(-1202.08,-897.21,13.99),0.5,{
		name = "foodBurger01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

	AddCircleZone("foodBurger02",vector3(-1202.55,-896.55,13.99),0.5,{
		name = "foodBurger02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

	AddCircleZone("foodBurger03",vector3(1587.93,6458.15,26.02),0.5,{
		name = "foodBurger03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

	AddCircleZone("foodBurger04",vector3(1587.33,6458.44,26.02),0.5,{
		name = "foodBurger04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

	AddCircleZone("foodBurger05",vector3(807.67,-762.31,26.77),0.5,{
		name = "foodBurger05",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

	AddCircleZone("foodBurger06",vector3(807.68,-760.2,26.77),0.5,{
		name = "foodBurger06",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

	AddCircleZone("foodBox01",vector3(-1197.91,-892.21,13.99),0.5,{
		name = "foodBox01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Combo",
				tunnel = "police",
				service = "foodBox"
			}
		}
	})

	AddCircleZone("foodBox02",vector3(1592.02,6456.23,26.02),0.5,{
		name = "foodBox02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Combo",
				tunnel = "police",
				service = "foodBox"
			}
		}
	})

	AddCircleZone("foodBox03",vector3(812.26,-754.98,26.77),0.5,{
		name = "foodBox03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Combo",
				tunnel = "police",
				service = "foodBox"
			}
		}
	})

	AddCircleZone("jewelry01",vector3(-626.67,-238.58,38.05),0.75,{
		name = "jewelry01",
		heading = 3374176
	},{
		shop = "1",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry02",vector3(-625.66,-237.86,38.05),0.75,{
		name = "jewelry02",
		heading = 3374176
	},{
		shop = "2",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry03",vector3(-626.84,-235.35,38.05),0.75,{
		name = "jewelry03",
		heading = 3374176
	},{
		shop = "3",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry04",vector3(-625.83,-234.6,38.05),0.75,{
		name = "jewelry04",
		heading = 3374176
	},{
		shop = "4",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry05",vector3(-626.9,-233.15,38.05),0.75,{
		name = "jewelry05",
		heading = 3374176
	},{
		shop = "5",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry06",vector3(-627.94,-233.92,38.05),0.75,{
		name = "jewelry06",
		heading = 3374176
	},{
		shop = "6",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry07",vector3(-620.22,-234.44,38.05),0.75,{
		name = "jewelry07",
		heading = 3374176
	},{
		shop = "7",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry08",vector3(-619.16,-233.7,38.05),0.75,{
		name = "jewelry08",
		heading = 3374176
	},{
		shop = "8",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry09",vector3(-617.56,-230.57,38.05),0.75,{
		name = "jewelry09",
		heading = 3374176
	},{
		shop = "9",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry10",vector3(-618.29,-229.49,38.05),0.75,{
		name = "jewelry10",
		heading = 3374176
	},{
		shop = "10",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry11",vector3(-619.68,-227.63,38.05),0.75,{
		name = "jewelry11",
		heading = 3374176
	},{
		shop = "11",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry12",vector3(-620.43,-226.56,38.05),0.75,{
		name = "jewelry12",
		heading = 3374176
	},{
		shop = "12",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry13",vector3(-623.92,-227.06,38.05),0.75,{
		name = "jewelry13",
		heading = 3374176
	},{
		shop = "13",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry14",vector3(-624.97,-227.84,38.05),0.75,{
		name = "jewelry14",
		heading = 3374176
	},{
		shop = "14",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry15",vector3(-624.42,-231.08,38.05),0.75,{
		name = "jewelry15",
		heading = 3374176
	},{
		shop = "15",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry16",vector3(-623.98,-228.18,38.05),0.75,{
		name = "jewelry16",
		heading = 3374176
	},{
		shop = "16",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry17",vector3(-621.08,-228.58,38.05),0.75,{
		name = "jewelry17",
		heading = 3374176
	},{
		shop = "17",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry18",vector3(-619.72,-230.43,38.05),0.75,{
		name = "jewelry18",
		heading = 3374176
	},{
		shop = "18",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry19",vector3(-620.14,-233.31,38.05),0.75,{
		name = "jewelry19",
		heading = 3374176
	},{
		shop = "19",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry20",vector3(-623.05,-232.95,38.05),0.75,{
		name = "jewelry20",
		heading = 3374176
	},{
		shop = "20",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelryHacker",vector3(-631.38,-230.24,38.05),0.75,{
		name = "jewelryHacker",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "robberys:initJewelry",
				label = "Hackear",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("divingStore",vector3(1521.08,3780.19,34.46),0.5,{
		name = "divingStore",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "shops:divingSuit",
				label = "Comprar Traje",
				tunnel = "server"
			},{
				event = "hud:rechargeOxigen",
				label = "Reabastecer Oxigênio",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles01",vector3(-38.9,-1100.22,27.26),0.75,{
		name = "tabletVehicles01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles02",vector3(-40.37,-1094.57,27.26),0.75,{
		name = "tabletVehicles02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles03",vector3(-46.87,-1095.5,27.26),0.75,{
		name = "tabletVehicles03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles04",vector3(-51.59,-1094.98,27.26),0.75,{
		name = "tabletVehicles04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles05",vector3(-51.15,-1087.13,27.26),0.75,{
		name = "tabletVehicles05",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("tabletVehicles06",vector3(1230.03,2733.74,38.03),0.75,{
		name = "tabletVehicles06",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "tablet:enterTablet",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("cemiteryMan",vector3(-1745.57,-205.19,57.37),0.75,{
		name = "cemiteryMan",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local policeMenu = {
	{
		event = "police:runInspect",
		label = "Revistar",
		tunnel = "police"
	},{
		event = "police:prisonClothes",
		label = "Uniforme Presidiário",
		tunnel = "police"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDICMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local paramedicMenu = {
	{
		event = "paramedic:Revive",
		label = "Reanimar",
		tunnel = "paramedic"
	},{
		event = "paramedic:Diagnostic",
		label = "Diagnóstico",
		tunnel = "paramedic"
	},{
		event = "paramedic:Treatment",
		label = "Tratamento",
		tunnel = "paramedic"
	},{
		event = "paramedic:Repose",
		label = "Colocar de Repouso",
		tunnel = "paramedic"
	},{
		event = "paramedic:Bleeding",
		label = "Sangramento",
		tunnel = "paramedic"
	},{
		event = "paramedic:Bed",
		label = "Deitar Paciente",
		tunnel = "paramedic"
	},{
		event = "paramedic:presetBurn",
		label = "Roupa de Queimadura",
		tunnel = "paramedic"
	},{
		event = "paramedic:presetPlaster",
		label = "Roupa de Gesso",
		tunnel = "paramedic"
	},{
		event = "paramedic:extractBlood",
		label = "Extrair Sangue",
		tunnel = "paramedic"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local policeVeh = {
	{
		event = "inventory:applyPlate",
		label = "Trocar Placa",
		tunnel = "police"
	},{
		event = "trunkchest:openTrunk",
		label = "Abrir Porta-Malas",
		tunnel = "server"
	},{
		event = "police:runPlate",
		label = "Verificar Placa",
		tunnel = "police"
	},{
		event = "police:impound",
		label = "Registrar Veículo",
		tunnel = "police"
	},{
		event = "garages:vehicleKey",
		label = "Criar Chave Cópia",
		tunnel = "police"
	},{
		event = "police:runArrest",
		label = "Apreender Veículo",
		tunnel = "police"
	},{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	},{
		event = "inventory:removeTyres",
		label = "Retirar Pneu",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local playerVeh = {
	{
		event = "trunkchest:openTrunk",
		label = "Abrir Porta-Malas",
		tunnel = "server"
	},{
		event = "inventory:applyPlate",
		label = "Trocar Placa",
		tunnel = "police"
	},{
		event = "garages:vehicleKey",
		label = "Criar Chave Cópia",
		tunnel = "police"
	},{
		event = "inventory:stealTrunk",
		label = "Arrombar Porta-Malas",
		tunnel = "client"
	},{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	},{
		event = "inventory:removeTyres",
		label = "Retirar Pneu",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOCKADEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local stockadeVeh = {
	{
		event = "inventory:checkStockade",
		label = "Vasculhar",
		tunnel = "police"
	},{
		event = "inventory:applyPlate",
		label = "Trocar Placa",
		tunnel = "police"
	},{
		event = "garages:vehicleKey",
		label = "Criar Chave Cópia",
		tunnel = "police"
	},{
		event = "inventory:stealTrunk",
		label = "Arrombar Porta-Malas",
		tunnel = "client"
	},{
		event = "player:enterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "client"
	},{
		event = "inventory:removeTyres",
		label = "Retirar Pneu",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local locateVeh = {
	["Desmanche"] = {
		{
			event = "inventory:Desmanchar",
			label = "Desmanchar",
			tunnel = "police"
		}
	},
	["Reboque"] = {
		{
			event = "towdriver:Tow",
			label = "Rebocar",
			tunnel = "client"
		},{
			event = "impound:Check",
			label = "Impound",
			tunnel = "police"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetEnable()
	if LocalPlayer["state"]["Active"] then
		local ped = PlayerPedId()

		if LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or sucessTarget or IsPedArmed(ped,6) or IsPedInAnyVehicle(ped) or not MumbleIsConnected() then
			return
		end

		SendNUIMessage({ response = "openTarget" })

		targetActive = true
		while targetActive do
			local coords = GetEntityCoords(ped)
			local hit,entCoords,entity = RayCastGamePlayCamera(10.0)

			if hit == 1 then
				if GetEntityType(entity) ~= 0 then
					if IsEntityAVehicle(entity) then
						local vehPlate = GetVehicleNumberPlateText(entity)
						if #(coords - entCoords) <= 1.0 and vehPlate ~= "PDMSPORT" then
							local vehNet = nil
							local vehModel = GetEntityModel(entity)
							SetEntityAsMissionEntity(entity,true,true)

							if NetworkGetEntityIsNetworked(entity) then
								vehNet = VehToNet(entity)
							end

							innerEntity = { vehPlate,vRP.vehicleModel(vehModel),entity,vehNet }

							if LocalPlayer["state"]["Police"] then
								SendNUIMessage({ response = "validTarget", data = policeVeh })
							else
								local locateMenu = false
								for k,v in pairs(locateLocs) do
									local distance = #(coords - vector3(v[1],v[2],v[3]))
									if distance <= 10 then
										locateMenu = v[4]
									end
								end

								if locateMenu then
									SendNUIMessage({ response = "validTarget", data = locateVeh[locateMenu] })
								else
									SendNUIMessage({ response = "validTarget", data = playerVeh })
								end
							end

							sucessTarget = true
							while sucessTarget and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera(10.0)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									sucessTarget = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) and (LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"]) then
						if #(coords - entCoords) <= 1.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)

							innerEntity = { source }

							if LocalPlayer["state"]["Police"] then
								SendNUIMessage({ response = "validTarget", data = policeMenu })
							elseif LocalPlayer["state"]["Paramedic"] then
								SendNUIMessage({ response = "validTarget", data = paramedicMenu })
							end

							sucessTarget = true
							while sucessTarget and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera(10.0)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
									sucessTarget = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					else
						for k,v in pairs(Models) do
							if DoesEntityExist(entity) then
								if k == GetEntityModel(entity) then
									if #(coords - entCoords) <= Models[k]["distance"] then
										local objNet = nil
										if NetworkGetEntityIsNetworked(entity) then
											objNet = ObjToNet(entity)
										end

										innerEntity = { entity,k,objNet,GetEntityCoords(entity) }

										SendNUIMessage({ response = "validTarget", data = Models[k]["options"] })

										sucessTarget = true
										while sucessTarget and targetActive do
											local ped = PlayerPedId()
											local coords = GetEntityCoords(ped)
											local _,entCoords,entity = RayCastGamePlayCamera(10.0)

											DisablePlayerFiring(ped,true)

											if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
												SetCursorLocation(0.5,0.5)
												SetNuiFocus(true,true)
											end

											if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
												sucessTarget = false
											end

											Citizen.Wait(1)
										end

										SendNUIMessage({ response = "leftTarget" })
									end
								end
							end
						end
					end
				end

				for k,v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then
							SendNUIMessage({ response = "validTarget", data = Zones[k]["targetoptions"]["options"] })

							if v["targetoptions"]["shop"] ~= nil then
								innerEntity = { v["targetoptions"]["shop"] }
							end

							sucessTarget = true
							while sucessTarget and targetActive do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords = RayCastGamePlayCamera(10.0)

								DisablePlayerFiring(ped,true)

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
									sucessTarget = false
								end

								Citizen.Wait(1)
							end

							SendNUIMessage({ response = "leftTarget" })
						end
					end
				end
			end

			Citizen.Wait(250)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	[1631638868] = { 0.0,0.0 },
	[2117668672] = { 0.0,0.0 },
	[-1498379115] = { 1.0,90.0 },
	[-1519439119] = { 1.0,0.0 },
	[-289946279] = { 1.0,0.0 }
}

RegisterNetEvent("target:animDeitar")
AddEventHandler("target:animDeitar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(innerEntity[1])

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[innerEntity[2]][1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) + beds[innerEntity[2]][2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PACIENTEDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:pacienteDeitar")
AddEventHandler("target:pacienteDeitar",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,k,0,0,0)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(object) + v[2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-853526657] = -0.1,
	[652816835] = 0.8
}

RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(innerEntity[1])

			FreezeEntityPosition(innerEntity[1],true)
			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[innerEntity[2]],1,0,0,0)
			if chairs[innerEntity[2]] == 0.7 then
				SetEntityHeading(ped,GetEntityHeading(innerEntity[1]))
			else
				SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) - 180.0)
			end

			vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if sucessTarget or not targetActive then
		return
	end

	targetActive = false
	SendNUIMessage({ response = "closeTarget" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("selectTarget",function(data)
	sucessTarget = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "boxes" then
		TriggerServerEvent(data["event"],innerEntity[1],data["service"])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],innerEntity,data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],innerEntity[3])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function()
	sucessTarget = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	sucessTarget = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATIONTODIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function RotationToDirection(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation["x"],
		y = (math.pi / 180) * rotation["y"],
		z = (math.pi / 180) * rotation["z"]
	}

	local direction = {
		x = -math.sin(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		y = math.cos(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		z = math.sin(adjustedRotation["x"])
	}

	return direction
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera(distance)
	local cameraCoord = GetGameplayCamCoord()
	local cameraRotation = GetGameplayCamRot()
	local direction = RotationToDirection(cameraRotation)

	local destination = {
		x = cameraCoord["x"] + direction["x"] * distance,
		y = cameraCoord["y"] + direction["y"] * distance,
		z = cameraCoord["z"] + direction["z"] * distance
	}

	local a,b,c,d,e = GetShapeTestResult(StartShapeTestRay(cameraCoord["x"],cameraCoord["y"],cameraCoord["z"],destination["x"],destination["y"],destination["z"],-1,PlayerPedId(),0))

	return b,c,e
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(name,center,radius,options,targetoptions)
	Zones[name] = CircleZone:Create(center,radius,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(name)
	if Zones[name] then
		Zones[name] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPOLYZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddPolyzone(name,points,options,targetoptions)
	Zones[name] = PolyZone:Create(points,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(models,parameteres)
	for k,v in pairs(models) do
		Models[v] = parameteres
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Title)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Title
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddPolyzone",AddPolyzone)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)