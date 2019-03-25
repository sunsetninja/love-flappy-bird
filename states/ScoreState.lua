ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
  self.score = params.score
  self.highScore = params.highScore
end

function ScoreState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end

function ScoreState:render()
  love.graphics.setFont(flappyFont)
  love.graphics.printf('Oof! You lost!', 0, 64, gameWidth, 'center')

  love.graphics.setFont(mediumFont)
  love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, gameWidth, 'center')
  love.graphics.printf('High score: ' .. tostring(self.highScore), 0, 130, gameWidth, 'center')

  love.graphics.printf('Press Enter to Play Again!', 0, 190, gameWidth, 'center')
end