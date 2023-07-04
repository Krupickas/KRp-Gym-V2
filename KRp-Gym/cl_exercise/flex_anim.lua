for exerciseIndex, exerciseData in pairs(Config.Flex) do
local exerciseName = 'exercise' .. exerciseIndex
exports.qtarget:AddCircleZone(exerciseName, exerciseData.coords, 0.95, {
    useZ = true,
    name = "flex",
    debugPoly = false
}, {
    options = {
        {
            action = function()

                local animDict = "amb@world_human_muscle_flex@arms_at_side@base"
                local animName = "base"
             
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
             
                local input = lib.inputDialog(_U('how_long_to_flex'), {_U('description')})

                if not input then return end
                local lockerNumber = tonumber(input[1] *1000)

                local duration = lockerNumber
                TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate, lockX, lockY, lockZ)
                SetEntityHeading(ped, 116.3601)
                
                showBusySpinner(_U('flexing_muscle'))
                Wait(lockerNumber)
                hideBusySpinner()
               ClearPedTasks(PlayerPedId())
            end,
            icon = "fas fa-medal",
            label = _U('flex')
        }
    },
    distance = 1.5
})
end


                
function showBusySpinner(message)
    BeginTextCommandBusyspinnerOn('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandBusyspinnerOn(2)
    end

    function hideBusySpinner()
        BusyspinnerOff()
    end
