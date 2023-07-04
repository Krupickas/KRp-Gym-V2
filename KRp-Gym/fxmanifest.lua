fx_version 'adamant'

Author 'Krupickas'

game 'gta5'

version '1.1.0'

Author 'Krupickas'

lua54 'yes'

ui_page 'html/watch.html'

shared_script {
  '@ox_lib/init.lua',
  '@es_extended/imports.lua'
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/cs.lua',
  'config.lua',
  'cl_exercise/*.lua'
}
server_scripts {
  '@es_extended/locale.lua',
  '@oxmysql/lib/MySQL.lua',
  'locales/en.lua',
  'locales/cs.lua',
  'config.lua',
  'server/server.lua'
}