fx_version 'bodacious'
game 'gta5'

author 'Nosmakos'
description 'ESX Advanced Report System'
version '1.0.0'

client_scripts {
    'client/main.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'config.lua'
}

dependency 'es_extended'
