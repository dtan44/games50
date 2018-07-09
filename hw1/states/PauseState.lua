--[[
    PauseState Class
    Pset Part 4
]]
PauseState = Class {__includes = BaseState}

--[[
    When we enter the pause state, we expect the bird,
    pipes, and score to pause environment.
]]
function PauseState:enter(params)
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.score = params.score
    sounds["music"]:pause()
    sounds["pause"]:play()
    PAUSE = true
end

function PauseState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed("p") then
        gStateMachine:change(
            "play",
            {
                bird = self.bird,
                pipePairs = self.pipePairs,
                score = self.score
            }
        )
    end
end

function PauseState:render()
    self.bird:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print("Score: " .. tostring(self.score), 8, 8)
    love.graphics.setFont(hugeFont)
    love.graphics.printf("PAUSED", 0, 100, VIRTUAL_WIDTH, "center")
end

function PauseState:exit()
    sounds["music"]:play()
    sounds["pause"]:play()
    PAUSE = false
end
