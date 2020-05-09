PauseState = Class{__includes = BaseState}




--function PauseState:init() end
function PauseState:enter(params) 

    self.b1 = params.birb
    self.b1.dy = 0

    self.pipes = params.pipes
    self.timer = params.time
    self.scorer = params.score

    sounds['music']:pause()
    src1= love.audio.newSource("Pause.wav", "static")
    src1:play()
    

end


function PauseState:exit() 
    src1:play()
    sounds['music']:play()
end


function PauseState:update(dt) 
    if love.keyboard.wasPressed('p')then
        gStateMachine:change('play', {time = self.timer, birb = self.b1, score = self.scorer, pipes = self.pipes})
    end
end


function PauseState:render() 
    for k, pair in pairs(self.pipes) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.scorer), 8, 8)
    self.b1:render()
    self.image = love.graphics.newImage('circled-pause.png')
    local scaleX, scaleY = getImageScaleForNewDimensions(self.image, 200,200)
    love.graphics.draw(self.image, VIRTUAL_WIDTH/3, 50, 0, scaleX, scaleY)
    

end

function getImageScaleForNewDimensions( image, newWidth, newHeight ) --Function for scaling an image down to a desired dimension
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end