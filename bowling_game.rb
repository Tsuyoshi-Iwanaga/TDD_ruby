require_relative 'frame'

class BowlingGame
  def initialize
    @score = 0
    @spare = false
    @spare_frame = nil
    @strike_frame = nil
    @duble_frame = nil
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

  def calc_strike_bonus(pins)
    add_strike_bonus(pins)
    add_double_bonus(pins)

    if @frames.last.strike?
      recognize_strike_bonus
    end
  end

  def calc_spare_bonus(pins)
    if @spare
      @score += pins
      @spare = false
      @spare_frame.add_bonus(pins)
      @spare_frame = nil
    end

    if @frames.last.spare?
      @spare = true
      @spare_frame = @frames.last
    end
  end

  def recognize_strike_bonus
    if @strike_bornus_count == 0
      @strike_bornus_count = 2
      @strike_frame = @frames.last
    else
      @double_bornus_count = 2
      @double_frame = @frames.last
    end
  end

  def add_strike_bonus(pins)
    if @strike_bornus_count > 0
      @score += pins
      @strike_bornus_count -= 1
      @strike_frame.add_bonus(pins)
    end
  end

  def add_double_bonus(pins)
    if @double_bornus_count > 0
      @score += pins
      @double_bornus_count -= 1
      @double_frame.add_bonus(pins)
    end
  end
end