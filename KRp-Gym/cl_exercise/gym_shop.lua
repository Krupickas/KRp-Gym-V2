local rentisactive = false

for i, v in ipairs(Config.Coordonate) do
    local x, y, z = table.unpack(v)
    exports.qtarget:AddCircleZone("SHOP", vector3(x, y, z+1), 0.75, {
        name = "SHOP",
        debugPoly = false,
    }, {
        options = {
            {
                event = "krp_shop:buyitems",
                icon = "fas fa-cart-shopping",
                label = _U('gym_shop'),
            },
        },
        distance = 3.5
    })
end




Citizen.CreateThread(function()

    for _, v in pairs(Config.Coordonate) do
        RequestModel(GetHashKey(v[7]))
        while not HasModelLoaded(GetHashKey(v[7])) do
            Wait(1)
        end

        RequestAnimDict("amb@world_human_leaning@male@wall@back@smoking@base")
        while not HasAnimDictLoaded("amb@world_human_leaning@male@wall@back@smoking@base") do
            Wait(1)
        end
        ped = CreatePed(4, v[6], v[1], v[2], v[3], 3374176, false, true)
        SetEntityHeading(ped, v[5])
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped, "amb@world_human_leaning@male@wall@back@smoking@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)



RegisterNetEvent('krp_shop:buyitems', function()

    lib.registerContext({
        id = 'gymshop',
        title = _U('gym_shop'),
        options = {
            {
                title = _U('membership'),
                icon = 'id-card',
                arrow = true,
                event = 'krp_shop:buying',
                args = {value1 = 300, value2 = 'Other value'}
            },
            {
                title = _U('rent_bike'),
                icon = 'bicycle',
                arrow = true,
                event = 'krp_rent_dialog',
                }
            }
    })
    lib.showContext('gymshop')
end)

RegisterNetEvent('krp_shop:buying')
AddEventHandler('krp_shop:buying', function()
    local price = Config.MembershipPrice
    ESX.TriggerServerCallback("krp_shop:checkMoney", function(hasEnoughMoney)
        if hasEnoughMoney then
            lib.progressCircle({
                duration = 5300,
                position = 'bottom',    
                useWhileDead = false,
                canCancel = false,
                disable = {
                    car = true,
                    move = true,
                },
                anim = {
                    dict = 'misscarsteal4@actor',
                    clip = 'actor_berating_loop'
                },
            })


            -- After the progress bar is finished, then buy the item
            ESX.TriggerServerCallback('krp_shop:buy', function(success)
                if success then
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    -- Handle the case when the purchase failed
                    print("Purchase failed")
                end
            end, price, Config.MembershipItem)

        else
            lib.notify({
                title = 'Gym',
                description = _U('not_enough_money'),
                type = 'error'
            })
        end
    end, price)
end)


RegisterNetEvent('krp_rent_dialog')
AddEventHandler('krp_rent_dialog', function()
    if not rentisactive then
    local elements = {}
    for i=1, #Config.Bikes, 1 do
        table.insert(elements, {label = Config.Bikes[i].label .. ' - $' .. Config.Bikes[i].price, value = Config.Bikes[i].model})
    end

    local input = lib.inputDialog('Bike Shop', {
        {type = 'select', label = _U('choose_bike'), description = _U('select_bike'), options = elements}
    })

    local model = input[1]

    ESX.TriggerServerCallback('bike_shop:buyBike', function(bought)
        if bought then
            ESX.Game.SpawnVehicle(model, vector3(Config.SpawnLocation.x, Config.SpawnLocation.y, Config.SpawnLocation.z), Config.SpawnLocation.h, function(vehicle)
                rentisactive = true
                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            end)
        else
            lib.notify({
                title = 'Gym',
                description = _U('not_enough_money'),
                type = 'error'
            })
        end
    end, model, GetPriceByModel(model))
else
    lib.notify({
        title = 'Gym',
        description = _U('already_have_rent'),
        type = 'error'
    })
  end
end)

function GetPriceByModel(model)
    for i=1, #Config.Bikes, 1 do
        if Config.Bikes[i].model == model then
            return Config.Bikes[i].price
        end
    end
    return nil
end