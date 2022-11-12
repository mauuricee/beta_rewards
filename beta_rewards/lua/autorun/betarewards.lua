/*

__________        __           __________                                .___      
\______   \ _____/  |______    \______   \ ______  _  _______ _______  __| _/______
 |    |  _// __ \   __\__  \    |       _// __ \ \/ \/ /\__  \\_  __ \/ __ |/  ___/
 |    |   \  ___/|  |  / __ \_  |    |   \  ___/\     /  / __ \|  | \/ /_/ |\___ \ 
 |______  /\___  >__| (____  /  |____|_  /\___  >\/\_/  (____  /__|  \____ /____  >
        \/     \/          \/          \/     \/             \/           \/    \/ 

By Maurice*/

print("BetaRewards >> Chargement")

if SERVER then
        Beta_Rewards = Beta_Rewards or {}
        Beta_Rewards.Config = Beta_Rewards.Config or {}

        AddCSLuaFile("betarewards/sh_config.lua")
        AddCSLuaFile("betarewards/core/rewards.lua")

        include("betarewards/sh_config.lua")
        if Beta_Rewards.Config.UseMySQLOO then
                include("betarewards/sv_sqlconfig.lua")
                include("betarewards/data/mysqloo.lua")
        else
                include("betarewards/data/sqlite.lua")
        end

        include("betarewards/sh_config.lua")
        include("betarewards/core/rewards.lua")
        
        AddCSLuaFile("betarewards/sh_config.lua")
        AddCSLuaFile("betarewards/core/rewards.lua")
end

if CLIENT then
        Beta_Rewards = Beta_Rewards or {}
        Beta_Rewards.Config = Beta_Rewards.Config or {}

        include("betarewards/sh_config.lua")
        include("betarewards/core/rewards.lua")
end

print("BetaRewards >> Chargement terminé")