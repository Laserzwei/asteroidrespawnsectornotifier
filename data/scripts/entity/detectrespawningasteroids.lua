package.path = package.path .. ";data/scripts/lib/?.lua"
include("callable")

-- Don't remove or alter the following comment, it tells the game the namespace this script lives in. If you remove it, the script will break.
-- namespace DetectrespawnAsteroids
DetectrespawnAsteroids = {}

function DetectrespawnAsteroids.initialize()
    if onServer() then
        Entity():registerCallback("onSectorEntered", "onSectorEntered")
    else
        invokeServerFunction("onSectorEntered")
    end
end

function DetectrespawnAsteroids.onSectorEntered()
    local sector = Sector()
    if sector:hasScript("data/scripts/sector/background/respawnresourceasteroids.lua") and #{sector:getEntitiesByType(EntityType.Asteroid)} > 0 then
        broadcastInvokeClientFunction("isRespawning")
    else
        broadcastInvokeClientFunction("isNotRespawning")
    end
end
callable(DetectrespawnAsteroids, "onSectorEntered")

function DetectrespawnAsteroids.isRespawning()
    removeShipProblem("no respawning asteroids", Entity().id)
    addShipProblem("respawning asteroids", Entity().id, "Asteroids respawn in this Sector"%_t, "data/textures/icons/diamond.png", ColorRGB(1.0, 1.0, 1.0))
end

function DetectrespawnAsteroids.isNotRespawning()
    removeShipProblem("respawning asteroids", Entity().id)
    --addShipProblem("no respawning asteroids", Entity().id, "Asteroids do not respawn in this Sector"%_t, "data/textures/icons/diamond.png", ColorRGB(1.0, 0.2, 0.2))
end

