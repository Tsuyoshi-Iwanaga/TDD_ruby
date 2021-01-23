require_relative 'frame'

class BowlingGame
  def initialize
    @score = 0
    @spare = false
    @lastpins = 0
    @shot_no = 1
    @strike_bornus_count = 0
    @double_bornus_count = 0
    @frames = [ Frame.new ]
  end

  def record_shot(pins)
    frame = @frames.last
    frame.record_shot(pins)
    @score += pins
    calc_spare_bonus(pins)
    calc_strike_bonus(pins)
    @lastpins = pins
    proceed_next_shot
    if frame.finished?
      @frames << Frame.new
    end
  end

  def score
    @score
  end

  def frame_score(frame_no)
    @frames[frame_no - 1].score
  end

  private

  def proceed_next_shot
    if(@shot_no == 1 && @strike_bornus_count < 2 && @double_bornus_count < 2)
      @shot_no = 2
    else
      @shot_no = 1
    end
  end

  def calc_strike_bonus(pins)
    add_strike_bonus(pins)
    add_double_bonus(pins)

    if strike?(pins)
      recognize_strike_bonus
    end
  end

  def calc_spare_bonus(pins)
    if @spare
      @score += pins
      @spare = false
    end

    if spare?(pins)
      @spare = true
    end
  end

  def spare?(pins)
    @shot_no == 2 && @lastpins + pins == 10
  end

  def strike?(pins)
    pins == 10
  end

  def recognize_strike_bonus
    if @strike_bornus_count == 0
      @strike_bornus_count = 2
    else
      @double_bornus_count = 2
    end
  end

  def add_strike_bonus(pins)
    if @strike_bornus_count > 0
      @score += pins
      @strike_bornus_count -= 1
    end
  end

  def add_double_bonus(pins)
    if @double_bornus_count > 0
      @score += pins
      @double_bornus_count -= 1
    end
  end
end