if onServer() then
    local entity = Entity()
    if entity.allianceOwned or entity.playerOwned then
        entity:addScriptOnce("data/scripts/entity/detectrespawningasteroids.lua")
    end
end
