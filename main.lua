-- libs
push = require("libs/push")
Class = require('libs/class')

-- units
require('units/Bird')
require('units/Pipe')

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
-- local pipe = Pipe()
local pipes = {}
local pipeSpawnTimer = 2

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

  pipeSpawnTimer = pipeSpawnTimer + dt

  if (pipeSpawnTimer > 2) then
    table.insert(pipes, Pipe())
    print('added new pipe!')

    pipeSpawnTimer = 0
  end

  bird:update(dt)

  for k, pipe in pairs(pipes) do
    pipe:update(dt)

    if pipe.x < -pipe.width then
      print('removed old pipe!')
      table.remove(pipes, k)
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

  for k, pipe in pairs(pipes) do
    pipe:render()
  end
  
  love.graphics.draw(ground, -groundScroll, gameHeight - 16)

  bird:render()

  push:finish()
end