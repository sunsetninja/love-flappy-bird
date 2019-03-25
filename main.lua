-- libs
push = require("libs/push")
Class = require('libs/class')
require 'libs/StateMachine'

-- units
require('units/Bird')
require('units/PipePair')

-- states
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'

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

  math.randomseed(os.time())

  smallFont = love.graphics.newFont('assets/fonts/font.ttf', 8)
  mediumFont = love.graphics.newFont('assets/fonts/flappy.ttf', 14)
  flappyFont = love.graphics.newFont('assets/fonts/flappy.ttf', 28)
  hugeFont = love.graphics.newFont('assets/fonts/flappy.ttf', 56)
  love.graphics.setFont(flappyFont)

  sounds = {
    ['jump'] = love.audio.newSource('assets/sounds/effects/jump.wav', 'static'),
    ['explosion'] = love.audio.newSource('assets/sounds/effects/explosion.wav', 'static'),
    ['hurt'] = love.audio.newSource('assets/sounds/effects/hurt.wav', 'static'),
    ['score'] = love.audio.newSource('assets/sounds/effects/score.wav', 'static'),
    ['music'] = love.audio.newSource('assets/sounds/music/marios_way.mp3', 'static')
  }

  sounds['music']:setLooping(true)
  -- sounds['music']:play()

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

  gStateMachine = StateMachine{
    ['title'] = function() return TitleScreenState() end, 
    ['countdown'] = function() return CountdownState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end
  }
  gStateMachine:change('title')

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

  gStateMachine:update(dt)

  love.keyboard.keysPressed = {}
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true

  if key == 'escape' then
    love.event.quit()
    return
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

  gStateMachine:render()
  
  love.graphics.draw(ground, -groundScroll, gameHeight - 16)

  push:finish()
end