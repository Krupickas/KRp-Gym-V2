Config = {}

Config.Locale = 'cs'

Config.MembershipPrice = 10 

Config.MembershipItem = 'membership' --Membership item name 

Config.Cooldown = 2 -- In minutes


Config.Bikes = {
  {model = 'bmx', label = 'BMX Bike', price = 100},
  {model = 'cruiser', label = 'Cruiser Bike', price = 150},
  {model = 'fixter', label = 'Fixter Bike', price = 200},
  -- add more bikes as needed
}

Config.SpawnLocation = { x = -1188.8418, y = -1572.3873, z = 4.3333, h = 156.8385 } -- BIKE SPAWN RENT

Config.Coordonate = { --NPC
  { -1195.0779, -1577.4967, 3.6035, "", 129.1471, 0x07DD91AC, "a_m_m_eastsa_02" }
}

Config.OneHand = { 
  { x = -1209.9762, y = -1558.4160, z = 4.8379 },
  { x = -1203.2957, y = -1573.5851, z = 4.9189 },
  { x = -1198.0125, y = -1565.2007, z = 4.6202 }
}

Config.Muscleweight = {
  { x = -1203.0780, y = -1564.9979, z = 4.6117 },
  { x = -1210.5846, y = -1561.3026, z = 4.6080 },
  { x = -1196.7904, y = -1573.1229, z = 4.6128 },
  { x = -1198.9729, y = -1574.6727, z = 4.6097 }
}

Config.Bench = {
  [1] = {
    coords = vector3(-1207.0001, -1560.8286, 4.0178),
    entityCoords = vector3(-1206.9447, -1561.1111, 3.1063),
    heading = 218.0
  },
  [2] = {
    coords = vector3(-1200.5836, -1562.0752, 4.0097),
    entityCoords = vector3(-1200.5911, -1562.0846, 3.1063),
    heading = 126.4908
  },
  -- Add more exercises here as needed
}

Config.Bike = {
  [1] = {
    coords = vector3(-1209.3685, -1562.9207, 4.0536),
    entityCoords = vector3(-1209.3424, -1562.9297, 4.1328),
    heading = 124.9282
  },
  [2] = {
    coords = vector3(-1208.1075, -1564.7186, 4.5407),
    entityCoords = vector3(-1208.1075, -1564.7186, 4.1328),
    heading = 123.3604
  },
  [3] = {
    coords = vector3(-1196.1495, -1570.3285, 4.1041),
    entityCoords = vector3(-1196.1278, -1570.3947, 4.1328),
    heading = 304.7292
  },
  [4] = {
    coords = vector3(-1194.8844, -1572.1680, 4.1050),
    entityCoords = vector3(-1194.8844, -1572.1680, 4.1328),
    heading = 308.8647
  },
  -- Add more exercises here as needed
}

Config.Chinups = {
  [1] = {
    coords = vector3(-1204.9618, -1563.9692, 4.6085),
    entityCoords = vector3(-1204.7554, -1564.3160, 3.6085),
    heading = 34.3727
  },
  [2] = {
    coords = vector3(-1199.9476, -1571.1968, 4.6096),
    entityCoords = vector3(-1199.8259, -1571.3915, 3.6085),
    heading = 34.3727
  },
  -- Add more exercises here as needed
}

Config.Situps = {
  [1] = {
    coords = vector3(-1204.9618, -1563.9692, 4.6085),
    entityCoords = vector3(-1201.2391, -1566.6486, 4.0158),
    heading = 218.7526
  },
  [2] = {
    coords = vector3(-1203.4559, -1567.7660, 4.0093),
    entityCoords = vector3(-1203.4559, -1567.7660, 4.0093),
    heading = 218.7526
  },
  -- Add more exercises here as needed
}

Config.Flex = {
  [1] = {
    coords = vector3(-1209.0870, -1578.3057, 3.6080),
  },
  [2] = {
    coords = vector3(-1212.6918, -1573.1927, 3.6074),
  },
  -- Add more exercises here as needed
}

Config.BlipsForEveryone = {

  Blip = {
    Pos     = { x = -1200.9525, y = -1568.9302, z = 4.6106 },
    Sprite  = 311,
    Display = 4,
    Scale   = 0.8,
    Colour  = 38,
  },

}
