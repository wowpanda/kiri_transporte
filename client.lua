local comienzoruta = false
local voyencarretera = false
local voyacargar = false
local dejandoentrega = false
local voyderegreso = false
local puntoair = 0
local infojobs = {
	{x = 154.78, y = 169.64, z = 103.56}, --1
    {x = 180.73, y = 303.1, z = 103.89}, --2
    {x = 171.37, y = 23.47, z = 72.22}, --3
    {x = 175.01, y = -66.89, z = 67.47}, --4
    {x = 276.16, y = 3.94, z = 78.12}, --5
    {x = 133.97, y = 88.23, z = 81.53}, --6
    {x = 325.76, y = -180.6, z = 57.38}, --7
	{x = -43.19, y = -65.5, z= 58.79}, --8
	{x = 24.41, y= -241.56, z= 46.34}, --9
	{x = 110.44, y= -290.51, z= 44.59}, --10
	{x=52.92, y=6641.76, z=31.24}, --11
	{x=-8.52,  y=6621.96, z=30.76}, --12
	{x=-451.68, y=6355.24, z=12.28}, --13
	{x=-690.88, y=57771.12, z=17.04}, --14
	{x=-771.28, y=5582.8, z=33.2}, --15
	{x=1584.16, y=6447.72, z=24.84}, --16
	{x=1697.16, y=6422.56, z=32.32} --17
}
local job = nil
AddEventHandler('playerSpawned', function(spawn)
  TriggerServerEvent('kir_transporte:getJob')
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    TriggerServerEvent('kir_transporte:getJob')
end)
TriggerServerEvent('kir_transporte:getJob')
RegisterNetEvent('kir_transporte:setJob')
AddEventHandler('kir_transporte:setJob',function(jobu)
  job = jobu
end)

---#FUNCIONES#---

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function kiricoche()
	local vehicle = GetHashKey('burrito3')
 
    RequestModel(vehicle)
 
    while not HasModelLoaded(vehicle) do
        Wait(1)
    end
 
	local plate = math.random(100, 900)
	local tractor = CreateVehicle(vehicle,-860.71,-2698.85,13.5, 63.78, true, false)
	SetVehicleOnGroundProperly(tractor)
	SetVehicleNumberPlateText(tractor, "CTZN"..plate)
	SetPedIntoVehicle(GetPlayerPed(-1), tractor, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(tractor))
	TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(tractor), GetDisplayNameFromVehicleModel(GetEntityModel(tractor))) 
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function eligorandoms()
	puntoair = math.random(1,3)
	dejandoentrega = true
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end

