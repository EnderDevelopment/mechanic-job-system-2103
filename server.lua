local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('mechanicjob:checkJob', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == 'mechanic' then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('mechanicjob:repairVehicle')
AddEventHandler('mechanicjob:repairVehicle', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == 'mechanic' then
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(src), false)
        if DoesEntityExist(vehicle) then
            local plate = GetVehicleNumberPlateText(vehicle)
            local health = GetVehicleEngineHealth(vehicle)

            MySQL.Async.execute('UPDATE mechanic_job_vehicles SET health = @health WHERE plate = @plate', {
                ['@health'] = health,
                ['@plate'] = plate
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('mechanicjob:repairVehicle', src)
                else
                    TriggerClientEvent('QBCore:Notify', src, "Failed to repair vehicle!", "error")
                end
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, "You must be in a vehicle to repair it!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You are not a mechanic!", "error")
    end
end)