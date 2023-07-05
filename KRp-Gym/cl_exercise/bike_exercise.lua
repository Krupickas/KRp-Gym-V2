local cooldownTime = Config.Cooldown * 60000

for exerciseIndex, exerciseData in pairs(Config.Bike) do
    local exerciseName = 'exercise' .. exerciseIndex
    exports.qtarget:AddCircleZone(exerciseName, exerciseData.coords, 0.95, {
        useZ = true,
        name = "bike",
        debugPoly = false
    }, {
        options = {
            {
                action = function()
                            ESX.TriggerServerCallback('krp_gym:checkitem', function(ano)
                                if ano >= 1 then
                                    ESX.TriggerServerCallback('krp_gym:checkCooldown', function(cooldownRemaining)
                                        if cooldownRemaining <= 0 then
                                    TaskStartScenarioAtPosition(PlayerPedId(), 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER', exerciseData.entityCoords.x, exerciseData.entityCoords.y, exerciseData.entityCoords.z, exerciseData.heading, 100000, 0, true, true)

                                    local animDict = "amb@world_human_jog_standing@male@idle_a"
                                    local animName = "idle_a"

                                    while not HasAnimDictLoaded(animDict) do
                                        RequestAnimDict(animDict)
                                        Wait(100)
                                    end

                                    local blendInSpeed = 8.0
                                    local blendOutSpeed = 8.0
                                    local duration = -1
                                    local flag = 49
                                    local playbackRate = 0.0
                                    local lockX = false
                                    local lockY = false
                                    local lockZ = false
                                    local ped = PlayerPedId()

                                    TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate,
                                    lockX, lockY, lockZ)

                                    SetPedKeepTask(ped, true)

                                    local muscleweight = lib.skillCheck({ 'easy', 'easy', 'easy', 'easy', 'easy',
                                        { areaSize = 60, speedMultiplier = 1 }, 'medium' })
                                    if muscleweight then
                                        lib.notify({
                                            title = 'Gym',
                                            description = _U('you_had_good_exericise'),
                                            type = 'success'
                                        })
                                        ClearPedTasks(PlayerPedId())
                                        Wait(2000)
                                        ClearArea(-1203.1309, -1565.3317, 4.6112, 25, true, true, false, false)
                                        ESX.TriggerServerCallback('getStamina', function(stamina)
                                            if stamina then
                                                local newStaminaValue = stamina + 1
                                                TriggerServerEvent('updateStamina', newStaminaValue)
                                            else
                                                print("Stamina value is nil")
                                            end
                                        end)
                                    else
                                        ClearPedTasks(PlayerPedId())
                                        lib.notify({
                                            title = 'Gym',
                                            description = _U('you_had_bad_exericise'),
                                            type = 'error'
                                        })
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
                                        Wait(2000)
                                        ClearArea(-1203.1309, -1565.3317, 4.6112, 25, true, true, false, false)
                                        Wait(2000)
                                        ClearArea(-1203.1309, -1565.3317, 4.6112, 25, true, true, false, false)
                                    end
                                else
                                    lib.notify({
                                        title = 'Gym',
                                        description = _U('please_Wait') .. math.floor(cooldownRemaining / 60000) .. _U('minutes_before_exercise'),
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
                icon = "fas fa-bicycle",
                label = _U('bike_exercise')
            }
        },
        distance = 1.5
    })
end
