if not SERVER then return end

if not sql.TableExists("betatesters") then
    print(sql.Query("CREATE TABLE IF NOT EXISTS betatesters (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, sid VARCHAR(60), nick VARCHAR(255), recomp INT );"))
    print("BetaRewards >> " .. Beta_Rewards.lang["DBInit"] )
else
    print("BetaRewards >> " .. Beta_Rewards.lang["DBInit"] )
end   


function FirstJoinSQLITE(ply)
    local qdata = sql.QueryRow("SELECT * FROM betatesters WHERE sid = '" .. ply:SteamID() .. "'")

    if qdata == false then
        print("BetaRewards >> " .. Beta_Rewards.lang["DBError"] .. sql.LastError() )
    elseif qdata == nil and !Beta_Rewards.Config.RedeemMode then
        sql.Query("INSERT INTO betatesters(sid, nick, recomp) VALUES ('" .. ply:SteamID() .. "', '" .. ply:Nick() .. "', 0)")
        print("BetaRewards >> " .. Beta_Rewards.lang["PlyReg"] )
    else
        local state = qdata[4]
        if !Beta_Rewards.Config.RedeemMode then
            print("BetaRewards >> " .. Beta_Rewards.lang["PlyAlreadyReg"] )
        else
            if state == 0 then
                RewardPlayer(ply)
            else
                return
            end
        end
    end
end

hook.Add( "PlayerInitialSpawn", "BetaRewardsSQLITEInit", FirstJoinSQLITE )
