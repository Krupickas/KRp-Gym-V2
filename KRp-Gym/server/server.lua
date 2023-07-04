ESX = exports["es_extended"]:getSharedObject()
ESX.RegisterServerCallback('getStrength', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT strength FROM player_skills WHERE identifier = @identifier', {
      ['@identifier'] = xPlayer.identifier
  }, function(result)
      if result[1] ~= nil then
          cb(result[1].strength)
      else
          cb(nil)
      end
  end)
end)

local cooldowns = {} -- Initialize the cooldowns table

ESX.RegisterServerCallback('krp_gym:checkCooldown', function(source, cb, playerId)
  local now = os.time(os.date("!*t")) * 1000
  local cooldownTime = Config.Cooldown * 60000


  if cooldowns[playerId] and cooldowns[playerId] > now then

      cb(cooldowns[playerId] - now)
  else
      cooldowns[playerId] = now + cooldownTime
      cb(0)
  end
end)

ESX.RegisterServerCallback('getStamina', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT stamina FROM player_skills WHERE identifier = @identifier', {
      ['@identifier'] = xPlayer.identifier
  }, function(result)
      if result[1] ~= nil then
          cb(result[1].stamina)
      else
          cb(nil)
      end
  end)
end)

RegisterServerEvent('updateStamina')
AddEventHandler('updateStamina', function(value)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.execute('UPDATE player_skills SET stamina = @value WHERE identifier = @identifier', {
      ['@value'] = value,
      ['@identifier'] = xPlayer.identifier
  })
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
  MySQL.Async.execute('INSERT IGNORE INTO player_skills (identifier, strength, stamina) VALUES (@identifier, @strength, @stamina)', {
      ['@identifier'] = xPlayer.identifier,
      ['@strength'] = 0,
      ['@stamina'] = 0
  })
end)
  
ESX.RegisterServerCallback('krp_gym:checkitem', function(source, cb, item)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local items = xPlayer.inventory

  cb(exports.ox_inventory:Search(source, 'count', item))
end)

ESX.RegisterServerCallback('krp_shop:checkMoney', function(source, cb, price)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getMoney() >= price then
    cb(true)
  else
    cb(false)    
  end
end)

ESX.RegisterServerCallback('krp_shop:buy', function(source, cb, price, item, pocet)
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.removeMoney(price)
  xPlayer.addInventoryItem(item, pocet)
  cb(true)
end)

RegisterServerEvent('updateStrength')
AddEventHandler('updateStrength', function(value)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.execute('UPDATE player_skills SET strength = @value WHERE identifier = @identifier', {
    ['@value'] = value,
    ['@identifier'] = xPlayer.identifier
  })
end)


ESX.RegisterServerCallback('bike_shop:buyBike', function(source, cb, model, price)
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.getMoney() >= price then
      xPlayer.removeMoney(price)
      cb(true)
  else
      cb(false)
  end
end)