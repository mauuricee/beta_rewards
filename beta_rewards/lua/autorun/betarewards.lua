/*

__________        __           __________                                .___      
\______   \ _____/  |______    \______   \ ______  _  _______ _______  __| _/______
 |    |  _// __ \   __\__  \    |       _// __ \ \/ \/ /\__  \\_  __ \/ __ |/  ___/
 |    |   \  ___/|  |  / __ \_  |    |   \  ___/\     /  / __ \|  | \/ /_/ |\___ \ 
 |______  /\___  >__| (____  /  |____|_  /\___  >\/\_/  (____  /__|  \____ /____  >
        \/     \/          \/          \/     \/             \/           \/    \/ 

By Maurice*/

print("BetaRewards >> Loading")

if SERVER then
        Beta_Rewards = Beta_Rewards or {}

        AddCSLuaFile("betarewards/sh_config.lua")

        if Beta_Rewards.Config.lang == "fr" then
                include("betarewards/lang/fr.lua")
                AddCSLuaFile("betarewards/lang/fr.lua")
        elseif Beta_Rewards.Config.lang == "en" then
                include("betarewards/lang/en.lua")
                AddCSLuaFile("betarewards/lang/en.lua")
        else
                print("BetaRewards >> WARNING : An error occured while charging lang. Please check that you have written a supported language!")
        end

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

        include("betarewards/sh_config.lua")
        
        if Beta_Rewards.Config.lang == "fr" then
                include("betarewards/lang/fr.lua")
        elseif Beta_Rewards.Config.lang == "en" then
                include("betarewards/lang/en.lua")
        else
                return
        end

        include("betarewards/core/rewards.lua")

end

print("BetaRewards >> Successfully loaded!")