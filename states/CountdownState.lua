CountdownState = Class{__includes = BaseState}

local countdownTime = 0.75

function CountdownState:init()
  self.count = 3
  self.timer = 0
end

function CountdownState:update(dt)
  self.timer = self.timer + dt

  if self.timer > countdownTime then
    self.timer = self.timer % countdownTime
    self.count = self.count - 1

    if self.count == 0 then
      gStateMachine:change('play')
    end
  end
end

function CountdownState:render()
  love.graphics.setFont(hugeFont)
  love.graphics.printf(tostring(self.count), 0, 120, gameWidth, 'center')
end