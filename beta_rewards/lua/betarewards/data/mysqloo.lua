require("mysqloo") -- Ignorez cette ligne

local mysqlDB

if Beta_Rewards.Config.UseMySQLOO then
    local success, err = pcall(function()
        require("mysqloo")
    end)

    if not success then return print("BetaRewards >> Une erreur est survenue avec MySQLOO") end
    if not mysqloo then return print("BetaRewards >> Impossible de trouver MySQLOO :\n" .. requireError) end

    mysqlDB = mysqloo.connect(Beta_Rewards.MySQLOOConfig["host"], Beta_Rewards.MySQLOOConfig["username"], Beta_Rewards.MySQLOOConfig["password"], Beta_Rewards.MySQLOOConfig["database"], {
        ["port"] = Beta_Rewards.MySQLOOConfig["port"]
    })

    function mysqlDB:onConnected()
        print("BetaRewards >> Connexion avec la base de données établie avec succès !")
        BRWDB = true
    end

    function mysqlDB:onConnectionFailed(connectionError)
        print("BetaRewards >> Impossible de se connecter à la BDD externe :\n" .. connectionError)
    end

    mysqlDB:connect()
end

function CreateTable()
    local querycreate = databaseObject:query("CREATE TABLE IF NOT EXISTS betatesters(id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,sid VARCHAR(60),nick VARCHAR(255),recomp INT);")

    querycreate.onSuccess = function(q)
        print("BetaRewards >> Base de données initialisée !")
    end

    querycreate.onError = function(q, e)
        print("BetaRewards >> Une erreur est survenue : " .. e .. ".")
    end

    querycreate:start()
end

CreateTable()

function FirstJoinMySQLOO(ply)
    local query1 = databaseObject:query("SELECT * FROM betatesters WHERE sid = '" .. ply:SteamID() .. "'")

    query1.onSuccess = function(q)
        if not checkQuery(q) and not Beta_Rewards.Config.RedeemMode then
            local query2 = databaseObject:query("INSERT INTO betatesters(sid, nick, recomp) VALUES ('" .. ply:SteamID() .. "', '" .. ply:Nick() .. "', 0)")

            query2.onSuccess = function(q)
                print("BetaRewards >> Enregistrement du joueur effectué avec succès !")
            end

            query2.onError = function(q, e)
                print("BetaRewards >> Une erreur est survenue pendant l'enregistrement :\n" .. e)
            end

            query2:start()
        else
            if not Beta_Rewards.Config.RedeemMode then
                print("BetaRewards >> Joueur déjà enregistré sur la base de données")
            else
                RewardPlayer(ply)
            end
        end
    end

    query1.onError = function(q, e)
        print("BetaRewards >> Une erreur est survenue pendant la vérification du joueur dans la base :\n" .. e)
    end

    query1:start()
end


hook.Add( "PlayerInitialSpawn", "BetaRewardsSQLOOInit", FirstJoinMySQLOO )