/*

__________        __           __________                                .___      
\______   \ _____/  |______    \______   \ ______  _  _______ _______  __| _/______
 |    |  _// __ \   __\__  \    |       _// __ \ \/ \/ /\__  \\_  __ \/ __ |/  ___/
 |    |   \  ___/|  |  / __ \_  |    |   \  ___/\     /  / __ \|  | \/ /_/ |\___ \ 
 |______  /\___  >__| (____  /  |____|_  /\___  >\/\_/  (____  /__|  \____ /____  >
        \/     \/          \/          \/     \/             \/           \/    \/ 

By Maurice*/

print("BetaRewards >> Loading")
  
local SupportedLangs = { "fr", "en" }

if SERVER then
        Beta_Rewards = Beta_Rewards or {}
        Beta_Rewards.Config = Beta_Rewards.Config or {}

        print("BetaRewards >> Loading serverside...")

        include("betarewards/sh_config.lua")
        AddCSLuaFile("betarewards/sh_config.lua")

        if table.HasValue(SupportedLangs, Beta_Rewards.Config.Lang) then
                include("betarewards/lang/" .. Beta_Rewards.Config.Lang .. ".lua")
                AddCSLuaFile("betarewards/lang/" .. Beta_Rewards.Config.Lang .. ".lua")
        else
                print("BetaRewards >> WARNING : An error occured while charging lang. Please check that you have written a supported language!\nCharging english language...")
                include("betarewards/lang/en.lua")
                AddCSLuaFile("betarewards/lang/en.lua")
        end

        AddCSLuaFile("betarewards/core/rewards.lua")

        if Beta_Rewards.Config.UseMySQLOO then
                include("betarewards/sv_sqlconfig.lua")
                include("betarewards/data/mysqloo.lua")
        else
                include("betarewards/data/sqlite.lua")
        end

        include("betarewards/core/rewards.lua")
        AddCSLuaFile("betarewards/core/rewards.lua")

        print("BetaRewards >> Serverside loaded!")
end

if CLIENT then
        Beta_Rewards = Beta_Rewards or {}
        Beta_Rewards.Config = Beta_Rewards.Config or {}

        print("BetaRewards >> Loading clientside...")

        include("betarewards/sh_config.lua")
        
         if table.HasValue(SupportedLangs, Beta_Rewards.Config.Lang) then
                include("betarewards/lang/" .. Beta_Rewards.Config.Lang .. ".lua")
        else
                print("BetaRewards >> WARNING : An error occured while charging lang. Please check that you have written a supported language!\nCharging english language...")
                include("betarewards/lang/en.lua")
        end

        include("betarewards/core/rewards.lua")

        print("BetaRewards >> Clientside loaded!")

end

print("BetaRewards >> Successfully loaded!")
