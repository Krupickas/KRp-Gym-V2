local cooldownTime = Config.Cooldown * 60000

for exerciseIndex, exerciseData in pairs(Config.Chinups) do
    local exerciseName = 'exercise' .. exerciseIndex
    exports.qtarget:AddCircleZone(exerciseName, exerciseData.coords, 0.95, {
        useZ = true,
        name = "chins",
        debugPoly = false
    }, {
        options = {
            {
                action = function()
                    ESX.TriggerServerCallback('krp_gym:checkitem', function(ano)
                        if ano >= 1 then
                            ESX.TriggerServerCallback('krp_gym:checkCooldown', function(cooldownRemaining)
                                if cooldownRemaining <= 0 then
                                    local playerPed = GetPlayerPed(-1)
                                    FreezeEntityPosition(playerPed, true)
                                    SetEntityCoords(playerPed, exerciseData.entityCoords.x, exerciseData.entityCoords.y,
                                        exerciseData.entityCoords.z, 0, 0, 0, true)
                                    SetEntityHeading(playerPed, exerciseData.heading)
                                    TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
                                    Wait(4300)
                                    local chinups = lib.skillCheck({ 'easy', 'easy', 'easy', 'easy', 'easy',
                                        { areaSize = 60, speedMultiplier = 1 }, 'medium' })
                                    if chinups then
                                        lib.notify({
                                            title = 'Gym',
                                            description = _U('you_had_good_exericise'),
                                            type = 'success'
                                        })
                                        ClearPedTasks(PlayerPedId())
                                        Wait(2000)
                                        FreezeEntityPosition(playerPed, false)
                                        ESX.TriggerServerCallback('getStrength', function(strength)
                                            if strength then
                                                local newStrengthValue = strength + 1.5
                                                TriggerServerEvent('updateStrength', newStrengthValue)
                                            else
                                                -- Handle the case when the strength value is nil
                                                print("Strength value is nil")
                                            end
                                        end)
                                    else
                                        lib.notify({
                                            title = 'Gym',
                                            description = _U('you_had_bad_exericise'),
                                            type = 'error'
                                        })
                                        FreezeEntityPosition(playerPed, false)
                                        ClearPedTasks(PlayerPedId())
                                        Wait(1000)
                                        lib.progressBar({
                                            duration = 4000,
                                            label = _U('catching_breath'),
                                            useWhileDead = false,
                                            canCancel = true,
                                            disable = {
                                                car = true,
                                            },
                                            anim = {
                                                dict = 're@construction',
                                                clip = 'out_of_breath'
                                            },
                                        })
                                    end
                                else
                                    lib.notify({
                                        title = 'Gym',
                                        description = _U('please_Wait') ..
                                        math.floor(cooldownRemaining / 60000) .. _U('minutes_before_exercise'),
                                        type = 'error'
                                    })
                                end
                            end, GetPlayerServerId(PlayerId()))
                        else
                            lib.notify({
                                title = 'Gym',
                                description = _U('u_dont_have_membership'),
                                type = 'error'
                            })
                        end
                    end, Config.MembershipItem)
                end,
                icon = "fas fa-litecoin-sign",
                label = _U('chins_exercise')
            }
        },
        distance = 1.5
    })
end
