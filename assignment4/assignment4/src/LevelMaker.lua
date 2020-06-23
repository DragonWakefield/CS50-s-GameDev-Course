--[[
    GD50
    Super Mario Bros. Remake

    -- LevelMaker Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelMaker = Class{}



function LevelMaker.generate(width, height)
    
    local key = false
    local key_placed = false
    local lock_placed = false
    local lock = false
    local key_hold = false
    local flag_down = false

    local tiles = {}
    local entities = {}
    local objects = {}

    local tileID = TILE_ID_GROUND
    
    -- whether we should draw our tiles with toppers
    local topper = true
    local tileset = math.random(20)
    local topperset = math.random(20)

    -- insert blank tables into tiles for later access
    for x = 1, height do
        table.insert(tiles, {})
    end

    -- column by column generation instead of row; sometimes better for platformers
    for x = 1, width do
        local tileID = TILE_ID_EMPTY
        
        -- lay out the empty space
        for y = 1, 6 do
            table.insert(tiles[y],
                Tile(x, y, tileID, nil, tileset, topperset))
        end

        -- chance to just be emptiness
        if math.random(7) == 1 then
            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, nil, tileset, topperset))
            end
        else
            tileID = TILE_ID_GROUND

            local blockHeight = 4

            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end

            -- chance to generate a pillar
            if math.random(8) == 1 then
                blockHeight = 2
                
                -- chance to generate bush on pillar
                if math.random(8) == 1 then
                    table.insert(objects,
                        GameObject {
                            texture = 'bushes',
                            x = (x - 1) * TILE_SIZE,
                            y = (4 - 1) * TILE_SIZE,
                            width = 16,
                            height = 16,
                            
                            -- select random frame from bush_ids whitelist, then random row for variance
                            frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7
                        }
                    )
                end
                
                -- pillar tiles
                tiles[5][x] = Tile(x, 5, tileID, topper, tileset, topperset)
                tiles[6][x] = Tile(x, 6, tileID, nil, tileset, topperset)
                tiles[7][x].topper = nil
            
            -- chance to generate bushes
            elseif math.random(8) == 1 then
                table.insert(objects,
                    GameObject {
                        texture = 'bushes',
                        x = (x - 1) * TILE_SIZE,
                        y = (6 - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,
                        frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                        collidable = false
                    }
                )
            end

           
            local block_type = math.random(3)
            if block_type == 1 and not key_placed then
                if math.random(5) == 1 then
                    if not key then
                        key = true
                        table.insert(objects, 
                        GameObject{texture = 'key', 
                            x = (x-1)*TILE_SIZE, y = (blockHeight-1)* TILE_SIZE, 
                            width = 16, height=16,
                            frame = math.random(4),
                            collidable = false,
                            consumable = true,
                            hit = false,
                            solid = false,
                            onConsume = function(player, object)
                                key_hold = true
                                gSounds['pickup']:play()
                                player.score = player.score + 200
                            end
                        })
                    end 
                end
            elseif block_type == 2 and not lock_placed then
                                -- randomly placed lock box
                                if math.random(5) == 1 then
                                    if not lock then
                                        
                                        lock = true
                            
                                        table.insert(objects, 
                                        GameObject{texture = 'key', 
                                            x = (x-1)*TILE_SIZE, y = (blockHeight-1)* TILE_SIZE, 
                                            width = 16, height=16,
                                            frame = math.random(5,8),
                                            collidable = true,
                                            consumable = false, 
                                            hit = false,
                                            solid = true,
                                            onCollide = function(obj)
                                                local colour_hold = math.random(6)
                                                if key_hold then
                                                    obj.solid = false
                                                    obj.consumable = true
                                                    obj.onConsume = function(player, object)
                                                        gSounds['powerup-reveal']:play()
                                                        player.score = player.score + 500

                                                    local newBL = 2

                                                    table.insert(objects,
                                                        GameObject{texture = 'toppers',
                                                        x = (width-2)*TILE_SIZE, y = (newBL+2) *TILE_SIZE,
                                                        width = 16 , height = 16,
                                                        frame = tileset,
                                                        collidable = true,
                                                        hit = false,
                                                        solid = true,
                                                        onCollide = function(obj)
                                                        end
                                                
                                                
                                                        })


                                                    table.insert(objects, 
                                                    GameObject{texture = 'flag',
                                                    x = (width-2)*TILE_SIZE, y = (newBL-1) * TILE_SIZE,
                                                    width = 16, height = 16,
                                                    frame = colour_hold,
                                                    collidable = true,
                                                    consumable = false,
                                                    --hit = false,
                                                    solid = false,
                                                    onCollide = function (obj)
                                                        flag_down = true
                                                    end


                                                    })
                                                    table.insert(objects, 
                                                    GameObject{texture = 'flag',
                                                    x = (width-2)*TILE_SIZE, y = (newBL) * TILE_SIZE,
                                                    width = 16, height = 16,
                                                    frame = colour_hold+9,
                                                    collidable = true,
                                                    consumable = false,
                                                    --hit = false,
                                                    solid = false,
                                                    onCollide = function (obj)
                                                        flag_down = true
                                                    end


                                                    })
                                                    table.insert(objects, 
                                                    GameObject{texture = 'flag',
                                                    x = (width-2)*TILE_SIZE, y = (newBL+1) * TILE_SIZE,
                                                    width = 16, height = 16,
                                                    frame = colour_hold+18,
                                                    collidable = true,
                                                    consumable = false,
                                                    --hit = false,
                                                    solid = false,
                                                    onCollide = function (obj)
                                                        flag_down = true
                                                    end


                                                    })
                                                    
                                                    local flag = GameObject{texture = 'flag',
                                                    x = (width-1.5)*TILE_SIZE, y = (newBL-1) * TILE_SIZE,
                                                    width = 16, height = 16,
                                                    frame =7+ 9*math.random(0,3),
                                                    collidable = true,
                                                    consumable = false,
                                                    --hit = false,
                                                    solid = true,
                                                    onCollide = function (obj)
                                                        obj.solid = false
                                                        
                                                       player.score = player.score + 500
                                                        Timer.tween(1, {
                                                            [obj] = {y = (newBL + 1) * TILE_SIZE},
                                                            
                                                        }):finish(function()
                                                            gStateMachine:change('play', {level_width = width+math.floor(player.score/100), score = player.score})
                                                        end )
                                                       

                                                        
                                                    
                                                    end

                                                    }

                                         

                                                    table.insert( objects, flag)


                                                    end 
                                                end
                                            end,
                        
                                        })
                                    end 
                                end
            else   
                if math.random(10) == 1 then
                    table.insert(objects,

                        -- jump block
                        GameObject {
                            texture = 'jump-blocks',
                            x = (x - 1) * TILE_SIZE,
                            y = (blockHeight - 1) * TILE_SIZE,
                            width = 16,
                            height = 16,

                            -- make it a random variant
                            frame = math.random(#JUMP_BLOCKS),
                            collidable = true,
                            hit = false,
                            solid = true,

                            -- collision function takes itself
                            onCollide = function(obj)

                                -- spawn a gem if we haven't already hit the block
                                if not obj.hit then

                                    -- chance to spawn gem, not guaranteed
                                    if math.random(5) == 1 then

                                        -- maintain reference so we can set it to nil
                                        local gem = GameObject {
                                            texture = 'gems',
                                            x = (x - 1) * TILE_SIZE,
                                            y = (blockHeight - 1) * TILE_SIZE - 4,
                                            width = 16,
                                            height = 16,
                                            frame = math.random(#GEMS),
                                            collidable = true,
                                            consumable = true,
                                            solid = false,

                                            -- gem has its own function to add to the player's score
                                            onConsume = function(player, object)
                                                gSounds['pickup']:play()
                                                player.score = player.score + 100
                                            end
                                        }
                                        
                                        -- make the gem move up from the block and play a sound
                                        Timer.tween(0.1, {
                                            [gem] = {y = (blockHeight - 2) * TILE_SIZE}
                                        })
                                        gSounds['powerup-reveal']:play()

                                        table.insert(objects, gem)
                                    end

                                    obj.hit = true
                                end

                                gSounds['empty-block']:play()
                            end
                        }
                    )
                end
            end      
            
            
            -- if there is no key by the in the entire map, spawn one in at the end
            if not key and x == (width-1) then
                key = true
                table.insert(objects, 
                GameObject{texture = 'key', 
                    x = (x-1)*TILE_SIZE, y = (blockHeight-1)* TILE_SIZE, 
                    width = 16, height=16,
                    frame = math.random(4),
                    collidable = true,
                    consumable = true,
                    hit = false,
                    solid = false,
                    onConsume = function(player, object)
                        key_hold = true
                        gSounds['pickup']:play()
                        player.score = player.score + 200
                    end
                })
            end 
            
        
            -- if there is no lock by the in the entire map, spawn one in at the end
            if not lock and x == (width-5) then
                lock = true
                table.insert(objects, 
                GameObject{texture = 'key', 
                    x = (x-1)*TILE_SIZE, y = (blockHeight-1)* TILE_SIZE, 
                    width = 16, height=16,
                    frame = math.random(4),
                    collidable = true,
                    consumable = false,
                    hit = false,
                    solid = true,
                    onCollide = function(obj)
                        if key_hold then
                            obj.solid = false
                            obj.consumable = true
                            obj.onConsume = function(player, object)
                                gSounds['powerup-reveal']:play()
                                player.score = player.score + 500
                            end 
                        end
                    end,

            
                })
            end 

        end
    end

    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map)
end