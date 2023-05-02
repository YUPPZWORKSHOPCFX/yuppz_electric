--===== FiveM Script =========================================
--= electric - YUPPZWORKSHOP CFX (Webhook)
--===== Developed By: ========================================
--= YUPPZWORKSHOP CFX
--= Copyright (C) YUPPZWORKSHOP CFX - All Rights Reserved
--= You are not allowed to sell this script or edit
--============================================================

local ESX = nil
local script_name = GetCurrentResourceName()
local cachedChip = {}
local closestPlant = {
	GetHashKey("electric_pole"),
	GetHashKey("shot")
}
local prop2

local position = {}

local isPickingUp = false
local duration = 10000

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
	end

	if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)
Citizen.CreateThread(function()
	Citizen.Wait(1000)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	print("^2 YUPPZWORKSHOP : Actived ! | Supports!^1")
    print("^2 DISCORD : ^2https://discord.gg/KhnrE48Nfd")
end)


RegisterNetEvent("Chip:fetchCooldown")
AddEventHandler("Chip:fetchCooldown", function(netid, time)
	cachedChip[netid] = GetGameTimer() + (time * 1000)
end)

local bidchip = {}
local delay = 0
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		for k, Plant in pairs(Config.position) do 
				if GetDistanceBetweenCoords(playerCoords, Plant.coords, false) < 1.40 then
				sleep  = 5
				local netid = string.format("%.2f%.2f%.2f",Plant.coords.x,Plant.coords.y,Plant.coords.z)
				
				if cachedChip[netid] and cachedChip[netid] > GetGameTimer() then
					DrawText3D(Plant.coords.x, Plant.coords.y, Plant.coords.z + 1.5, '<font face="font4thai">ไม่มี ~r~ชิป~w~ ให้ขโมยแล้ว</font>')  
				else
					DrawText3D(Plant.coords.x, Plant.coords.y, Plant.coords.z + 1.5, '<font face="font4thai">กด ~r~[E]~w~ เพื่อขโมยชิปนี้</font>')  
				end
				local lPed = GetPlayerPed(-1)
				if IsControlJustReleased(0, 38) and delay < GetGameTimer() and not IsPedInAnyVehicle(lPed, false) and IsPedOnFoot(lPed) and not isPickingUp then
					if Hasitem(Config.ItemNeed) then 
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -255.94, -983.93, 30.21) < 18000 then 
					if not cachedChip[netid] or cachedChip[netid] and cachedChip[netid] < GetGameTimer() then
						if bidchip[netid] and bidchip[netid] > GetGameTimer() then
							TriggerEvent("pNotify:SendNotification", {
								text = 'มีคนกำลังขโมยเหมือนกัน!',
								type = "error",
								timeout = 5000,
								layout = "bottomCenter",
								queue = "global"
							})
						else
							delay = GetGameTimer() + 1000
							if exports.Check:CheckPolice(Config.Cops) then
								TriggerEvent(Config.EventNotify,Config.Type,Config.Color)
	                            TriggerEvent("maxez-police:alertNet", "chip")
	                            local PedPosition = GetEntityCoords(PlayerPedId())
	                            local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
                             	TriggerServerEvent('esx_addons_gcphone:startCall', 'police', ('มีคนกำลังจกปูน'), PlayerCoords, {
	                         	PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	                            })
								local Result = exports['xzero_skillcheck']:startGameSync({
									textTitle           = "คุณกำลังจะจกชิป", 
									speedMin            = 10,         
									speedMax            = 12,        
									countSuccessMax     = 5,         
									countFailedMax      = 3,          
								})
								if Result.status then
								--	print('success') 

									OpenPlant(Plant)
								else
									
									TaskStandStill(GetPlayerPed(-1),9.0)

									TriggerEvent("pNotify:SendNotification", {
										text = " <center><b style='color:white'>ดื้ออะเรา</b><br /></center>",
										type = "error",
										timeout = 5000,
										layout = "bottomCenter",
										queue = "global"
									})   

									FreezeEntityPosition(PlayerPedId(), true) -- ทำให้ผู้เล่น ขยับไม่ได้
									binCoords = nil
									TriggerEvent("mythic_progbar:client:progress", {
										name = "unique_action_name",
										duration = Config.timerfail,
										label = Config.timewait,
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
											disableMovement = false,
											disableCarMovement = false,
											disableMouse = false,
											disableCombat = false,
										},   
									},
									
									function(status)
										FreezeEntityPosition(PlayerPedId(), false) -- ทำให้ผู้เล่นขยับได้
										Tick2s = true
										setdistance = true	
									end)
								end				
							else
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">ตำรวจมีไม่เพียงพอ!</strong>',
									type = "error",
									timeout = 5000,
									layout = "bottomCenter",
									queue = "global"
								})
							end

						end
					else
						TriggerEvent("pNotify:SendNotification", {
							text = 'มีคนขโมยชิปนี้ไปเเล้ว',
							type = "error",
							timeout = 5000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				else 
					TriggerEvent("pNotify:SendNotification", {
						text = '<strong class="red-text">ไกลจากตัวเมืองเกินไป</strong>',
						type = "error",
						timeout = 5000,
						layout = "bottomCenter",
						queue = "global"
					})
				end
			else 
				TriggerEvent("pNotify:SendNotification", {
					text = '<strong class="red-text">คุณไม่มีอุปกรณ์ในการขโมยชิป</strong>',
					type = "error",
					timeout = 5000,
					layout = "bottomCenter",
					queue = "global"
				})
			end
				end
				break
			end
		end
		Citizen.Wait(sleep)
	end
end)




function OpenPlant(Plant)
	FreezeEntityPosition(PlayerPedId(), true) -- ทำให้ผู้เล่น ขยับไม่ได้
	TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = Config.time,
        label = Config.text,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        },   
    },
    function(status)
        if not status then
			FreezeEntityPosition(PlayerPedId(), false) -- ทำให้ผู้เล่นขยับได้
		end
	end)
	
	Citizen.CreateThread(function()
		local netid = string.format("%.2f%.2f%.2f",Plant.coords.x,Plant.coords.y,Plant.coords.z)
		local time = GetGameTimer() + duration
		
		while time > GetGameTimer() do
			Citizen.Wait(50)
			if cachedChip[netid] and cachedChip[netid] > GetGameTimer() then
				ESX.ShowNotification('<font face="font4thai">มีคน ~g~ขโมย~w~ ชิปนี้ไปแล้ว!</font>')
				return
			end
		end
		
		TriggerServerEvent('Chip:getItem', netid)
		ClearPedTasksImmediately(PlayerPedId())
		isPickingUp = false
	end)
