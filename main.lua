-- libs
push = require("libs/push")
Class = require('libs/class')

-- units
require('units/Bird')
require('units/PipePair')

gameWidth = 512
gameHeight = 288

local windowWidth = 1280
local windowHeight = 720

local background = love.graphics.newImage('assets/images/background.png')
local backgroundScroll = 0
local backgroundScrollSpeed = 30
local backgroundLoopingPoint = 413

local ground = love.graphics.newImage('assets/images/ground.png')
local groundScroll = 0
local groundScrollSpeed = 60

local bird = Bird()
local pipePairs = {}
local pipePairSpawnTimer = 2
local lastPipesY = -pipeHeight + math.random(80) + 20

-- 
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setTitle('Flappy bird clone')

  math.randomseed(os.time())

  push:setupScreen(
    gameWidth,
    gameHeight,
    windowWidth,
    windowHeight,
    {
      vsync = true,
      resizable = true,
      fullscreen = false
    }
  )

  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  if dt < 1/60 then
    love.timer.sleep(1/60 - dt)
  end

  backgroundScroll = (backgroundScroll + (backgroundScrollSpeed * dt)) % backgroundLoopingPoint

  groundScroll = (groundScroll + (groundScrollSpeed * dt)) % gameWidth

  pipePairSpawnTimer = pipePairSpawnTimer + dt

  if (pipePairSpawnTimer > 2) then
    local y = math.max(
      -pipeHeight + 10, 
      math.min(
        lastPipesY + math.random(-20, 20),
        gameHeight - 90 - pipeHeight)
      )
    
    lastPipesY = y

    table.insert(pipePairs, PipePair(y))
    print('added new pipes!')

    pipePairSpawnTimer = 0
  end

  bird:update(dt)

  for k, pipePair in pairs(pipePairs) do
    pipePair:update(dt)

    if pipePair.remove then
      table.remove(pipePairs, k)
      print('removed old pipes!')
    end
  end

  love.keyboard.keysPressed = {}
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true

  if key == 'escape' then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
      return true
  else
      return false
  end
end

function love.draw()
  push:start()

  love.graphics.draw(background, -backgroundScroll, 0)

  for _, pipePair in pairs(pipePairs) do
    pipePair:render()
  end
  
  love.graphics.draw(ground, -groundScroll, gameHeight - 16)

  bird:render()

  push:finish()
end