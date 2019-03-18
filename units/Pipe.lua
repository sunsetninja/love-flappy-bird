Pipe = Class{}

local pipeImage = love.graphics.newImage('assets/images/pipe.png')
pipeSpeed = 60
pipeHeight = 288
pipeWidth = 70

function Pipe:init(orientation, y)
  self.width = pipeImage:getWidth()

  self.x = gameWidth
  self.y = y
  self.orientation = orientation
end

function Pipe:render()
  love.graphics.draw(
    pipeImage,
    self.x,
    (self.orientation == 'top' and self.y + pipeHeight or self.y),
    0,
    1,
    self.orientation == 'top' and -1 or 1
  )
end