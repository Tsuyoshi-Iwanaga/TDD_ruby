require 'minitest/autorun'
require_relative 'frame'

class FrameTest < MiniTest::Unit::TestCase
  def test_all_shots_gutter
    frame = Frame.new
    frame.record_shot(0)
    frame.record_shot(0)
    assert_equal 0, frame.score
  end
end