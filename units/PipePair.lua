require("units/Pipe")

PipePair = Class{}


function PipePair:init(y)
  self.x = gameWidth + 32
  self.y = y

  self.pipes = {
    ['upper'] = Pipe('top', self.y),
    ['lower'] = Pipe('bottom', self.y + pipeHeight + pipePairGapHeight)
  }

  self.remove = false
  self.scored = false
end

function PipePair:update(dt)
  if self.x > -pipeWidth then
      self.x = self.x - pipeSpeed * dt
      
      self.pipes['lower'].x = self.x
      self.pipes['upper'].x = self.x
  else
      self.remove = true
  end
end

function PipePair:render()
  for k, pipe in pairs(self.pipes) do
      pipe:render()
  end
end