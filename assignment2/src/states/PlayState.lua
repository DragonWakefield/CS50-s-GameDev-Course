--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    
    self.key = false

    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.balls = {params.ball}
    self.level = params.level

    self.powerups = {}

    self.recoverPoints = 5000
    self.sCounter = 0

    -- give ball random starting velocity
    self.balls[1].dx = math.random(-200, 200)
    self.balls[1].dy = math.random(-50, -60)
end

function PlayState:update(dt)



    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    -- update positions based on velocity
    self.paddle:update(dt)


    for k, ball in pairs(self.balls) do
        ball:update(dt)
    end

    for k, powerup in pairs(self.powerups) do
        powerup:update(dt)
    end 

    for k, ball in pairs(self.balls) do 
        if ball:collides(self.paddle) then
            -- raise ball above paddle in case it goes below it, then reverse dy
            ball.y = self.paddle.y - 8
            ball.dy = -ball.dy

            --
            -- tweak angle of bounce based on where it hits the paddle
            --

            -- if we hit the paddle on its left side while moving left...
            if ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - ball.x))
            
            -- else if we hit the paddle on its right side while moving right...
            elseif ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - ball.x))
            end

            gSounds['paddle-hit']:play()
        end
    end
        -- detect collision across all bricks with the ball
        for k, brick in pairs(self.bricks) do
            for bk, ball in pairs(self.balls) do
                -- only check collision if we're in play
                if brick.inPlay and ball:collides(brick)then
                    -- creates Powerup
                    local powerup = nil
                    local rng = math.random( 1,10 )
                    
                    if rng == 3 then 
                        powerup = Powerup(brick)
                    end
                    

                    if powerup ~= nil then

                        table.insert(self.powerups, powerup)
                    end

                    if brick.locked == true then
                        if self.key == true then
                            self.key = false
                            brick:hit()
                            
                        end
                    elseif brick.locked == false then
                        brick:hit()
                        -- add to score
                    
                        self.score = self.score + (brick.tier * 200 + brick.color * 25)
                        self.sCounter = self.sCounter + (brick.tier * 200 + brick.color * 25)
                    end
  
                    if self.sCounter > self.recoverPoints then
                        
                        if self.paddle.size < 4 then
                            self.paddle.size = self.paddle.size + 1
                        end 
                        self.sCounter = 0
                    end


                    -- if we have enough points, recover a point of health
                    if self.score > self.recoverPoints then

        
                        -- can't go above 3 health
                        self.health = math.min(3, self.health + 1)

                        -- multiply recover points by 2
                        self.recoverPoints = math.min(100000, self.recoverPoints * 2)

                        -- play recover sound effect
                        gSounds['recover']:play()
                    end

                    -- go to our victory screen if there are no more bricks left
                    if self:checkVictory() then
                        gSounds['victory']:play()

                        gStateMachine:change('victory', {
                            level = self.level,
                            paddle = self.paddle,
                            health = self.health,
                            score = self.score,
                            highScores = self.highScores,
                            ball = ball,
                            recoverPoints = self.recoverPoints
                        })
                    end

                    --
                    -- collision code for bricks
                    --
                    -- we check to see if the opposite side of our velocity is outside of the brick;
                    -- if it is, we trigger a collision on that side. else we're within the X + width of
                    -- the brick and should check to see if the top or bottom edge is outside of the brick,
                    -- colliding on the top or bottom accordingly 
                    --

                    -- left edge; only check if we're moving right, and offset the check by a couple of pixels
                    -- so that flush corner hits register as Y flips, not X flips
                    if ball.x + 2 < brick.x and ball.dx > 0 then
                        
                        -- flip x velocity and reset position outside of brick
                        ball.dx = -ball.dx
                        ball.x = brick.x - 8
                    
                    -- right edge; only check if we're moving left, , and offset the check by a couple of pixels
                    -- so that flush corner hits register as Y flips, not X flips
                    elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
                        
                        -- flip x velocity and reset position outside of brick
                        ball.dx = -ball.dx
                        ball.x = brick.x + 32
                    
                    -- top edge if no X collisions, always check
                    elseif ball.y < brick.y then
                        
                        -- flip y velocity and reset position outside of brick
                        ball.dy = -ball.dy
                        ball.y = brick.y - 8
                    
                    -- bottom edge if no X collisions or top collision, last possibility
                    else
                        
                        -- flip y velocity and reset position outside of brick
                        ball.dy = -ball.dy
                        ball.y = brick.y + 16
                    end

                    -- slightly scale the y velocity to speed up the game, capping at +- 150
                    if math.abs(ball.dy) < 150 then
                        ball.dy = ball.dy * 1.02
                    end

                    -- only allow colliding with one brick, for corners
                    break
                end
            end
        end

        --powerup collision
        for k, powerup in pairs(self.powerups) do
            if powerup:collides(self.paddle)then 
                gSounds['confirm']:play()

                --if key
                if #self.balls < 15 then
                    -- if the skin is the 9th sprite image, then it will create 3 balls, otherwise, just 1 ball
                    if powerup.skin == 9 then
                        for i = 0,2 do
                            local newBall = Ball()
                            newBall.skin = math.random(7)
                            newBall.x = self.paddle.x + self.paddle.width / 2 - newBall.width /2 
                            newBall.y = self.paddle.y - newBall.height
                            newBall.dx = math.random(-200, 200)
                            newBall.dy = math.random(-50,-60)
                            table.insert(self.balls, newBall)
                        end
                    elseif powerup.skin == 10 then -- allows to open locked bricks
                        self.key = true
                    elseif powerup.skin == 4 then --creates 5 balls or decreases size of paddle
                        rng2 = math.random( 1,2 )
                        if rng2 == 1 then
                            if self.paddle.size > 1 then
                                self.paddle.size = self.paddle.size - 1
                            end 
                        else

                            for i = 0,4 do
                                local newBall = Ball()
                                newBall.skin = math.random(7)
                                newBall.x = self.paddle.x + self.paddle.width / 2 - newBall.width /2 
                                newBall.y = self.paddle.y - newBall.height
                                newBall.dx = math.random(-200, 200)
                                newBall.dy = math.random(-50,-60)
                                table.insert(self.balls, newBall)
                            end 
                        end
                    elseif powerup.skin == 1 then
                        for i = 0,#self.balls do -- creates a number of balls equal to the number of balls currently in play
                            local newBall = Ball()
                            newBall.skin = math.random(7)
                            newBall.x = self.paddle.x + self.paddle.width / 2 - newBall.width /2 
                            newBall.y = self.paddle.y - newBall.height
                            newBall.dx = math.random(-200, 200)
                            newBall.dy = math.random(-50,-60)
                            table.insert(self.balls, newBall)
                        end
                    elseif powerup.skin == 6 then
                        if self.paddle.size > 1 then
                            self.paddle.size = self.paddle.size - 1
                        end 
                    else
                        local newBall = Ball()
                        newBall.skin = math.random(7)
                        newBall.x = self.paddle.x + self.paddle.width / 2 - newBall.width /2 
                        newBall.y = self.paddle.y - newBall.height
                        newBall.dx = math.random(-200, 200)
                        newBall.dy = math.random(-50,-60)
                        table.insert(self.balls, newBall)
                    end
                end 
                powerup.inPlay = false
            end
        end

        for k, powerup in pairs(self.powerups) do
            if not powerup.inPlay or powerup.y >= VIRTUAL_HEIGHT then
                table.remove(self.powerups, k)
            end
        end

        for k, ball in pairs(self.balls) do 
            if ball.y >= VIRTUAL_HEIGHT then
                table.remove(self.balls, k)
            end
        end

        -- if ball goes below bounds, revert to serve state and decrease health
        if #self.balls <= 0 then
            self.health = self.health - 1
            gSounds['hurt']:play()
            if self.paddle.size > 1 then
               self.paddle.size = self.paddle.size - 1
                
            end
            if self.health == 0 then
                gStateMachine:change('game-over', {
                    score = self.score,
                    highScores = self.highScores
                })
            else
                gStateMachine:change('serve', {
                    paddle = self.paddle,
                    bricks = self.bricks,
                    health = self.health,
                    score = self.score,
                    highScores = self.highScores,
                    level = self.level,
                    recoverPoints = self.recoverPoints
                })
            end
        end
 
    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    self.paddle:render()

    for k, ball in pairs(self.balls) do
        ball:render()
    end

    for k, powerup in pairs(self.powerups) do
        powerup:render()
    end

    renderScore(self.score)
    renderHealth(self.health)

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end
