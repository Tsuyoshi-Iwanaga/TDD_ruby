class BowlingGame
  def initialize
    @score = 0
    @spare = false
    @lastpins = 0
    @shot_no = 1
    @strike_bornus_count = 0
  end

  def record_shot(pins)
    @score += pins

    if @spare
      @score += pins
      @spare = false
    end

    if @shot_no == 2 && @lastpins + pins == 10
      @spare = true
    end

    if @strike_bornus_count > 0
      @score += pins
      @strike_bornus_count -= 1
    end

    if pins == 10
      @strike_bornus_count = 2
    end

    @lastpins = pins

    if(@shot_no == 1)
      @shot_no = 2
    else
      @shot_no = 1
    end
  end

  def score
    @score
  end
end