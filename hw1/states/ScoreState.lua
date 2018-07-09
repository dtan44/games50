--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]
ScoreState = Class {__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score

    -- Pset Part 3
    if params.score > 3 then
        self.award = 3
    elseif params.score > 2 then
        self.award = 2
    else
        self.award = 1
    end
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("countdown")
    end
end

local AWARD = {"(・ヘ・?)", "(´・ω・`)", "d=(´▽｀)=b"}

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf("Oof! You lost!", 0, 64, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Score: " .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, "center")

    -- Pset Part 3
    love.graphics.printf("Award: ", 0, 130, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(awardFont)
    love.graphics.printf(tostring(AWARD[self.award]), 0, 140, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Enter to Play Again!", 0, 170, VIRTUAL_WIDTH, "center")
end
