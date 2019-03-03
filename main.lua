-- libs
push = require("libs/push")
Class = require('libs/class')

-- units
require('units/Bird')

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

-- 
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setTitle('Flappy bird clone')

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

  bird:update(dt)

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
  love.graphics.draw(ground, -groundScroll, gameHeight - 16)

  bird:render()

  push:finish()
end