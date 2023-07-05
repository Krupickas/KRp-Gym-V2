for exerciseIndex, exerciseData in pairs(Config.Bench) do
    local exerciseName = 'exercise' .. exerciseIndex
    exports.qtarget:AddCircleZone(exerciseName, exerciseData.coords, 0.95, {
        useZ = true,
        name = "bench",
        debugPoly = false
    }, {
        options = {
            {
                action = function()
                    local animDict = "amb@prop_human_seat_muscle_bench_press@idle_a"
                    local animName = "idle_a"

                    while not HasAnimDictLoaded(animDict) do
                        RequestAnimDict(animDict)
                        Wait(100)
                    end

                    local blendInSpeed = 8.0
                    local blendOutSpeed = 8.0
                    local flag = 49
                    local playbackRate = 0.0
                    local lockX = false
                    local lockY = false
                    local lockZ = false
                    local ped = PlayerPedId()

                    ESX.TriggerServerCallback('krp_gym:checkitem', function(ano)
                        if ano >= 1 then
                            ESX.TriggerServerCallback('krp_gym:checkCooldown', function(cooldownRemaining)
                                if cooldownRemaining <= 0 then
                            SetEntityCoords(ped, exerciseData.entityCoords.x, exerciseData.entityCoords.y,
                                exerciseData.entityCoords.z, 0, 0, 0, true)
                            SetEntityHeading(ped, exerciseData.heading)

                            FreezeEntityPosition(ped, true)
                            local hash = GetHashKey("prop_barbell_100kg")
                            RequestModel(hash)
                            while not HasModelLoaded(hash) do
                                Citizen.Wait(100)
                                RequestModel(hash)
                            end
                            local propbench = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, true, true)
                            AttachEntityToEntity(propbench, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.17,
                                0.33, 0.0, -43.0, -43.0, -103.0, true, true, false, false, 1, true)
                            TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, 50000, 0, playbackRate,
                                lockX, lockY, lockZ)

                            local muscleweight = lib.skillCheck({ 'easy', 'easy', 'easy', 'easy', 'easy',
                                { areaSize = 60, speedMultiplier = 1 }, 'medium' })
                            if muscleweight then
                                lib.notify({
                                    title = 'Gym',
                                    description = _U('you_had_good_exericise'),
                                    type = 'success'
                                })
                                ClearPedTasks(PlayerPedId())
                                DeleteObject(propbench)
                                FreezeEntityPosition(ped, false)
                                ESX.TriggerServerCallback('getStrength', function(strength)
                                    if strength then
                                        local newStrengthValue = strength + 2.5
                                        TriggerServerEvent('updateStrength', newStrengthValue)
                                    else
                                        -- Handle the case when the strength value is nil
                                        print("Strength value is nil")
                                    end
                                end)
                            else
                                ClearPedTasks(PlayerPedId())
                                DeleteObject(propbench)
                                FreezeEntityPosition(ped, false)
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
                icon = "fas fa-scale-balanced",
                label = _U('bench_exercise')
            }
        },
        distance = 1.5
    })
end
