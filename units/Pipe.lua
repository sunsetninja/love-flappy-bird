Pipe = Class{}

local pipeImage = love.graphics.newImage('assets/images/pipe.png')
local pipeScroll = -60

function Pipe:init()
  self.width = pipeImage:getWidth()

  self.x = gameWidth
  self.y = math.random(gameHeight / 4, gameHeight - 10)
end

function Pipe:update(dt)
  self.x = self.x + (pipeScroll * dt)
end

function Pipe:render()
  love.graphics.draw(pipeImage, self.x, self.y)
end