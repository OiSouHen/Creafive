fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "ui/index.html"
shared_script "shared.lua"

client_scripts {
	"client/init/proximity.lua",
	"client/init/init.lua",
	"client/init/main.lua",
	"client/module/*.lua",
	"client/*.lua"
}

server_scripts {
	"server/**/*.lua"
}

files {
	"ui/*.ogg",
	"ui/css/*.css",
	"ui/js/*.js",
	"ui/index.html"
}