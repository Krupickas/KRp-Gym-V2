local cooldownTime = Config.Cooldown * 60000

for exerciseIndex, exerciseData in pairs(Config.Situps) do
    local exerciseName = 'exercise' .. exerciseIndex

    exports.qtarget:AddCircleZone(exerciseName, exerciseData.coords, 0.75, {
        useZ = true,
        name = "situps",
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
                                    SetEntityCoords(playerPed, exerciseData.entityCoords.x, exerciseData.entityCoords.y,
                                        exerciseData.entityCoords.z, 0, 0, 0, true)
                                    SetEntityHeading(playerPed, exerciseData.heading)
                                    TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
                                    Wait(5000)
                                    local situps = lib.skillCheck({ 'easy', 'easy', 'easy', 'easy', 'easy',
                                        { areaSize = 60, speedMultiplier = 1 }, 'medium' })
                                    if situps then
                                        lib.notify({
                                            title = 'Gym',
                                            description = _U('you_had_good_exericise'),
                                            type = 'success'
                                        })
                                        ClearPedTasks(PlayerPedId())
                                        Wait(2000)
                                        ESX.TriggerServerCallback('getStrength', function(strength)
                                            if strength then
                                                local newStrengthValue = strength + 1.0
                                                TriggerServerEvent('updateStrength', newStrengthValue)
                                            else
                                                -- Handle the case when the strength value is nil
                                                print("Strength value is nil")
                                            end
                                        end)
                                    else
                                        ClearPedTasks(PlayerPedId())
                                        Wait(4500)
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
                icon = "fas fa-person",
                label = _U('situps_exercise')
            }
        },
        distance = 1.5
    })
end
