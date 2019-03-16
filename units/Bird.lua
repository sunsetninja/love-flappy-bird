Bird = Class{}

local gravity = 20
local jumpVelocity = 250

function Bird:init()
  self.image = love.graphics.newImage('assets/images/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = (gameWidth / 2) - (self.width / 2)
  self.y = (gameHeight / 2) - (self.height / 2)

  self.dy = 0
end

function Bird:update(dt)
  self.dy = self.dy + (gravity * dt)

  -- Bird jump
  if love.keyboard.wasPressed('space') then
    self.dy = -5
  end

  self.y = self.y + self.dy
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end