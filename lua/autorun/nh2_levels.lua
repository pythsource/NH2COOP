
local tohide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true                       
}  

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
    if (game.GetMap() == "nh2c1_v2") then
        if ( tohide[ name ] ) then
            return false
        end
    end

    -- Don't return anything here, it may break other addons that rely on this hook.
end )