----###SCRIPT###----

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(27,-876.45,-2715.58,12.82, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.8,255,0,0, 200, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(-876.45,-2715.58,12.82, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
			if voyencarretera == false then
				if voyderegreso == false then
					drawTxt('Presiona ~g~E~s~ para conseguir tu camion', 27, 27, 0.5, 0.8, 0.6, 255, 255, 255, 255)
					if IsControlJustReleased(1, 38) and job == "transport" then
						kiricoche()
						comienzoruta = true
						voyacargar = true
						voyencarretera = true
					elseif IsControlJustReleased(1, 38) and not(job == "transport") then
						TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"No eres transportista.")
					end
				else
					drawTxt('Presiona ~g~E~s~ para cobrar tu paga', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
					if IsControlJustReleased(1, 38) then
						if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("burrito3"))  then
							local myPed = GetPlayerPed(-1)
							local myVehicle = GetVehiclePedIsIn(myPed, false)
	                   		SetEntityAsMissionEntity( myVehicle, true, true )
	                    	deleteCar( myVehicle )
	                    	local sueldoinicial = math.random(200,700)
	                    	local dineropokm = GetDistanceBetweenCoords(-875.27,-2734.53,12.86,infojobs[puntoair].x,infojobs[puntoair].y,infojobs[puntoair].z,true) * 0.5
	                    	dineropokmrd = round(dineropokm,0)
	                    	local sueldofinal = dineropokmrd + sueldoinicial
	                    	TriggerServerEvent('exp:addExperience',65)
	                    	RegisterNetEvent('kir_transporte:paga')
	                    	TriggerServerEvent('kir_transporte:paga',sueldofinal)
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,102,0},"***********************************************=")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,102,0}, " Sueldo inicial:" ..sueldoinicial.."$")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,102,0}, " Sueldo por distancia:" ..dineropokmrd.."$")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,102,0}, "Sueldo final:" ..sueldofinal.."$")
	                    	TriggerEvent('chatMessage', 'SYSTEM', {255,102,0}, "***********************************************")
	                    	voyderegreso = false
						else
							TriggerEvent('chatMessage', 'TRANS OASIS S.L.', {255, 0, 0},"Debes devolver tu camión.")
						end
					end
				end
			else
				drawTxt('Presiona ~g~E~s~ para finalizar tu trabajo sin cobrar', 2, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				if IsControlJustReleased(1, 38) then
					if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
						local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	                    SetEntityAsMissionEntity( vehicleu, true, true )
	                    deleteCar( vehicleu )
						comienzoruta = false
						voyacargar = false
						voyencarretera = false
						voyderegreso = false
						dejandoentrega = false
						TriggerEvent('chatMessage', 'TRANS OASIS S.L.', {255, 0, 0},"Tu camión ha sido devuelto.")
					else
						TriggerEvent('chatMessage', 'TRANS OASIS S.L.', {255, 0, 0},"Debes devolver tu camión.")
					end
				end
			end
		end
		if voyacargar then
			drawTxt('Ve a cargar el camion', 2, 1, 0.5, 1, 0.6, 255, 255, 255, 255)
			DrawMarker(27,-875.27,-2734.53,12.86, 0, 0, 0, 0, 0, 0, 2.5001, 2.5001, 1.6001,255,0,0, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(-875.27,-2734.53,12.86,  GetEntityCoords(GetPlayerPed(-1))) < 2.0 then
				FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),true)
				Wait(5000)
				FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),false)
				TriggerEvent('chatMessage', 'TRANS OASIS S.L.', {255, 0, 0},"Camión cargado.")
				voyacargar = false
				eligorandoms()
			end
		end
		if dejandoentrega then
			drawTxt('Ve a entregar la carga', 2, 1, 0.5, 1, 0.6, 255, 255, 255, 255)
			DrawMarker(27,infojobs[puntoair].x,infojobs[puntoair].y,infojobs[puntoair].z, 0, 0, 0, 0, 0, 0, 2.5001, 2.5001, 1.6001,255,0,0, 200, 0, 0, 0, 0)
			SetNewWaypoint(infojobs[puntoair].x,infojobs[puntoair].y)
			if GetDistanceBetweenCoords(infojobs[puntoair].x,infojobs[puntoair].y,infojobs[puntoair].z, GetEntityCoords(GetPlayerPed(-1))) < 2.0 then
				if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					TriggerEvent('chatMessage', 'TRANS OASIS S.L.', {255, 0, 0},"DEBES ESTAR EN TU CAMIÓN.")
				else
					TriggerEvent('chatMessage', 'TRANS OASIS S.L.', {255, 0, 0},"Espera mientras descargas la mercancía.")
					FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),true)
					Wait(5000)
					FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),false)
					voyacargar = false
					dejandoentrega = false
					voyencarretera = false
					voyderegreso = true
				end
			end
		end
		if voyderegreso then
			drawTxt('Vuelve a tu empresa para ~red~cobrar~s~ y poder elegir una nueva ~g~ruta~s~', 2, 1, 0.5, 1, 0.6, 255, 255, 255, 255)
			SetNewWaypoint(-875.27,-2734.53,12.86)
		end
		if IsEntityDead(GetPlayerPed(-1)) then 
			voyderegreso = false
      		voyencarretera = false
      		dejandoentrega = false
      		voyacargar = false
      		comienzoruta = false
		end
	end
end)


----==================----
----=======BLIPS======----
----==================----
local blips = {
    {title="MRW", colour=29, id=616, x = -875.27, y = -2734.53, z = 12.86},
}
 
Citizen.CreateThread(function()
	Citizen.Wait(0)
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end

end)

