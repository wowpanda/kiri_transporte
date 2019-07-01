print("^2[VERSION 0.4]^7Kiri transporte cargado correctamente.[^2Sientase libre de ^8modificar^7 a su gusto]")
RegisterServerEvent('kir_transporte:paga')
AddEventHandler('kir_transporte:paga', function(price)
	TriggerEvent('es:getPlayerFromId', source, function(user)
    	total = price
		user.addMoney((total))
		TriggerClientEvent('chatMessage', source, 'Kirito-Dev | ', {255, 0, 0}, "Has ganado "..total.."€.")
 	end)
end)

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('kir_transporte:getJob')
AddEventHandler('kir_transporte:getJob',function()
	local source = source
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayers[i] == source then
			TriggerClientEvent('kir_transporte:setJob',xPlayers[i],xPlayer.job.name)
		end
	end
end)