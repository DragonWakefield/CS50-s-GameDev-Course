--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(ply, pot, dungeon)
    self.dir = ply
    self.pot = pot
    self.dungeon = dungeon
    self.pot.y = self.pot.y + 13
    self.fly = true
    self.maxRight = pot.x + 64
    self.maxLeft = pot.x - 64
    self.maxUp = pot.y - 64
    self.maxDown = pot.y + 64

    self.pot_hitbox = Hitbox(self.pot.x, self.pot.y, 16,16)


end

function Projectile:update(dt)
    
    local x = self.pot.x
    local y = self.pot.y

    if self.dir == 'right' and self.fly then

        self.pot.x = x+ 100 *dt

        if self.pot.x >= self.maxRight then
            self.pot.state = 'broken'
            self.fly = false
        --elseif self.pot.x >= VIRTUAL_WIDTH then
           -- self.pot.state = 'broken'
           -- self.fly = false
        end 

    elseif self.dir == 'left' and self.fly then

        self.pot.x = x - 100 *dt

        if self.pot.x <= self.maxLeft then
            self.pot.state = 'broken'
            self.fly = false
       -- elseif self.pot.x <= 1 then
        --    self.pot.state = 'broken'
        --    self.fly = false
        end 

    elseif self.dir == 'down' and self.fly then

        self.pot.y = y+ 100*dt

        if self.pot.y >= self.maxDown then
            self.pot.state = 'broken'
            self.fly = false
        elseif self.pot.y >= VIRTUAL_HEIGHT then
            self.pot.state = 'broken'
            self.fly = false
        end 

    elseif self.dir == 'up'  and self.fly then

        self.pot.y = y - 100*dt

        if self.pot.y <= self.maxUp then
            self.pot.state = 'broken'
            self.fly = false
        elseif self.pot.y <= 1 then
            self.pot.state = 'broken'
            self.fly = false
        end 

    end

    self:checkWallCollisions()
    for k, entity in pairs(self.dungeon.currentRoom.entities) do
        if entity:collides(self.pot) and self.pot.state ~= 'broken' then
            entity:damage(1)
            --gSounds['hit-enemy']:play()
            self.fly = false
            self.pot.state= 'broken'
            if entity.health == 0 then
                gSounds['hit-enemy']:stop()
                gSounds['hit-enemy']:play()
            end 
            self.pot_hitbox = nil

        end
    end

end

function Projectile:checkWallCollisions()
    local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
            + MAP_RENDER_OFFSET_Y - TILE_SIZE

    if self.pot.x < MAP_RENDER_OFFSET_X + TILE_SIZE or self.pot.x > VIRTUAL_WIDTH - TILE_SIZE * 2 - self.pot.width
        or self.pot.y < MAP_RENDER_OFFSET_Y + TILE_SIZE - self.pot.height / 2 or  self.pot.y > bottomEdge - self.pot.height then
            self.pot.state = 'broken'
            self.fly = false
    end
    return false
end


function Projectile:render()

end