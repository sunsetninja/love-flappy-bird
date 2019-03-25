PlayState = Class{__includes = BaseState}


function PlayState:init()
  self.bird = Bird()
  self.pipePairs = {}
  self.pipePairSpawnTimer = 2
  self.lastPipesY = -pipeHeight + math.random(80) + 20
end

function PlayState:update(dt)
  self.pipePairSpawnTimer = self.pipePairSpawnTimer + dt

  if (self.pipePairSpawnTimer > 2) then
    local y = math.max(
      -pipeHeight + 10, 
      math.min(
        self.lastPipesY + math.random(-40, 40),
        gameHeight - (pipePairGapHeight - 10) - pipeHeight)
      )
    
    self.lastPipesY = y

    table.insert(self.pipePairs, PipePair(y))
    print('added new pipes!')

    self.pipePairSpawnTimer = 0
  end

  self.bird:update(dt)

  for k, pipePair in pairs(self.pipePairs) do
    pipePair:update(dt)

    for l, pipe in pairs(pipePair.pipes) do
      if self.bird:collides(pipe) then
        print('bird collides with a pipe!')
        gStateMachine:change('title')
      end
    end

    if pipePair.remove then
      table.remove(self.pipePairs, k)
      print('removed old pipes!')
    end
  end

  if self.bird.y > gameHeight - 15 then
    gStateMachine:change('title')
  end
end

function PlayState:render()
  for _, pipePair in pairs(self.pipePairs) do
    pipePair:render()
  end
  
  self.bird:render()
end