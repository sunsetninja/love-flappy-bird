require("units/Pipe")

PipePair = Class{}


function PipePair:init(y, isMoving)
  self.x = gameWidth + 32
  self.y = y
  self.isMoving = isMoving
  self.isMovingUp = math.random() > 0.5
  self.isMovingUp = false

  self.pipes = {
    ['upper'] = Pipe('top', self.y),
    ['lower'] = Pipe('bottom', self.y + pipeHeight + pipePairGapHeight)
  }

  topPoint = -pipeHeight + 40
  bottomPoint = gameHeight - (pipePairGapHeight + 40) - pipeHeight

  self.remove = false
  self.scored = false
end

function PipePair:update(dt)
  if self.x > -pipeWidth then
      self.x = self.x - pipeSpeed * dt
      
      self.pipes['upper'].x = self.x
      self.pipes['lower'].x = self.x

      if (self.isMoving) then
        local addingYOffset = self.isMovingUp and -10 or 10

        local nextY = math.max(
          topPoint, 
          math.min(
            self.y + addingYOffset * dt,
            bottomPoint
          )
        )

        if (nextY <= topPoint) then
          self.isMovingUp = false
        end

        if (nextY >= bottomPoint) then
          self.isMovingUp = true
        end

        self.y = nextY
        
        self.pipes['upper'].y = self.y
        self.pipes['lower'].y = self.y + pipeHeight + pipePairGapHeight
      end
  else
      self.remove = true
  end
end

function PipePair:render()
  for k, pipe in pairs(self.pipes) do
      pipe:render()
  end
end