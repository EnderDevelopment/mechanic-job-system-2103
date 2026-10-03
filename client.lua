local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local mechanicJob = QBCore.Functions.GetPlayerData().job.name

        if mechanicJob == 'mechanic' then
            for _, coords in pairs(Config.MechanicJob.VehicleRepairCoords) do
                local distance = #(playerCoords - coords)

                if distance < 5.0 then
                    DrawMarker(1, coords.x, coords.y, coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 0, 0, 100, false, true, 2, false, nil, nil, false)

                    if distance < 1.5 then
                        QBCore.Functions.DrawText3D(coords.x, coords.y, coords.z, "[E] Repair Vehicle")

                        if IsControlJustReleased(0, 38) then
                            TriggerServerEvent('mechanicjob:repairVehicle')
                        end
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('mechanicjob:repairVehicle')
AddEventHandler('mechanicjob:repairVehicle', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) then
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehiclePetrolTankHealth(vehicle, 1000.0)
        QBCore.Functions.Notify("Vehicle repaired!", "success")
    else
        QBCore.Functions.Notify("You must be in a vehicle to repair it!", "error")
    end
end)