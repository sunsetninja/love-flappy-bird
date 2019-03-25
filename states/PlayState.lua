PlayState = Class{__includes = BaseState}

local highScore = 0

function PlayState:init()
  self.score = 0
  self.bird = Bird()
  self.pipePairs = {}
  self.pipePairSpawnTimer = 2
  self.lastPipesY = -pipeHeight + math.random(80) + 20
  print('init')
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

    self.pipePairSpawnTimer = 0
  end

  self.bird:update(dt)

  for k, pipePair in pairs(self.pipePairs) do
    pipePair:update(dt)

    for l, pipe in pairs(pipePair.pipes) do
      if self.bird:collides(pipe) then
        gStateMachine:change('score', {
          score = self.score,
          highScore = highScore
        })
      end
    end

    if pipePair.remove then
      table.remove(self.pipePairs, k)
    end

    if (self.bird.x >= pipePair.x + pipeWidth and not pipePair.scored) then
      self.score = self.score + 1
      pipePair.scored = true

      if (highScore < self.score) then
        highScore = self.score
      end

      print('score', self.score)
    end
  end

  if self.bird.y > gameHeight - 15 then
    gStateMachine:change('score', {
      score = self.score,
      highScore = highScore
    })
  end
end

function PlayState:render()
  for _, pipePair in pairs(self.pipePairs) do
    pipePair:render()
  end
  
  self.bird:render()
end