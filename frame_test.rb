require 'minitest/autorun'
require_relative 'frame'

class FrameTest < MiniTest::Unit::TestCase
  def test_all_shots_gutter
    frame = Frame.new
    frame.record_shot(0)
    frame.record_shot(0)
    assert_equal 0, frame.score
  end

  def test_all_shots_get_1pin
    frame = Frame.new
    frame.record_shot(1)
    frame.record_shot(1)
    assert_equal 2, frame.score
  end

  def test_finished?
    frame = Frame.new
    frame.record_shot(1)
    refute frame.finished?, "2投目が可能"
    frame.record_shot(1)
    assert frame.finished?, "2投したので終了"
  end

  def test_finish_frame_get_strike
    frame = Frame.new
    frame.record_shot(10)
    assert frame.finished?, "10ピン倒したので終了"
  end

  def test_when_spare_on_second_shot_in_frame
    frame = Frame.new
    frame.record_shot(5)
    refute frame.spare?, "1投目なのでスペアではない"
    frame.record_shot(5)
    assert frame.spare?, "2投目かつ10ピンになったのでスペア"
  end

  def test_when_strike_in_frame
    frame = Frame.new
    refute frame.strike?, "投げる前はストライクにはならない"
    frame.record_shot(10)
    assert frame.strike?, "1投目に10ピン倒しているのでストライク"
  end

  def test_add_bonus
    frame = Frame.new
    frame.record_shot(5)
    frame.record_shot(5)
    frame.add_bonus(5)
    assert_equal 15, frame.score
  end
end