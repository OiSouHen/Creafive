-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["badge01"] = {
		["index"] = "badge01",
		["name"] = "Distintivo",
		["desc"] = "Divisão: <green>Speed Enforcement</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge02"] = {
		["index"] = "badge02",
		["name"] = "Distintivo",
		["desc"] = "Divisão: <green>Internal Affairs</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge03"] = {
		["index"] = "badge03",
		["name"] = "Distintivo",
		["desc"] = "<green>Special Weapons and Tactics</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge04"] = {
		["index"] = "badge04",
		["name"] = "Distintivo",
		["desc"] = "<green>Emergency Medical Services</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge05"] = {
		["index"] = "badge05",
		["name"] = "Distintivo",
		["desc"] = "<green>Department of Corrections</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge06"] = {
		["index"] = "badge06",
		["name"] = "Distintivo",
		["desc"] = "<green>Field Training Operations</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge07"] = {
		["index"] = "badge07",
		["name"] = "Distintivo",
		["desc"] = "<green>Los Santos Police Department</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge08"] = {
		["index"] = "badge08",
		["name"] = "Distintivo",
		["desc"] = "<green>Patrol Operations</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge09"] = {
		["index"] = "badge09",
		["name"] = "Distintivo",
		["desc"] = "<green>Detectives Bureau</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["badge10"] = {
		["index"] = "badge10",
		["name"] = "Distintivo",
		["desc"] = "<green>Honorary Council</green>",
		["type"] = "Usável",
		["weight"] = 0.0
	},
	["mushroomtea"] = {
		["index"] = "mushroomtea",
		["name"] = "Chá de Cogumelo",
		["desc"] = "Tempo pedalando reduzido para <green>10 minutos</green> por <green>60 minutos</green>, lembrando que o efeito passa desconectando da cidade.",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["miner"] = {
		["index"] = "miner",
		["name"] = "Mineradora",
		["type"] = "Usável",
		["weight"] = 25.0
	},
	["cryptocoins"] = {
		["index"] = "cryptocoins",
		["name"] = "Criptomoeda",
		["desc"] = "Cotação atual da moeda: <green>$0,23148</green>",
		["type"] = "Comum",
		["weight"] = 0.0
	},
	["seaweed"] = {
		["index"] = "seaweed",
		["name"] = "Alga Marinha",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["nigirizushi"] = {
		["index"] = "nigirizushi",
		["name"] = "Nigirizushi",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["sushi"] = {
		["index"] = "sushi",
		["name"] = "Sushi",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["cupcake"] = {
		["index"] = "cupcake",
		["name"] = "Cupcake",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["milkshake"] = {
		["index"] = "milkshake",
		["name"] = "Milk Shake",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3
	},
	["cappuccino"] = {
		["index"] = "cappuccino",
		["name"] = "Cappuccino",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3
	},
	["applelove"] = {
		["index"] = "applelove",
		["name"] = "Maça do Amor",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 2
	},
	["credential"] = {
		["index"] = "credential",
		["name"] = "Credencial",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["bucket"] = {
		["index"] = "bucket",
		["name"] = "Balde",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["scanner"] = {
		["index"] = "scanner",
		["name"] = "Scanner",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 5.00
	},
	["nitro"] = {
		["index"] = "nitro",
		["name"] = "Nitro",
		["type"] = "Usável",
		["weight"] = 10.00
	},
	["postit"] = {
		["index"] = "postit",
		["name"] = "Post-It",
		["type"] = "Usável",
		["weight"] = 0.05
	},
	["attachsFlashlight"] = {
		["index"] = "attachsFlashlight",
		["name"] = "Lanterna Tatica",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["attachsCrosshair"] = {
		["index"] = "attachsCrosshair",
		["name"] = "Mira Holográfica",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["attachsSilencer"] = {
		["index"] = "attachsSilencer",
		["name"] = "Silenciador",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["attachsGrip"] = {
		["index"] = "attachsGrip",
		["name"] = "Empunhadura",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["cheese"] = {
		["index"] = "cheese",
		["name"] = "Queijo",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["wheat"] = {
		["index"] = "wheat",
		["name"] = "Trigo",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["silk"] = {
		["index"] = "silk",
		["name"] = "Seda",
		["type"] = "Comum",
		["weight"] = 0.18
	},
	["coketable"] = {
		["index"] = "coketable",
		["name"] = "Mesa de Criação",
		["desc"] = "Utilizada para criação de Cocaína.",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 15.00
	},
	["methtable"] = {
		["index"] = "methtable",
		["name"] = "Mesa de Criação",
		["desc"] = "Utilizada para criação de Metanfetamina.",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 15.00
	},
	["weedtable"] = {
		["index"] = "weedtable",
		["name"] = "Mesa de Criação",
		["desc"] = "Utilizada para criação de Baseados.",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 15.00
	},
	["campfire"] = {
		["index"] = "campfire",
		["name"] = "Fogueira",
		["type"] = "Usável",
		["weight"] = 10.00
	},
	["barrier"] = {
		["index"] = "barrier",
		["name"] = "Barreira",
		["type"] = "Usável",
		["weight"] = 4.25
	},
	["medicbag"] = {
		["index"] = "medicbag",
		["name"] = "Bolsa Médica",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 2.25
	},
	["chair01"] = {
		["index"] = "chair01",
		["name"] = "Cadeira",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 7.25
	},
	["techtrash"] = {
		["index"] = "techtrash",
		["name"] = "Lixo Eletrônico",
		["type"] = "Comum",
		["weight"] = 0.65
	},
	["tarp"] = {
		["index"] = "tarp",
		["name"] = "Lona",
		["type"] = "Comum",
		["weight"] = 0.45
	},
	["sheetmetal"] = {
		["index"] = "sheetmetal",
		["name"] = "Chapa de Metal",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["roadsigns"] = {
		["index"] = "roadsigns",
		["name"] = "Placas de Trânsito",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["leather"] = {
		["index"] = "leather",
		["name"] = "Couro",
		["type"] = "Comum",
		["weight"] = 0.05
	},
	["explosives"] = {
		["index"] = "explosives",
		["name"] = "Explosivos",
		["type"] = "Comum",
		["weight"] = 0.15
	},
	["animalfat"] = {
		["index"] = "animalfat",
		["name"] = "Gordura Animal",
		["type"] = "Comum",
		["weight"] = 0.02
	},
	["fidentity"] = {
		["index"] = "identity",
		["name"] = "Passaporte",
		["type"] = "Usável",
		["weight"] = 0.10
	},
	["identity"] = {
		["index"] = "identity",
		["name"] = "Passaporte",
		["type"] = "Usável",
		["weight"] = 0.10
	},
	["blocksignal"] = {
		["index"] = "blocksignal",
		["name"] = "Bloqueador de Sinal",
		["type"] = "Usável",
		["weight"] = 0.55
	},
	["pistolbody"] = {
		["index"] = "pistolbody",
		["name"] = "Corpo de Pistola",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["smgbody"] = {
		["index"] = "smgbody",
		["name"] = "Corpo de Sub-Metralhadora",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["riflebody"] = {
		["index"] = "riflebody",
		["name"] = "Corpo de Rifle",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["cotton"] = {
		["index"] = "cotton",
		["name"] = "Algodão",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["plaster"] = {
		["index"] = "plaster",
		["name"] = "Esparadrapo",
		["type"] = "Comum",
		["weight"] = 0.35
	},
	["sulfuric"] = {
		["index"] = "sulfuric",
		["name"] = "Ácido Sulfúrico",
		["type"] = "Usável",
		["weight"] = 0.45
	},
	["saline"] = {
		["index"] = "saline",
		["name"] = "Soro Fisiológico",
		["type"] = "Comum",
		["weight"] = 0.45
	},
	["defibrillator"] = {
		["index"] = "defibrillator",
		["name"] = "Desfibrilador",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 3.25
	},
	["alcohol"] = {
		["index"] = "alcohol",
		["name"] = "Álcool",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["notebook"] = {
		["index"] = "notebook",
		["name"] = "Notebook",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 7.25
	},
	["syringe"] = {
		["index"] = "adrenaline",
		["name"] = "Seringa",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["syringe01"] = {
		["index"] = "syringe",
		["name"] = "Seringa A+",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["syringe02"] = {
		["index"] = "syringe",
		["name"] = "Seringa B+",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["syringe03"] = {
		["index"] = "syringe",
		["name"] = "Seringa A-",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["syringe04"] = {
		["index"] = "syringe",
		["name"] = "Seringa B-",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["foodburger"] = {
		["index"] = "foodburger",
		["name"] = "Caixa de Hamburger",
		["type"] = "Comum",
		["weight"] = 0.15,
		["max"] = 1
	},
	["foodjuice"] = {
		["index"] = "foodjuice",
		["name"] = "Copo de Suco",
		["type"] = "Comum",
		["weight"] = 0.15,
		["max"] = 1
	},
	["foodbox"] = {
		["index"] = "foodbox",
		["name"] = "Combo",
		["type"] = "Comum",
		["weight"] = 1.00,
		["max"] = 2
	},
	["wheelchair"] = {
		["index"] = "wheelchair",
		["name"] = "Cadeira de Rodas",
		["type"] = "Usável",
		["weight"] = 7.50
	},
	["vehkey"] = {
		["index"] = "vehkey",
		["name"] = "Chave Cópia",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["evidence01"] = {
		["index"] = "evidence01",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05
	},
	["evidence02"] = {
		["index"] = "evidence02",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05
	},
	["evidence03"] = {
		["index"] = "evidence03",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05
	},
	["evidence04"] = {
		["index"] = "evidence04",
		["name"] = "Evidência",
		["type"] = "Usável",
		["weight"] = 0.05
	},
	["rottweiler"] = {
		["index"] = "rottweiler",
		["name"] = "Coleira de Rottweiler",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["husky"] = {
		["index"] = "husky",
		["name"] = "Coleira de Husky",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["shepherd"] = {
		["index"] = "shepherd",
		["name"] = "Coleira de Shepherd",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["retriever"] = {
		["index"] = "retriever",
		["name"] = "Coleira de Retriever",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["poodle"] = {
		["index"] = "poodle",
		["name"] = "Coleira de Poodle",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["pug"] = {
		["index"] = "pug",
		["name"] = "Coleira de Pug",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["westy"] = {
		["index"] = "westy",
		["name"] = "Coleira de Westy",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["cat"] = {
		["index"] = "cat",
		["name"] = "Coleira de Gato",
		["type"] = "Animal",
		["weight"] = 1.25
	},
	["card01"] = {
		["index"] = "card01",
		["name"] = "Cartão Comum",
		["desc"] = "Roubar Lojas de departamentStoreo.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10
	},
	["card02"] = {
		["index"] = "card02",
		["name"] = "Cartão In-Comum",
		["desc"] = "Roubar Lojas de Armas.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10
	},
	["card03"] = {
		["index"] = "card03",
		["name"] = "Cartão Normal",
		["desc"] = "Roubar Bancos Fleeca.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10
	},
	["card04"] = {
		["index"] = "card04",
		["name"] = "Cartão Raro",
		["desc"] = "Roubar Barbearias.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10
	},
	["card05"] = {
		["index"] = "card05",
		["name"] = "Cartão Lendário",
		["desc"] = "Roubar Bancos.",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.10
	},
	["gemstone"] = {
		["index"] = "gemstone",
		["name"] = "Gemstone",
		["type"] = "Usável",
		["weight"] = 0.10
	},
	["key"] = {
		["index"] = "key",
		["name"] = "Chaves",
		["type"] = "Comum",
		["durability"] = 3,
		["weight"] = 0.25
	},
	["radio"] = {
		["index"] = "radio",
		["name"] = "Rádio",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["vest"] = {
		["index"] = "vest",
		["name"] = "Colete",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 2.25,
		["max"] = 1
	},
	["bandage"] = {
		["index"] = "bandage",
		["name"] = "Bandagem",
		["type"] = "Usável",
		["weight"] = 0.10,
		["max"] = 3
	},
	["medkit"] = {
		["index"] = "medkit",
		["name"] = "Kit Médico",
		["type"] = "Usável",
		["weight"] = 0.45,
		["max"] = 1
	},
	["adrenaline"] = {
		["index"] = "adrenaline",
		["name"] = "Adrenalina",
		["type"] = "Usável",
		["weight"] = 0.35
	},
	["pouch"] = {
		["index"] = "pouch",
		["name"] = "Malote",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["woodlog"] = {
		["index"] = "woodlog",
		["name"] = "Tora de Madeira",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["fishingrod"] = {
		["index"] = "fishingrod",
		["name"] = "Vara de Pescar",
		["type"] = "Usável",
		["durability"] = 7,
		["weight"] = 2.75
	},
	["switchblade"] = {
		["index"] = "switchblade",
		["name"] = "Canivete",
		["type"] = "Usável",
		["desc"] = "Utilizada para remoção de carne.",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["octopus"] = {
		["index"] = "octopus",
		["name"] = "Polvo",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["shrimp"] = {
		["index"] = "shrimp",
		["name"] = "Camarão",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["carp"] = {
		["index"] = "carp",
		["name"] = "Carpa",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["codfish"] = {
		["index"] = "codfish",
		["name"] = "Bacalhau",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["catfish"] = {
		["index"] = "catfish",
		["name"] = "Bagre",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["goldenfish"] = {
		["index"] = "goldenfish",
		["name"] = "Dourado",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["horsefish"] = {
		["index"] = "horsefish",
		["name"] = "Cavala",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["tilapia"] = {
		["index"] = "tilapia",
		["name"] = "Tilápia",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["pacu"] = {
		["index"] = "pacu",
		["name"] = "Pacu",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["pirarucu"] = {
		["index"] = "pirarucu",
		["name"] = "Pirarucu",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["tambaqui"] = {
		["index"] = "tambaqui",
		["name"] = "Tambaqui",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["bait"] = {
		["index"] = "bait",
		["name"] = "Isca",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["animalpelt"] = {
		["index"] = "animalpelt",
		["name"] = "Pele Animal",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["joint"] = {
		["index"] = "joint",
		["name"] = "Baseado",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["weedleaf"] = {
		["index"] = "weedleaf",
		["name"] = "Folha de Maconha",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["fertilizer"] = {
		["index"] = "fertilizer",
		["name"] = "Fertilizante",
		["type"] = "Comum",
		["weight"] = 5.0
	},
	["weedseed"] = {
		["index"] = "weedseed",
		["name"] = "Semente de Maconha",
		["type"] = "Usável",
		["weight"] = 0.10
	},
	["lean"] = {
		["index"] = "lean",
		["name"] = "Lean",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["codeine"] = {
		["index"] = "codeine",
		["name"] = "Codeína",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["ecstasy"] = {
		["index"] = "ecstasy",
		["name"] = "Ecstasy",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["amphetamine"] = {
		["index"] = "amphetamine",
		["name"] = "Anfetamina",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["cocaine"] = {
		["index"] = "cocaine",
		["name"] = "Cocaína",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["cokeseed"] = {
		["index"] = "cokeseed",
		["name"] = "Semente de Cocaína",
		["type"] = "Usável",
		["weight"] = 0.10
	},
	["cokeleaf"] = {
		["index"] = "cokeleaf",
		["name"] = "Folha de Coca",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["mushseed"] = {
		["index"] = "mushseed",
		["name"] = "Semente de Cogumelo",
		["type"] = "Usável",
		["weight"] = 0.10
	},
	["meth"] = {
		["index"] = "meth",
		["name"] = "Metanfetamina",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["acetone"] = {
		["index"] = "acetone",
		["name"] = "Acetona",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["heroine"] = {
		["index"] = "heroine",
		["name"] = "Heroína",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["premium"] = {
		["index"] = "premium",
		["name"] = "Premium",
		["type"] = "Usável",
		["weight"] = 0.00
	},
	["newlocate"] = {
		["index"] = "newlocate",
		["name"] = "Nacionalidade",
		["type"] = "Usável",
		["desc"] = "Inverte nacionalidade de Sul/Norte.",
		["weight"] = 0.00
	},
	["newgarage"] = {
		["index"] = "newgarage",
		["name"] = "+1 Garagem",
		["type"] = "Usável",
		["desc"] = "Limite de garagem em +1.",
		["weight"] = 0.00
	},
	["premiumplate"] = {
		["index"] = "platepremium",
		["name"] = "Placa Premium",
		["type"] = "Usável",
		["desc"] = "Personaliza a placa do veículo.",
		["weight"] = 0.00
	},
	["newchars"] = {
		["index"] = "newchars",
		["name"] = "+1 Personagem",
		["type"] = "Usável",
		["desc"] = "Limite de personagem em +1.",
		["weight"] = 0.00
	},
	["chip"] = {
		["index"] = "chip",
		["name"] = "Chip Telefônico",
		["type"] = "Usável",
		["desc"] = "Troca o número telefônico.",
		["weight"] = 0.00
	},
	["namechange"] = {
		["index"] = "namechange",
		["name"] = "Troca de Nome",
		["type"] = "Usável",
		["desc"] = "Troca o nome do personagem.",
		["weight"] = 0.00
	},
	["contract1"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 1.",
		["weight"] = 0.00
	},
	["contract2"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 2.",
		["weight"] = 0.00
	},
	["contract3"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 3.",
		["weight"] = 0.00
	},
	["contract4"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 4.",
		["weight"] = 0.00
	},
	["contract5"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 5.",
		["weight"] = 0.00
	},
	["contract6"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 6.",
		["weight"] = 0.00
	},
	["contract7"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 7.",
		["weight"] = 0.00
	},
	["contract8"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 8.",
		["weight"] = 0.00
	},
	["contract9"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do interior 9.",
		["weight"] = 0.00
	},
	["contract10"] = {
		["index"] = "contract",
		["name"] = "Contrato de Propriedade",
		["type"] = "Usável",
		["desc"] = "Assinatura de contrato do container.",
		["weight"] = 0.00
	},
	["energetic"] = {
		["index"] = "energetic",
		["name"] = "Energético",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 5
	},
	["milkbottle"] = {
		["index"] = "milkbottle",
		["name"] = "Garrafa de Leite",
		["type"] = "Usável",
		["weight"] = 0.15,
		["scape"] = true,
		["max"] = 5
	},
	["water"] = {
		["index"] = "water",
		["name"] = "Água",
		["type"] = "Usável",
		["weight"] = 0.15,
		["scape"] = true,
		["max"] = 3
	},
	["emptybottle"] = {
		["index"] = "emptybottle",
		["name"] = "Garrafa Vazia",
		["type"] = "Usável",
		["weight"] = 0.10,
		["scape"] = true,
		["max"] = 5
	},
	["coffee"] = {
		["index"] = "coffee",
		["name"] = "Copo de Café",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3
	},
	["cola"] = {
		["index"] = "cola",
		["name"] = "Cola",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3
	},
	["tacos"] = {
		["index"] = "tacos",
		["name"] = "Tacos",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 3
	},
	["fries"] = {
		["index"] = "fries",
		["name"] = "Fritas",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3
	},
	["soda"] = {
		["index"] = "soda",
		["name"] = "Sprunk",
		["type"] = "Usável",
		["weight"] = 0.15,
		["max"] = 3
	},
	["apple"] = {
		["index"] = "apple",
		["name"] = "Maça",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["orange"] = {
		["index"] = "orange",
		["name"] = "Laranja",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["strawberry"] = {
		["index"] = "strawberry",
		["name"] = "Morango",
		["type"] = "Usável",
		["weight"] = 0.15
	},
	["coffee2"] = {
		["index"] = "coffee2",
		["name"] = "Grão de Café",
		["type"] = "Usável",
		["weight"] = 0.10
	},
	["grape"] = {
		["index"] = "grape",
		["name"] = "Uva",
		["type"] = "Usável",
		["weight"] = 0.15
	},
	["tange"] = {
		["index"] = "tange",
		["name"] = "Tangerina",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["banana"] = {
		["index"] = "banana",
		["name"] = "Banana",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["passion"] = {
		["index"] = "passion",
		["name"] = "Maracujá",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["tomato"] = {
		["index"] = "tomato",
		["name"] = "Tomate",
		["type"] = "Usável",
		["weight"] = 0.15
	},
	["mushroom"] = {
		["index"] = "mushroom",
		["name"] = "Cogumelo",
		["type"] = "Usável",
		["weight"] = 0.15
	},
	["sugar"] = {
		["index"] = "sugar",
		["name"] = "Açucar",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["orangejuice"] = {
		["index"] = "orangejuice",
		["name"] = "Suco de Laranja",
		["type"] = "Usável",
		["weight"] = 0.75,
		["scape"] = true,
		["max"] = 3
	},
	["tangejuice"] = {
		["index"] = "tangejuice",
		["name"] = "Suco de Tangerina",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["grapejuice"] = {
		["index"] = "grapejuice",
		["name"] = "Suco de Uva",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["strawberryjuice"] = {
		["index"] = "strawberryjuice",
		["name"] = "Suco de Morango",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["bananajuice"] = {
		["index"] = "bananajuice",
		["name"] = "Suco de Banana",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["passionjuice"] = {
		["index"] = "passionjuice",
		["name"] = "Suco de Maracujá",
		["type"] = "Usável",
		["weight"] = 0.45,
		["scape"] = true,
		["max"] = 3
	},
	["bread"] = {
		["index"] = "bread",
		["name"] = "Pão",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["ketchup"] = {
		["index"] = "ketchup",
		["name"] = "Ketchup",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["cannedsoup"] = {
		["index"] = "cannedsoup",
		["name"] = "Sopa em Lata",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["canofbeans"] = {
		["index"] = "canofbeans",
		["name"] = "Lata de Feijão",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["meat"] = {
		["index"] = "meat",
		["name"] = "Carne Animal",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["fishfillet"] = {
		["index"] = "fishfillet",
		["name"] = "Filé de Peixe",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["marshmallow"] = {
		["index"] = "marshmallow",
		["name"] = "Marshmallow",
		["type"] = "Usável",
		["weight"] = 0.15,
		["scape"] = true,
		["max"] = 3
	},
	["cookedfishfillet"] = {
		["index"] = "cookedfishfillet",
		["name"] = "Filé de Peixe Cozido",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3
	},
	["cookedmeat"] = {
		["index"] = "cookedmeat",
		["name"] = "Carne Animal Cozida",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3
	},
	["hamburger"] = {
		["index"] = "hamburger",
		["name"] = "Hambúrguer",
		["type"] = "Usável",
		["weight"] = 0.35,
		["max"] = 3
	},
	["hamburger2"] = {
		["index"] = "hamburger2",
		["name"] = "Hambúrguer Artesanal",
		["type"] = "Usável",
		["weight"] = 0.55,
		["scape"] = true,
		["max"] = 3
	},
	["pizza"] = {
		["index"] = "pizza",
		["name"] = "Pizza de Muçarela",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3
	},
	["pizza2"] = {
		["index"] = "pizza2",
		["name"] = "Pizza de Cogumelo",
		["type"] = "Usável",
		["weight"] = 0.35,
		["scape"] = true,
		["max"] = 3
	},
	["hotdog"] = {
		["index"] = "hotdog",
		["name"] = "Cachorro-Quente",
		["type"] = "Usável",
		["weight"] = 0.35,
		["max"] = 3
	},
	["donut"] = {
		["index"] = "donut",
		["name"] = "Rosquinha",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 3
	},
	["plate"] = {
		["index"] = "plate",
		["name"] = "Placa",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["lockpick"] = {
		["index"] = "lockpick",
		["name"] = "Lockpick de Alumínio",
		["desc"] = "Utilizada para roubar veículos.",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 1.25
	},
	["lockpick2"] = {
		["index"] = "lockpick2",
		["name"] = "Lockpick de Cobre",
		["desc"] = "Utilizada para roubar propriedades.",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 1.25
	},
	["brokenpick"] = {
		["index"] = "brokenpick",
		["name"] = "Lockpick Quebrado",
		["type"] = "Comum",
		["weight"] = 1.25
	},
	["toolbox"] = {
		["index"] = "toolbox",
		["name"] = "Ferramentas Básicas",
		["type"] = "Usável",
		["weight"] = 1.75,
		["max"] = 2
	},
	["advtoolbox"] = {
		["index"] = "toolbox",
		["name"] = "Ferramentas Avançadas",
		["type"] = "Usável",
		["weight"] = 2.25,
		["charges"] = 3,
		["max"] = 1
	},
	["notepad"] = {
		["index"] = "notepad",
		["name"] = "Bloco de Notas",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["tyres"] = {
		["index"] = "tyres",
		["name"] = "Pneu",
		["type"] = "Usável",
		["weight"] = 1.50,
		["max"] = 4
	},
	["cellphone"] = {
		["index"] = "cellphone",
		["name"] = "Celular",
		["type"] = "Usável",
		["durability"] = 14,
		["weight"] = 0.75
	},
	["divingsuit"] = {
		["index"] = "divingsuit",
		["name"] = "Roupa de Mergulho",
		["type"] = "Usável",
		["durability"] = 14,
		["weight"] = 4.75
	},
	["handcuff"] = {
		["index"] = "handcuff",
		["name"] = "Algemas",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 0.75
	},
	["rope"] = {
		["index"] = "rope",
		["name"] = "Cordas",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 1.50
	},
	["hood"] = {
		["index"] = "hood",
		["name"] = "Capuz",
		["type"] = "Usável",
		["durability"] = 3,
		["weight"] = 1.50
	},
	["nails"] = {
		["index"] = "nails",
		["name"] = "Pregos",
		["type"] = "Comum",
		["weight"] = 0.075
	},
	["plastic"] = {
		["index"] = "plastic",
		["name"] = "Plástico",
		["type"] = "Comum",
		["weight"] = 0.075
	},
	["glass"] = {
		["index"] = "glass",
		["name"] = "Vidro",
		["type"] = "Comum",
		["weight"] = 0.075
	},
	["rubber"] = {
		["index"] = "rubber",
		["name"] = "Borracha",
		["type"] = "Comum",
		["weight"] = 0.050
	},
	["aluminum"] = {
		["index"] = "aluminum",
		["name"] = "Alumínio",
		["type"] = "Comum",
		["weight"] = 0.075
	},
	["copper"] = {
		["index"] = "copper",
		["name"] = "Cobre",
		["type"] = "Comum",
		["weight"] = 0.075
	},
	["newspaper"] = {
		["index"] = "newspaper",
		["name"] = "Jornal",
		["type"] = "Comum",
		["weight"] = 0.375
	},
	["ritmoneury"] = {
		["index"] = "ritmoneury",
		["name"] = "Ritmoneury",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 2
	},
	["sinkalmy"] = {
		["index"] = "sinkalmy",
		["name"] = "Sinkalmy",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 2
	},
	["cigarette"] = {
		["index"] = "cigarette",
		["name"] = "Cigarro",
		["type"] = "Usável",
		["weight"] = 0.05,
		["max"] = 5
	},
	["lighter"] = {
		["index"] = "lighter",
		["name"] = "Isqueiro",
		["durability"] = 7,
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["vape"] = {
		["index"] = "vape",
		["name"] = "Vape",
		["type"] = "Usável",
		["durability"] = 14,
		["weight"] = 0.75
	},
	["dollars"] = {
		["index"] = "dollars",
		["name"] = "Dólares",
		["type"] = "Comum",
		["weight"] = 0.0001
	},
	["battery"] = {
		["index"] = "battery",
		["name"] = "Pilhas",
		["type"] = "Comum",
		["weight"] = 0.20
	},
	["elastic"] = {
		["index"] = "elastic",
		["name"] = "Elástico",
		["type"] = "Comum",
		["weight"] = 0.10
	},
	["plasticbottle"] = {
		["index"] = "plasticbottle",
		["name"] = "Garrafa Plástica",
		["type"] = "Comum",
		["weight"] = 0.20
	},
	["glassbottle"] = {
		["index"] = "glassbottle",
		["name"] = "Garrafa de Vidro",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["metalcan"] = {
		["index"] = "metalcan",
		["name"] = "Lata de Metal",
		["type"] = "Comum",
		["weight"] = 0.20
	},
	["chocolate"] = {
		["index"] = "chocolate",
		["name"] = "Chocolate",
		["type"] = "Usável",
		["weight"] = 0.10,
		["scape"] = true,
		["max"] = 3
	},
	["sandwich"] = {
		["index"] = "sandwich",
		["name"] = "Sanduiche",
		["type"] = "Usável",
		["weight"] = 0.25,
		["max"] = 3
	},
	["rose"] = {
		["index"] = "rose",
		["name"] = "Rosa",
		["type"] = "Usável",
		["weight"] = 0.15
	},
	["teddy"] = {
		["index"] = "teddy",
		["name"] = "Teddy",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["absolut"] = {
		["index"] = "absolut",
		["name"] = "Absolut",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["chandon"] = {
		["index"] = "chandon",
		["name"] = "Chandon",
		["type"] = "Usável",
		["weight"] = 0.35
	},
	["dewars"] = {
		["index"] = "dewars",
		["name"] = "Dewars",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["hennessy"] = {
		["index"] = "hennessy",
		["name"] = "Hennessy",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["goldbar"] = {
		["index"] = "goldbar",
		["name"] = "Barra de Ouro",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["binoculars"] = {
		["index"] = "binoculars",
		["name"] = "Binóculos",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["camera"] = {
		["index"] = "camera",
		["name"] = "Câmera",
		["type"] = "Usável",
		["weight"] = 2.25
	},
	["WEAPON_HATCHET"] = {
		["index"] = "hatchet",
		["name"] = "Machado",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_BAT"] = {
		["index"] = "bat",
		["name"] = "Bastão de Beisebol",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_KATANA"] = {
		["index"] = "katana",
		["name"] = "Katana",
		["type"] = "Armamento",
		["repair"] = "repairkit01",
		["durability"] = 3,
		["weight"] = 0.75,
		["economy"] = 1225
	},
	["WEAPON_KARAMBIT"] = {
		["index"] = "karambit",
		["name"] = "Karambit",
		["type"] = "Armamento",
		["repair"] = "repairkit01",
		["durability"] = 3,
		["weight"] = 0.75,
		["economy"] = 1025
	},
	["WEAPON_BATTLEAXE"] = {
		["index"] = "battleaxe",
		["name"] = "Machado de Batalha",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_CROWBAR"] = {
		["index"] = "crowbar",
		["name"] = "Pé de Cabra",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_GOLFCLUB"] = {
		["index"] = "golfclub",
		["name"] = "Taco de Golf",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_HAMMER"] = {
		["index"] = "hammer",
		["name"] = "Martelo",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_MACHETE"] = {
		["index"] = "machete",
		["name"] = "Facão",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_POOLCUE"] = {
		["index"] = "poolcue",
		["name"] = "Taco de Sinuca",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_STONE_HATCHET"] = {
		["index"] = "stonehatchet",
		["name"] = "Machado de Pedra",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_WRENCH"] = {
		["index"] = "wrench",
		["name"] = "Chave Inglesa",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_KNUCKLE"] = {
		["index"] = "knuckle",
		["name"] = "Soco Inglês",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_FLASHLIGHT"] = {
		["index"] = "flashlight",
		["name"] = "Lanterna",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_NIGHTSTICK"] = {
		["index"] = "nightstick",
		["name"] = "Cassetete",
		["type"] = "Armamento",
		["durability"] = 7,
		["weight"] = 0.75
	},
	["WEAPON_PISTOL"] = {
		["index"] = "m1911",
		["name"] = "M1911",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25
	},
	["WEAPON_PISTOL_MK2"] = {
		["index"] = "fiveseven",
		["name"] = "FN Five Seven",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50
	},
	["WEAPON_COMPACTRIFLE"] = {
		["index"] = "akcompact",
		["name"] = "AK Compact",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 14,
		["weight"] = 2.25
	},
	["WEAPON_APPISTOL"] = {
		["index"] = "kochvp9",
		["name"] = "Koch Vp9",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25
	},
	["WEAPON_HEAVYPISTOL"] = {
		["index"] = "atifx45",
		["name"] = "Ati FX45",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50
	},
	["WEAPON_MACHINEPISTOL"] = {
		["index"] = "tec9",
		["name"] = "Tec-9",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.75
	},
	["WEAPON_MICROSMG"] = {
		["index"] = "uzi",
		["name"] = "Uzi",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25
	},
	["WEAPON_MINISMG"] = {
		["index"] = "skorpionv61",
		["name"] = "Skorpion V61",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.75
	},
	["WEAPON_SNSPISTOL"] = {
		["index"] = "amt380",
		["name"] = "AMT 380",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.00
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		["index"] = "hkp7m10",
		["name"] = "HK P7M10",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25
	},
	["WEAPON_VINTAGEPISTOL"] = {
		["index"] = "m1922",
		["name"] = "M1922",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25
	},
	["WEAPON_PISTOL50"] = {
		["index"] = "desert",
		["name"] = "Desert Eagle",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50
	},
	["WEAPON_REVOLVER"] = {
		["index"] = "magnum",
		["name"] = "Magnum 44",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.50
	},
	["WEAPON_COMBATPISTOL"] = {
		["index"] = "glock",
		["name"] = "Glock",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PISTOL_AMMO",
		["durability"] = 14,
		["vehicle"] = true,
		["weight"] = 1.25
	},
	["WEAPON_CARBINERIFLE"] = {
		["index"] = "m4a1",
		["name"] = "M4A1",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		["index"] = "m4a4",
		["name"] = "M4A4",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 8.50
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		["index"] = "tar21",
		["name"] = "Tar-21",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75
	},
	["WEAPON_BULLPUPRIFLE"] = {
		["index"] = "qbz95",
		["name"] = "QBZ-95",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		["index"] = "l85",
		["name"] = "L85",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75
	},
	["WEAPON_SPECIALCARBINE"] = {
		["index"] = "g36c",
		["name"] = "G36C",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 8.25
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		["index"] = "sigsauer556",
		["name"] = "Sig Sauer 556",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 8.25
	},
	["WEAPON_PUMPSHOTGUN"] = {
		["index"] = "mossberg590",
		["name"] = "Mossberg 590",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SHOTGUN_AMMO",
		["durability"] = 21,
		["weight"] = 7.25
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		["index"] = "mossberg590a1",
		["name"] = "Mossberg 590A1",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SHOTGUN_AMMO",
		["durability"] = 21,
		["weight"] = 7.25
	},
	["WEAPON_MUSKET"] = {
		["index"] = "winchester",
		["name"] = "Winchester 1892",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_MUSKET_AMMO",
		["durability"] = 21,
		["weight"] = 6.25
	},
	["WEAPON_SNIPERRIFLE"] = {
		["index"] = "sauer101",
		["name"] = "Sauer 101",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_MUSKET_AMMO",
		["durability"] = 21,
		["weight"] = 8.25
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		["index"] = "mossberg500",
		["name"] = "Mossberg 500",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SHOTGUN_AMMO",
		["durability"] = 21,
		["weight"] = 5.75
	},
	["WEAPON_SMG"] = {
		["index"] = "mp5",
		["name"] = "MP5",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 21,
		["weight"] = 5.25
	},
	["WEAPON_SMG_MK2"] = {
		["index"] = "evo3",
		["name"] = "Evo-3",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 21,
		["weight"] = 5.25
	},
	["WEAPON_ASSAULTRIFLE"] = {
		["index"] = "ak103",
		["name"] = "AK-103",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		["index"] = "ak74",
		["name"] = "AK-74",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_RIFLE_AMMO",
		["durability"] = 21,
		["weight"] = 7.75
	},
	["WEAPON_ASSAULTSMG"] = {
		["index"] = "steyraug",
		["name"] = "Steyr AUG",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 21,
		["weight"] = 5.75
	},
	["WEAPON_GUSENBERG"] = {
		["index"] = "thompson",
		["name"] = "Thompson",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_SMG_AMMO",
		["durability"] = 21,
		["weight"] = 6.25
	},
	["WEAPON_PETROLCAN"] = {
		["index"] = "gallon",
		["name"] = "Galão",
		["type"] = "Armamento",
		["ammo"] = "WEAPON_PETROLCAN_AMMO",
		["weight"] = 1.25
	},
	["WEAPON_BRICK"] = {
		["index"] = "brick",
		["name"] = "Tijolo",
		["type"] = "Throwing",
		["vehicle"] = true,
		["weight"] = 0.50,
		["economy"] = 20
	},
	["WEAPON_SNOWBALL"] = {
		["index"] = "snowball",
		["name"] = "Bola de Neve",
		["type"] = "Throwing",
		["vehicle"] = true,
		["weight"] = 0.25,
		["economy"] = 6
	},
	["WEAPON_SHOES"] = {
		["index"] = "shoes",
		["name"] = "Tênis",
		["type"] = "Throwing",
		["vehicle"] = true,
		["weight"] = 0.50,
		["economy"] = 20
	},
	["WEAPON_MOLOTOV"] = {
		["index"] = "molotov",
		["name"] = "Coquetel Molotov",
		["type"] = "Throwing",
		["vehicle"] = true,
		["weight"] = 0.50,
		["economy"] = 225,
		["max"] = 3
	},
	["WEAPON_SMOKEGRENADE"] = {
		["index"] = "smokegrenade",
		["name"] = "Granada de Fumaça",
		["type"] = "Throwing",
		["vehicle"] = true,
		["weight"] = 0.50,
		["economy"] = 225,
		["max"] = 3
	},
	["GADGET_PARACHUTE"] = {
		["index"] = "parachute",
		["name"] = "Paraquedas",
		["type"] = "Usável",
		["weight"] = 2.25
	},
	["WEAPON_STUNGUN"] = {
		["index"] = "stungun",
		["name"] = "Tazer",
		["type"] = "Armamento",
		["durability"] = 21,
		["weight"] = 0.75
	},
	["WEAPON_PISTOL_AMMO"] = {
		["index"] = "pistolammo",
		["name"] = "Munição de Pistola",
		["type"] = "Munição",
		["weight"] = 0.02
	},
	["WEAPON_SMG_AMMO"] = {
		["index"] = "smgammo",
		["name"] = "Munição de Sub",
		["type"] = "Munição",
		["weight"] = 0.03
	},
	["WEAPON_RIFLE_AMMO"] = {
		["index"] = "rifleammo",
		["name"] = "Munição de Rifle",
		["type"] = "Munição",
		["weight"] = 0.04
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		["index"] = "shotgunammo",
		["name"] = "Munição de Escopeta",
		["type"] = "Munição",
		["weight"] = 0.05
	},
	["WEAPON_MUSKET_AMMO"] = {
		["index"] = "musketammo",
		["name"] = "Munição de Mosquete",
		["type"] = "Munição",
		["weight"] = 0.05
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		["index"] = "fuel",
		["name"] = "Combustível",
		["type"] = "Munição",
		["weight"] = 0.001
	},
	["pager"] = {
		["index"] = "pager",
		["name"] = "Pager",
		["type"] = "Usável",
		["weight"] = 1.25
	},
	["firecracker"] = {
		["index"] = "firecracker",
		["name"] = "Fogos de Artificio",
		["type"] = "Usável",
		["weight"] = 2.25
	},
	["analgesic"] = {
		["index"] = "analgesic",
		["name"] = "Analgésico",
		["type"] = "Usável",
		["weight"] = 0.10,
		["max"] = 4
	},
	["oxy"] = {
		["index"] = "analgesic",
		["name"] = "Oxy",
		["type"] = "Usável",
		["weight"] = 0.10,
		["max"] = 4
	},
	["gauze"] = {
		["index"] = "gauze",
		["name"] = "Gaze",
		["type"] = "Usável",
		["weight"] = 0.07,
		["max"] = 4
	},
	["gsrkit"] = {
		["index"] = "gsrkit",
		["name"] = "Kit Residual",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["gdtkit"] = {
		["index"] = "gdtkit",
		["name"] = "Kit Químico",
		["type"] = "Usável",
		["weight"] = 0.75
	},
	["emerald"] = {
		["index"] = "emerald",
		["name"] = "Esmeralda",
		["type"] = "Comum",
		["weight"] = 0.85
	},
	["diamond"] = {
		["index"] = "diamond",
		["name"] = "Diamante",
		["type"] = "Comum",
		["weight"] = 0.80
	},
	["ruby"] = {
		["index"] = "ruby",
		["name"] = "Rubi",
		["type"] = "Comum",
		["weight"] = 0.75
	},
	["sapphire"] = {
		["index"] = "sapphire",
		["name"] = "Safira",
		["type"] = "Comum",
		["weight"] = 0.70
	},
	["amethyst"] = {
		["index"] = "amethyst",
		["name"] = "Ametista",
		["type"] = "Comum",
		["weight"] = 0.65
	},
	["amber"] = {
		["index"] = "amber",
		["name"] = "Âmbar",
		["type"] = "Comum",
		["weight"] = 0.60
	},
	["turquoise"] = {
		["index"] = "turquoise",
		["name"] = "Turquesa",
		["type"] = "Comum",
		["weight"] = 0.55
	},
	["keyboard"] = {
		["index"] = "keyboard",
		["name"] = "Teclado",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["mouse"] = {
		["index"] = "mouse",
		["name"] = "Mouse",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["silverring"] = {
		["index"] = "silverring",
		["name"] = "Anel de Prata",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["goldring"] = {
		["index"] = "goldring",
		["name"] = "Anel de Ouro",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["silvercoin"] = {
		["index"] = "silvercoin",
		["name"] = "Moeda de Prata",
		["type"] = "Comum",
		["weight"] = 0.01
	},
	["goldcoin"] = {
		["index"] = "goldcoin",
		["name"] = "Moeda de Ouro",
		["type"] = "Comum",
		["weight"] = 0.01
	},
	["watch"] = {
		["index"] = "watch",
		["name"] = "Relógio",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["playstation"] = {
		["index"] = "playstation",
		["name"] = "Playstation",
		["type"] = "Comum",
		["weight"] = 2.00
	},
	["xbox"] = {
		["index"] = "xbox",
		["name"] = "Xbox",
		["type"] = "Comum",
		["weight"] = 1.75
	},
	["legos"] = {
		["index"] = "legos",
		["name"] = "Legos",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["ominitrix"] = {
		["index"] = "ominitrix",
		["name"] = "Ominitrix",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["bracelet"] = {
		["index"] = "bracelet",
		["name"] = "Bracelete",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["dildo"] = {
		["index"] = "dildo",
		["name"] = "Vibrador",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["spray01"] = {
		["index"] = "spray01",
		["name"] = "Desodorante 24hrs",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["spray02"] = {
		["index"] = "spray02",
		["name"] = "Antisséptico",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["spray03"] = {
		["index"] = "spray03",
		["name"] = "Desodorante 48hrs",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["spray04"] = {
		["index"] = "spray04",
		["name"] = "Desodorante 72hrs",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["brick"] = {
		["index"] = "brick",
		["name"] = "Tijolo",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["dices"] = {
		["index"] = "dices",
		["name"] = "Dados",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["dish"] = {
		["index"] = "dish",
		["name"] = "Prato",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["pan"] = {
		["index"] = "pan",
		["name"] = "Panela",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["sneakers"] = {
		["index"] = "sneakers",
		["name"] = "Tenis",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["fan"] = {
		["index"] = "fan",
		["name"] = "Ventilador",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["rimel"] = {
		["index"] = "rimel",
		["name"] = "Rímel",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["blender"] = {
		["index"] = "blender",
		["name"] = "Liquidificador",
		["type"] = "Usável",
		["weight"] = 0.50
	},
	["switch"] = {
		["index"] = "switch",
		["name"] = "Interruptor",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["horseshoe"] = {
		["index"] = "horseshoe",
		["name"] = "Ferradura",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["brush"] = {
		["index"] = "brush",
		["name"] = "Escova",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["domino"] = {
		["index"] = "domino",
		["name"] = "Dominó",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["floppy"] = {
		["index"] = "floppy",
		["name"] = "Disquete",
		["type"] = "Comum",
		["weight"] = 0.15
	},
	["cup"] = {
		["index"] = "cup",
		["name"] = "Cálice",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["deck"] = {
		["index"] = "deck",
		["name"] = "Baralho",
		["type"] = "Usável",
		["weight"] = 0.15
	},
	["eraser"] = {
		["index"] = "eraser",
		["name"] = "Apagador",
		["type"] = "Comum",
		["weight"] = 0.15
	},
	["pliers"] = {
		["index"] = "pliers",
		["name"] = "Alicate",
		["type"] = "Comum",
		["weight"] = 0.25
	},
	["lampshade"] = {
		["index"] = "lampshade",
		["name"] = "Abajur",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["soap"] = {
		["index"] = "soap",
		["name"] = "Sabonete",
		["type"] = "Usável",
		["weight"] = 0.25
	},
	["slipper"] = {
		["index"] = "slipper",
		["name"] = "Chinelo",
		["type"] = "Comum",
		["weight"] = 0.50
	},
	["pendrive"] = {
		["index"] = "pendrive",
		["name"] = "Pendrive",
		["type"] = "Comum",
		["durability"] = 7,
		["weight"] = 0.25
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBody(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function itemIndex(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["index"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function itemName(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["name"]
	end

	return "Deletado"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemType(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["type"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMO
-----------------------------------------------------------------------------------------------------------------------------------------
function itemAmmo(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["ammo"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemVehicle(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["vehicle"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemWeight(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["weight"] or 0.0
	end

	return 0.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMMAXAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemMaxAmount(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["max"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemScape(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["scape"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCRIPTION
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDescription(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["desc"] or nil
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDurability(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["durability"] or false
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCHARGES
-----------------------------------------------------------------------------------------------------------------------------------------
function itemCharges(nameItem)
	local splitName = splitString(nameItem,"-")

	if itemlist[splitName[1]] then
		return itemlist[splitName[1]]["charges"] or nil
	end

	return nil
end