fx_version 'cerulean'
game 'gta5'

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}

files {
    'database.sql'
}