require("mysqloo") -- Ignore this line

local mysqlDB

local success, err = pcall(function()
    require("mysqloo")
end)

if not success then return print("BetaRewards >> " .. Beta_Rewards.lang["DBError"] ) end
if not mysqloo then return print("BetaRewards >> " .. Beta_Rewards.lang["DBError"] .. "\n" .. requireError ) end

mysqlDB = mysqloo.connect(Beta_Rewards.MySQLOOConfig["host"], Beta_Rewards.MySQLOOConfig["username"], Beta_Rewards.MySQLOOConfig["password"], Beta_Rewards.MySQLOOConfig["database"], {["port"] = Beta_Rewards.MySQLOOConfig["port"]})

function mysqlDB:onConnected()
    print("BetaRewards >> " .. Beta_Rewards.lang["DBConnected"] )
    BRWDB = true
end

function mysqlDB:onConnectionFailed(err)
    print("BetaRewards >> " .. Beta_Rewards.lang["DBError"] .. "\n" .. e)
end

mysqlDB:connect()

function CreateTable()
    local querycreate = mysqlDB:query("CREATE TABLE IF NOT EXISTS betatesters(id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,sid VARCHAR(60),nick VARCHAR(255),recomp INT);")

    querycreate.onSuccess = function()
        print("BetaRewards >> " .. Beta_Rewards.lang["DBInit"] )
    end

    querycreate.onError = function(err)
        print("BetaRewards >> " .. Beta_Rewards.lang["DBError"] .. "\n" .. e )
    end

    querycreate:start()
end

CreateTable()

function FirstJoinMySQLOO(ply)
    if ply:IsBot() then return end
    local query1 = mysqlDB:query("SELECT * FROM betatesters WHERE sid = '" .. ply:SteamID() .. "'")

    query1.onSuccess = function(q)
        if not checkQuery(q) and not Beta_Rewards.Config.RedeemMode then
            local query2 = mysqlDB:query("INSERT INTO betatesters(sid, nick, recomp) VALUES ('" .. ply:SteamID() .. "', '" .. ply:Nick() .. "', 0)")

            query2.onSuccess = function(q)
                print("BetaRewards >> " .. Beta_Rewards.lang["PlyReg"] )
            end

            query2.onError = function(err)
                print("BetaRewards >> " .. Beta_Rewards.lang["DBError"] .. "\n" .. e )
            end

            query2:start()
        else
            if not Beta_Rewards.Config.RedeemMode then
                print("BetaRewards >> " .. Beta_Rewards.lang["PlyAlreadyReg"] )
            else
                RewardPlayer(ply)
            end
        end
    end

    query1.onError = function(err)
        print("BetaRewards >> " .. Beta_Rewards.lang["DBError"] .. "\n" .. e )
    end

    query1:start()
end


hook.Add( "PlayerInitialSpawn", "BetaRewardsSQLOOInit", FirstJoinMySQLOO )
