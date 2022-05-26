fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "gui/index.html"

client_scripts {
	"lib/vehicles.lua",
	"lib/itemlist.lua",
	"lib/utils.lua",
	"client/*"
}

server_scripts {
	"lib/vehicles.lua",
	"lib/itemlist.lua",
	"lib/utils.lua",
	"modules/*"
}

files {
	"loading/*",
	"lib/*",
	"gui/*"
}

loadscreen "loading/index.html"