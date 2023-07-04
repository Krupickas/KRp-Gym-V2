-- When player types '/skill' command in chat
RegisterCommand('skill', function()
  -- Fetch latest strength and stamina values
  ESX.TriggerServerCallback('getStrength', function(strength)
    ESX.TriggerServerCallback('getStamina', function(stamina)
      -- Now we have latest strength and stamina values
      -- Register a new context menu with these values
      lib.registerContext({
        id = 'skill_menu',
        title = 'Skills',
        options = {
          {
            title = 'Strength',
            description = 'Your current strength is ' .. (strength or 0),
            icon = 'dumbbell',
            action = function()
              exports['ox_inventory']:Notify({text = 'Your current strength is ' .. strength})
            end,
            progress = strength or 0,
            colorScheme = 'red'
          },
          {
            title = 'Stamina',
            description = 'Your current stamina is ' .. (stamina or 0),
            icon = 'running',
            action = function()
              exports['ox_inventory']:Notify({text = 'Your current stamina is ' .. stamina})
            end,
            progress = stamina or 0,
            colorScheme = 'green'
          }
        }
      })
      -- Show the context menu
      lib.showContext('skill_menu')
    end)
  end)
end, false)
