--[[
    GD50
    Match-3 Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    State in which we can actually play, moving around a grid cursor that
    can swap two tiles; when two tiles make a legal swap (a swap that results
    in a valid match), perform the swap and destroy all matched tiles, adding
    their values to the player's point score. The player can continue playing
    until they exceed the number of points needed to get to the next level
    or until the time runs out, at which point they are brought back to the
    main menu or the score entry menu if they made the top 10.
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    
    -- start our transition alpha at full, so we fade in
    self.transitionAlpha = 255

    -- position in the grid which we're highlighting
    self.boardHighlightX = 0
    self.boardHighlightY = 0

    -- timer used to switch the highlight rect's color
    self.rectHighlighted = false

    -- flag to show whether we're able to process input (not swapping or clearing)
    self.canInput = true

    -- tile we're currently highlighting (preparing to swap)
    self.highlightedTile = nil

    self.score = 0
    self.timer = 60

    -- set our Timer class to turn cursor highlight on and off
    Timer.every(0.5, function()
        self.rectHighlighted = not self.rectHighlighted
    end)

    -- subtract 1 from timer every second
    Timer.every(1, function()
        self.timer = self.timer - 1

        -- play warning sound on timer if we get low
        if self.timer <= 5 then
            gSounds['clock']:play()
        end
    end)
end

function PlayState:enter(params)
    
    -- grab level # from the params we're passed
    self.level = params.level

    -- spawn a board and place it toward the right
    self.board = params.board or Board(VIRTUAL_WIDTH - 272, 16)

    -- grab score from params if it was passed
    self.score = params.score or 0

    -- score we have to reach to get to the next level
    self.scoreGoal = self.level * 1.25 * 1000 + (self.score)
end

function PlayState:update(dt)
  
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end



    -- go back to start if time runs out
    if self.timer <= 0 then
        
        -- clear timers from prior PlayStates
        Timer.clear()
        
        gSounds['game-over']:play()

        gStateMachine:change('game-over', {
            score = self.score
        })
    end
    
    -- go to next level if we surpass score goal
    if self.score >= self.scoreGoal then
        
        -- clear timers from prior PlayStates
        -- always clear before you change state, else next state's timers
        -- will also clear!
        Timer.clear()
        level = level + 1
        gSounds['next-level']:play()

        -- change to begin game state with new level (incremented)
        gStateMachine:change('begin-game', {
            level = self.level + 1,
            score = self.score
        })
    end

    if self.canInput then
        -- move cursor around based on bounds of grid, playing sounds
        if love.keyboard.wasPressed('up') then
            self.boardHighlightY = math.max(0, self.boardHighlightY - 1)
            gSounds['select']:play()
        elseif love.keyboard.wasPressed('down') then
            self.boardHighlightY = math.min(7, self.boardHighlightY + 1)
            gSounds['select']:play()
        elseif love.keyboard.wasPressed('left') then
            self.boardHighlightX = math.max(0, self.boardHighlightX - 1)
            gSounds['select']:play()
        elseif love.keyboard.wasPressed('right') then
            self.boardHighlightX = math.min(7, self.boardHighlightX + 1)
            gSounds['select']:play()
        end

        -- if we've pressed enter, to select or deselect a tile...
        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            
            -- if same tile as currently highlighted, deselect
            local x = self.boardHighlightX + 1
            local y = self.boardHighlightY + 1
            
            -- if nothing is highlighted, highlight current tile
            if not self.highlightedTile then
                self.highlightedTile = self.board.tiles[y][x]

            -- if we select the position already highlighted, remove highlight
            elseif self.highlightedTile == self.board.tiles[y][x] then
                self.highlightedTile = nil

            -- if the difference between X and Y combined of this highlighted tile
            -- vs the previous is not equal to 1, also remove highlight
            elseif math.abs(self.highlightedTile.gridX - x) + math.abs(self.highlightedTile.gridY - y) > 1 then
                gSounds['error']:play()
                self.highlightedTile = nil
            else
                
                -- swap grid positions of tiles
                local tempX = self.highlightedTile.gridX
                local tempY = self.highlightedTile.gridY

                newTile = self.board.tiles[y][x]

                self.highlightedTile.gridX = newTile.gridX
                self.highlightedTile.gridY = newTile.gridY
                newTile.gridX = tempX
                newTile.gridY = tempY

                -- swap tiles in the tiles table
                self.board.tiles[self.highlightedTile.gridY][self.highlightedTile.gridX] =
                    self.highlightedTile

                self.board.tiles[newTile.gridY][newTile.gridX] = newTile

                -- tween coordinates between the two so they swap
                Timer.tween(0.1, {
                    [self.highlightedTile] = {x = newTile.x, y = newTile.y},
                    [newTile] = {x = self.highlightedTile.x, y = self.highlightedTile.y}
                })
                
                -- once the swap is finished, we can tween falling blocks as needed
                :finish(function()
                    self:calculateMatches()
                end)
            end
        end
    end

    Timer.update(dt)
end

--[[
    Calculates whether any matches were found on the board and tweens the needed
    tiles to their new destinations if so. Also removes tiles from the board that
    have matched and replaces them with new randomized tiles, deferring most of this
    to the Board class.
]]
function PlayState:calculateMatches()
    local swap_tile = self.highlightedTile
    self.highlightedTile = nil

    -- if we have any matches, remove them and tween the falling blocks that result
    local matches = self.board:calculateMatches()
    
    if matches then
        gSounds['match']:stop()
        gSounds['match']:play()
        local shine = nil
        -- add score for each match
        for k, match in pairs(matches) do
            local tile_counter = 0
            local tile_save = 0
            local hor_counter = 0
            hori = false
            vert = false
            local vert_counter = 0
            -- setting different scores for different varieties of tiles
            for x, tile in pairs(match) do

                if tile:getShiny() then
                    shine = tile
                    
                end 

                if tile:getTraits(2) == 1 or tile:getTraits(2) == 6 then
                    self.score = self.score + 50
                elseif tile:getTraits(2) == 2 then
                    self.score = self.score + 55
                elseif tile:getTraits(2) == 3 then
                    self.score = self.score + 65
                elseif tile:getTraits(2) == 4 then
                    self.score = self.score + 75
                elseif tile:getTraits(2) == 5 then
                    self.score = self.score + 90
                end 

                if hor_counter == tile.gridX then
                    vert = true
                elseif vert_counter == tile.gridY then
                    hori = true
                else
                    hor_counter = tile.gridX
                    vert_counter = tile.gridY
                end

                --keeps track of the variety of the tiles, if multiple of the same tiles, bonus points
                if tile:getTraits(2) == tile_save then
                    tile_counter = tile_counter + 1
                else
                    tile_save = 0
                end
                -- Bonus points for multiple of the same variety
                if tile_counter >= 3 then
                    self.score = self.score + 100 * #tile_counter
                end
            end 
            self.timer = self.timer + #match -- Added Line to increase time by number of tiles per match
        end

        if shine ~= nil then
            local x = shine.gridX
            local z = shine.gridY
            for y =1, 8,1 do
                if vert then
                    self.board.tiles[y][x] = nil
                elseif hori then
                    self.board.tiles[z][y] = nil
                end
            end
            self.score = self.score + 750
        end
        -- remove any tiles that matched from the board, making empty spaces
        self.board:removeMatches()

        -- gets a table with tween values for tiles that should now fall
        local tilesToFall = self.board:getFallingTiles()

        -- tween new tiles that spawn from the ceiling over 0.25s to fill in
        -- the new upper gaps that exist
        Timer.tween(0.25, tilesToFall):finish(function()
            
            -- recursively call function in case new matches have been created
            -- as a result of falling blocks once new blocks have finished falling
            self:calculateMatches()
        end)
    
    -- if no matches, we can continue playing
    -- also tween the tiles back to their original positions
    else
        self.canInput = true
        if swap_tile ~= nil then
            local tempX = newTile.gridX
            local tempY = newTile.gridY


            newTile.gridX = swap_tile.gridX
            newTile.gridY = swap_tile.gridY
            swap_tile.gridX = tempX
            swap_tile.gridY = tempY

            -- swap tiles in the tiles table
            self.board.tiles[swap_tile.gridY][swap_tile.gridX] = swap_tile

            self.board.tiles[newTile.gridY][newTile.gridX] = newTile

            -- tween coordinates between the two so they swap
            Timer.tween(0.5, {
                [swap_tile] = {x = newTile.x, y = newTile.y},
                [newTile] = {x = swap_tile.x, y = swap_tile.y}
            })
        end 
            -- check if the board has any matches
        local match_finder = self.board:isMatches()
        if not match_finder then
            gSounds['next-level']:play()
            self.board = Board(VIRTUAL_WIDTH-272, 16)
        end

    end
end



function PlayState:render()
    -- render board of tiles
    self.board:render()

    -- render highlighted tile if it exists
    if self.highlightedTile then
        
        -- multiply so drawing white rect makes it brighter
        love.graphics.setBlendMode('add')

        love.graphics.setColor(255, 255, 255, 96)
        love.graphics.rectangle('fill', (self.highlightedTile.gridX - 1) * 32 + (VIRTUAL_WIDTH - 272),
            (self.highlightedTile.gridY - 1) * 32 + 16, 32, 32, 4)

        -- back to alpha
        love.graphics.setBlendMode('alpha')
    end

    -- render highlight rect color based on timer
    if self.rectHighlighted then
        love.graphics.setColor(217, 87, 99, 255)
    else
        love.graphics.setColor(172, 50, 50, 255)
    end

    -- draw actual cursor rect
    love.graphics.setLineWidth(4)
    love.graphics.rectangle('line', self.boardHighlightX * 32 + (VIRTUAL_WIDTH - 272),
        self.boardHighlightY * 32 + 16, 32, 32, 4)

    -- GUI text
    love.graphics.setColor(56, 56, 56, 234)
    love.graphics.rectangle('fill', 16, 16, 186, 116, 4)

    love.graphics.setColor(99, 155, 255, 255)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Level: ' .. tostring(self.level), 20, 24, 182, 'center')
    love.graphics.printf('Score: ' .. tostring(self.score), 20, 52, 182, 'center')
    love.graphics.printf('Goal : ' .. tostring(self.scoreGoal), 20, 80, 182, 'center')
    love.graphics.printf('Timer: ' .. tostring(self.timer), 20, 108, 182, 'center')
end