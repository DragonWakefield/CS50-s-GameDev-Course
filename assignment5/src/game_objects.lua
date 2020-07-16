--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        type = 'pot',
        texture = 'tiles',
        frame = 33,
        width = 16,
        height = 16, 
        solid = true,
        defaultState = 'grounded',
        fired = false,
        states = {
            ['grounded'] = {frame = 33},
            ['picked'] = {frame = 14},
            ['broken'] = {frame = 52}
        },
        fire = function()
            if not fired then 
                fired = true
            end 
        end 
    },
    ['heart'] = {
        type = 'heart',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 5
            },
            ['pressed'] = {
                frame = 5
            }
        }

    }
}