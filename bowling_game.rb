class BowlingGame
  def initialize
    @score = 0
    @spare = false
    @lastpins = 0
    @shot_no = 1
    @strike_bornus_count = 0
    @double_bornus_count = 0
  end

  def record_shot(pins)
    @score += pins
    calc_spare_bonus(pins)
    calc_strike_bonus(pins)
    @lastpins = pins
    proceed_next_shot
  end

  def score
    @score
  end

  private

  def proceed_next_shot
    if(@shot_no == 1)
      @shot_no = 2
    else
      @shot_no = 1
    end
  end

  def calc_strike_bonus(pins)
    if @strike_bornus_count > 0
      @score += pins
      @strike_bornus_count -= 1
    end

    if @double_bornus_count > 0
      @score += pins
      @double_bornus_count -= 1
    end

    if pins == 10
      if @strike_bornus_count == 0
        @strike_bornus_count = 2
      else
        @double_bornus_count = 2
      end
    end
  end

  def calc_spare_bonus(pins)
    if @spare
      @score += pins
      @spare = false
    end

    if @shot_no == 2 && @lastpins + pins == 10
      @spare = true
    end
  end
end