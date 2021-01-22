class BowlingGame
  def initialize
    @score = 0
    @spare = false
    @lastpins = 0
  end

  def record_shot(pins)
    @score += pins

    if @spare
      @score += pins
      @spare = false
    end

    if @lastpins + pins == 10
      @spare = true
    end

    @lastpins = pins
  end

  def score
    @score
  end
end