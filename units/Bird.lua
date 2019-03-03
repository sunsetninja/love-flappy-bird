Bird = Class{}

local gravity = 20

function Bird:init()
  self.image = love.graphics.newImage('assets/images/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = (gameWidth / 2) - (self.width / 2)
  self.y = (gameHeight / 2) - (self.height / 2)

  self.dy = 0
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end


function Bird:update(dt)
  self.dy = self.dy + (gravity * dt)

  self.y = self.y + self.dy
end