local push = require("libs/push")

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
end

function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + (backgroundScrollSpeed * dt)) % backgroundLoopingPoint

  groundScroll = (groundScroll + (groundScrollSpeed * dt)) % gameWidth
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  push:start()

  love.graphics.draw(background, -backgroundScroll, 0)
  love.graphics.draw(ground, -groundScroll, gameHeight - 16)

  push:finish()
end