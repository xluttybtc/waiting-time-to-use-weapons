ESX = exports["es_extended"]:getSharedObject()
local playerPed = PlayerPedId()


-- Tabla de armas restringidas
local weapons = {
    [GetHashKey("weapon_pistol")] = "weapon_pistol",
    [GetHashKey("weapon_knife")] = "weapon_knife",
    [GetHashKey("weapon_bat")] = "weapon_bat",
    [GetHashKey("weapon_switchblade")] = "weapon_switchblade",
    [GetHashKey("weapon_pistol_mk2")] = "weapon_pistol_mk2",
    [GetHashKey("weapon_combatpistol")] = "weapon_combatpistol",
    [GetHashKey("weapon_appistol")] = "weapon_appistol",
    [GetHashKey("weapon_pistol50")] = "weapon_pistol50",
    [GetHashKey("weapon_snspistol")] = "weapon_snspistol",
    [GetHashKey("weapon_snspistol_mk2")] = "weapon_snspistol_mk2",
    [GetHashKey("weapon_heavypistol")] = "weapon_heavypistol",
    [GetHashKey("weapon_vintagepistol")] = "weapon_vintagepistol",
    [GetHashKey("weapon_marksmanpistol")] = "weapon_marksmanpistol",
    [GetHashKey("weapon_revolver")] = "weapon_revolver",
    [GetHashKey("weapon_doubleaction")] = "weapon_doubleaction",
    [GetHashKey("weapon_ceramicpistol")] = "weapon_ceramicpistol",
    [GetHashKey("weapon_navyrevolver")] = "weapon_navyrevolver",
    [GetHashKey("weapon_gadgetpistol")] = "weapon_gadgetpistol",
    [GetHashKey("weapon_pistolxm3")] = "weapon_pistolxm3",
    [GetHashKey("weapon_microsmg")] = "weapon_microsmg",
    [GetHashKey("weapon_smg")] = "weapon_smg",
    [GetHashKey("weapon_machinepistol")] = "weapon_machinepistol",
    [GetHashKey("weapon_minismg")] = "weapon_minismg",
    [GetHashKey("weapon_tecpistol")] = "weapon_tecpistol",
    [GetHashKey("weapon_pumpshotgun")] = "weapon_pumpshotgun",
    [GetHashKey("weapon_assaultrifle")] = "weapon_assaultrifle",
    [GetHashKey("weapon_assaultrifle_mk2")] = "weapon_assaultrifle_mk2",
    [GetHashKey("weapon_carbinerifle")] = "weapon_carbinerifle",
    [GetHashKey("weapon_compactrifle")] = "weapon_compactrifle",
    [GetHashKey("weapon_sniperrifle")] = "weapon_sniperrifle"
}

local notificationCooldown = false -- Variable para controlar el cooldown de la notificación

-- Detectar cuando el jugador intenta usar un arma
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)

        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)
        local weaponName = weapons[weaponHash]

        if weaponName then
            -- Enviar la petición al servidor para verificar el playtime
            ESX.TriggerServerCallback('time_weapon:canUseWeapon', function(canUse)
                if not canUse then
                    -- Usar ox_inventory:disarm para desarmar al jugador
                    TriggerEvent('ox_inventory:disarm', false)

                    -- Mostrar la notificación solo si no está en cooldown
                    if not notificationCooldown then
                        ESX.ShowNotification("Eres nuevo, el tiempo mínimo para usar un arma son 2 horas", 'error')
                        notificationCooldown = true

                        -- Establecer un cooldown de 30 segundos
                        Citizen.SetTimeout(5000, function()
                            notificationCooldown = false
                        end)
                    end
                end
            end, weaponName)
        end
    end
end)
