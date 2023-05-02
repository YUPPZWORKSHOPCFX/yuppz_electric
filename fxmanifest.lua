--===== FiveM Script =========================================
--= electric - YUPPZWORKSHOP CFX (Webhook)
--===== Developed By: ========================================
--= YUPPZWORKSHOP CFX
--= Copyright (C) YUPPZWORKSHOP CFX - All Rights Reserved
--= You are not allowed to sell this script or edit
--============================================================

fx_version "cerulean"
game "gta5"

description 'YUPPz WORKSHOP CFX'
 
client_scripts { 
	"client/client.lua",
	"config.lua" 
} 
 
server_scripts { 
	"server/server.lua",
	"config.lua"
} 

exports{
	'CheckPolice'
}
