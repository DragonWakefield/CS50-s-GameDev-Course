
LevelupMenu = Class{__includes = BaseState}


function LevelupMenu:init(pokemon)
    self.pokemon = pokemon
    self.HP = self.pokemon.HP
    self.attack = self.pokemon.attack
    self.defense = self.pokemon.defense
    self.speed = self.pokemon.speed
    local hpI, attI, defI,speedI = self.pokemon:levelUp()
    self.levelMenu = Menu {
        x = VIRTUAL_WIDTH - 128,
        y = VIRTUAL_HEIGHT-192,
        width = 128,
        height = 128,
        items = {
            {
                text = 'HP- '.. self.HP .. '(+' .. hpI .. ')',
                onSelect = function()
                    --gStateStack:pop()
                    --gStateStack:push(NewLevelMenu(self.pokemon))
                    self.levelMenu = Menu{
                        x = VIRTUAL_WIDTH - 128,
                        y = VIRTUAL_HEIGHT-192,
                        width = 128,
                        height = 128,

                        items = {
                            {text = 'HP- '..self.pokemon.HP,
                        
                            onSelect = function()

                                gStateStack:pop()
                                self.fadeOutWhite()
                            end 
                        
                            },
                            {text = 'Atk- '..self.pokemon.attack},
                            {text = 'Def- '..self.pokemon.defense},
                            {text = 'Spd- '..self.pokemon.speed}
                        },
                        cursor = false

                    }
                end
            },
            {
                text = 'Atk- ' .. self.attack .. '(+' .. attI .. ')'
            },
            {
                text = 'Def- '.. self.defense .. '(+' .. defI .. ')'
            },
            {
                text = 'Spd- ' .. self.speed .. '(+' .. speedI .. ')',

            }

            
        },
        cursor = false




    }
 
end 

function LevelupMenu:update(dt)

    self.levelMenu:update(dt)
end

function LevelupMenu:render()
    self.levelMenu:render()
end

function LevelupMenu:fadeOutWhite()
    -- fade in
    gStateStack:push(FadeInState({
        r = 255, g = 255, b = 255
    }, 1, 
    function()

        -- resume field music
        gSounds['victory-music']:stop()
        gSounds['field-music']:play()
        
        -- pop off the battle state
        gStateStack:pop()
        gStateStack:push(FadeOutState({
            r = 255, g = 255, b = 255
        }, 1, function() end))
    end))
end