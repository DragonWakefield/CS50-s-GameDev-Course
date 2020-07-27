
NewLevelMenu = Class{__includes = BaseState}


function NewLevelMenu:init(pokemon)
    self.pokemon = pokemon
    self.HP = self.pokemon.HP
    self.attack = self.pokemon.attack
    self.defense = self.pokemon.defense
    self.speed = self.pokemon.speed

    self.levelMenu = Menu {
        x = VIRTUAL_WIDTH - 128,
        y = VIRTUAL_HEIGHT-192,
        width = 128,
        height = 128,
        items = {
            {
                text = 'HP- '.. self.HP,
                onSelect = function()

                    gStateStack:pop()
                    self.fadeOutWhite()
                end 

            },
            {
                text = 'Atk- ' .. self.attack
            },
            {
                text = 'Def- '.. self.defense
            },
            {
                text = 'Spd- ' .. self.speed 

            }

            
        },
        cursor = false




    }
 
end 

function NewLevelMenu:update(dt)

    self.levelMenu:update(dt)
end

function NewLevelMenu:render()
    self.levelMenu:render()
end

function NewLevelMenu:fadeOutWhite()
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