end

RegisterNetEvent("Chip:fetchChip")
AddEventHandler("Chip:fetchChip", function(netid, src)
	if src ~= GetPlayerServerId(PlayerId()) then
		bidchip[netid] = GetGameTimer() + duration
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isPickingUp == true then
			DisableControlAction(0, 29, true) -- B
			DisableControlAction(0, 73, true) -- X
			DisableControlAction(0, 323, true) -- X
			DisableControlAction(0, 245, true) -- T
			DisableControlAction(0, 246, true) -- Y
			DisableControlAction(0, 170, true) -- F3
			DisableControlAction(0, 23, true)  -- F ขึ้นรถ
		end
	end
end)

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.45
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		--SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
	end
end

function Hasitem(item)
	local found = false 
	found = false 
	for k, v in pairs(ESX.GetPlayerData().inventory) do 
		if v.name == item and v.count >= 1 then 
			found = true 
		end 
	end 
	return found
end 


function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Citizen.Wait(10)
	end
end

Citizen.CreateThread(function()

	LoadModel('prop_barrier_work01b')

end)


function SpawnObjects()

	local heal = GetEntityHeading(GetPlayerPed(-1))  
	heal = heal + 180  
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	
	prop2 = CreateObject(GetHashKey("prop_barrier_work01b"), x, y, z + 2, true, true, true)
	Wait(500)

	SetEntityDynamic(prop2, true)

	Wait(600)
	StartScreenEffect('DeathFailOut', 0, true)
	RequestAnimDict("missfbi5ig_21")
	while (not HasAnimDictLoaded("missfbi5ig_21")) do Citizen.Wait(7) end
	Wait(100)

	TaskPlayAnim(GetPlayerPed(-1), "missfbi5ig_21", "hands_up_shocked_scientist", 8.0, 8.0, -1, 50, 0, false, false, false)


	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
	local health = GetEntityHealth(playerPed)

	local newHealth = math.min(maxHealth, math.floor(health + maxHealth / -9.0))
	
	SetEntityHealth(playerPed, newHealth)
	
	SetEntityRotation(prop2, 78.0, -0, heal, false, true)
	Citizen.Wait(31)
	SetEntityRotation(prop2, 80.0, -0, heal, false, true)
	Wait(1000)
	ClearPedTasks()
	StopScreenEffect('DeathFailOut')

end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then

		StopGameplayCamShaking(true)

		DeleteObject(prop2)


	end
end)

AddEventHandler('playerSpawned', function() -- ไม่ต้องเชื่อมหมอ
	Tick2s = true
	setdistance = true
	local player = PlayerPedId()
	TaskLeaveVehicle(player, GetVehiclePedIsIn(player, false), 1)
	ClearPedTasks(player)
	FreezeEntityPosition(player, false) -- ทำให้ผู้เล่นขยับได้
end)