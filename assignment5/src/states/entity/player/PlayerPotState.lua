PlayerPotState = Class{__includes = BaseState}

function PlayerPotState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite
    self.player.offsetY = 5
    self.player.offsetX = 0

    -- create hitbox based on where the player is and facing
    local direction = self.player.direction


   
    self.player:changeAnimation('potup-' .. self.player.direction)
    self.player.pot_walk = true
end

function PlayerPotState:enter(params)
    gSounds['sword']:stop()
    gSounds['sword']:play()

   self.player.currentAnimation:refresh()
end

function PlayerPotState:update(dt)


    if self.player.currentAnimation.timesPlayed > 0 then
        self.player.currentAnimation.timesPlayed = 0
        self.player:changeState('pot-walk')
    end

    if love.keyboard.wasPressed('e') and self.player.pot_hold then
        --self.player:changeState('pot-throw') 
    elseif love.keyboard.wasPressed('space') then
        self.player:changeState('swing-sword')
    elseif love.keyboard.wasPressed('r') and self.player.pot_hold then
        -- gSounds['sword']:stop()
         --gSounds['sword']:play()
         self.entity.pot.state = 'picked'
         self.thrown = Projectile(self.entity.direction, self.entity.pot)
         
         self.entity.pot.update = function () 
  
 
             self.thrown:update(dt)
             
 
         end 
         self.entity.pot = 0
         self.entity.pot_hold = false
         self.entity:changeState('idle')
         --self.thrown = Projectile(self.entity, self.entity.pot)
     
    end
     
  
end

function PlayerPotState:render()
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