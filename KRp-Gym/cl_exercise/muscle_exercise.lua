local cooldownTime = Config.Cooldown * 60000

for i, coord in ipairs(Config.Muscleweight) do
    exports.qtarget:AddCircleZone("muscleweight" .. i, vec3(coord.x, coord.y, coord.z), 0.95, {
        useZ = true,
        name = "muscleweight",
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
                                    local animDict = "amb@world_human_muscle_free_weights@male@barbell@base"
                                    local animName = "base"

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

                                    local hash = GetHashKey("prop_curl_bar_01")
                                    RequestModel(hash)
                                    while not HasModelLoaded(hash) do
                                        Citizen.Wait(100)
                                        RequestModel(hash)
                                    end
                                    local prop = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, true)
                                    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.1,
                                        -0.1, 0.2, 79.0, 90.0, 30.0, true, true, false, false, 1, true)

                                    TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag,
                                        playbackRate, lockX, lockY, lockZ)
                                    local muscleweight = lib.skillCheck({ 'easy', 'easy', 'easy', 'easy', 'easy',
                                        { areaSize = 60, speedMultiplier = 1 }, 'medium' })
                                    if muscleweight then
                                        lib.notify({
                                            title = 'Gym',
                                            description = _U('you_had_good_exericise'),
                                            type = 'success'
                                        })
                                        ClearPedTasks(PlayerPedId())
                                        DeleteEntity(prop)
                                        Wait(2000)
                                        ESX.TriggerServerCallback('getStrength', function(strength)
                                            if strength then
                                                local newStrengthValue = strength + 1
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
                                        DeleteEntity(prop)
                                        ClearPedTasks(PlayerPedId())
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
                icon = "fas fa-child-reaching",
                label = _U('free_weight_exercise')
            }
        },
        distance = 1.5
    })
end
