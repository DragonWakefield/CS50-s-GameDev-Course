

PlayerThrowState = Class{__includes = BaseState}

function PlayerThrowState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 8

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction
    
    self.thrown = Projectile(direction, self.player.pot)
    
end

function PlayerThrowState:enter(params)
    --gSounds['sword']:stop()
    --gSounds['sword']:play()


end

function PlayerThrowState:update(dt)
    -- check if hitbox collides with any entities in the scene
    --for k, entity in pairs(self.dungeon.currentRoom.entities) do
        --if entity:collides(self.thrown) then
           -- entity:damage(1)
           -- gSounds['hit-enemy']:play()
       -- end
    --end
    self.player:changeState('idle')


    if love.keyboard.wasPressed('space') and self.player.pot_hold == false then
        self.player:changeState('swing-sword')
    elseif love.keyboard.wasPressed('e') and self.player.pot_touch  then
        self.player:changeState('potup')
    end
end

function PlayerThrowState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    -- debug for player and hurtbox collision rects
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end