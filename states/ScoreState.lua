--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        SCROLLING = true
        gStateMachine:change('countdown')
    end
end

function getImageScaleForNewDimensions( image, newWidth, newHeight ) --Function for scaling an image down to a desired dimension
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.score <= 3 then
        self.image = love.graphics.newImage('bronze.png')
    elseif self.score <= 5 and self.score > 3 then
        self.image = love.graphics.newImage('silver.png')
    else
        self.image = love.graphics.newImage('Nobel_medal.png')
    end
    
    local scaleX, scaleY = getImageScaleForNewDimensions(self.image, 120,60)
    love.graphics.draw(self.image, VIRTUAL_WIDTH/2.5, 120, 0, scaleX, scaleY)

    love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
end