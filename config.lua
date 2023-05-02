--===== FiveM Script =========================================
--= electric - YUPPZWORKSHOP CFX (Webhook)
--===== Developed By: ========================================
--= YUPPZWORKSHOP CFX
--= Copyright (C) YUPPZWORKSHOP CFX - All Rights Reserved
--= You are not allowed to sell this script or edit
--============================================================

Config = {}
Config.Cops = 0 -- @=>ตำรวจกี่คน
Config.amount = 1 -- @=>จำนวน
Config.time = 10000  -- @=>เวลาการจก
Config.timerfail = 10000 -- @=>เวลาจกพลาด
Config.ItemNeed = '?'  -- @=>ชื่อไอเทมต้องการตัด
Config.itemdrop = '?'  -- @=>ไอเทมตอบแทน
Config.Type = "?"  -- @=>ชื่อของactionแจ้งเตือนตำรวจ
Config.Color = "?" -- @=>สี https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
Config.timewait = "?'" -- @=>ข้อความจกพลาด
Config.text = "?"  -- @=>ข้อความเวลาจก
Config.EventNotify = "maxez-police:alertNet"  -- @=>แจ้งเตือนตำรวจ
Config["Discord"] = {
    Webhook = '?', -- @=>webhook
    Enable = false, -- @=> เปิดใช้ Discord Log แยก
    DiscordLog = function(playerId,text) -- @=> Log แยก
		TriggerEvent('azael_discordlogs:sendToDiscord', 'wirenew', sendToDiscord, xPlayer.source, '^2')  -- @=>logazael
    end
}
Config.position = {  -- @=>ตำแหน่งของสายไฟไม่ต้องเปลื่ยน
	pos1 = { coords = vector3(155.6444, -1315.568, 38.59595)}, 
	pos2 = { coords = vector3(-143.5248, -1632.729, 37.52371)}, 
	pos3 = { coords = vector3(-1124.809, -946.7019, 6.719596)}, 
	pos4 = { coords = vector3(-1468.541, -174.9169, 53.38261)}, 
	pos5 = { coords = vector3(959.7475, -202.4489, 77.63415)}, 
	pos6 = { coords = vector3(1367.717, -580.6389, 78.93861)}, 
	pos7 = { coords = vector3(689.8991, -957.2914, 28.06781)}, 
	pos8 = { coords = vector3(578.3935, -1796.889, 30.60752)}, 
	pos9 = { coords = vector3(67.00222, 51.3228, 78.07922)}, 
	pos10 = { coords = vector3(-643.4533, -1221.874, 15.71313)}, 

}
