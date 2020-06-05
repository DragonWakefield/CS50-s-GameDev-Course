--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety)
    
    -- board positions
    self.gridX = x
    self.gridY = y
    
    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety
    self.shiny = false
    self.switch = false

    local randnum = math.random(100)

    if randnum <= (10+variety) then
        self.shiny = true
    end


    Timer.every(0.75, function()
        if not self.switch then
            self.switch = true
        else 
            self.switch = false
        end
    end 
    )
end


function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34, 32, 52, 255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    if not self.shiny then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
            self.x + x, self.y + y)
    else

        if self.switch == true then
            love.graphics.setColor(255, 215, 0, 255)
        else
            love.graphics.setColor(255,255,255,255)
        end
        love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
            self.x + x, self.y + y)
    end 
end




function Tile:getShiny()
 
    return self.shiny

end
function Tile:getTraits(num)
    if num == 1 then
        return self.color
    elseif num == 2 then
        return self.variety
    end 
end 