require 'minitest/autorun'
require_relative 'bowling_game'

class BowlingGameTest < MiniTest::Unit::TestCase
  def setup
    @game = BowlingGame.new
  end

  def test_all_gutter_game
    record_many_shots(20, 0)
    assert_equal 0, @game.score
  end

  def test_all_1pin_game
    record_many_shots(20, 1)
    assert_equal 20, @game.score
  end

  def test_get_spare
    @game.record_shot(3)
    @game.record_shot(7) #10 + 4 = 14
    @game.record_shot(4)
    record_many_shots(17, 0)
    assert_equal 18, @game.score
  end

  def record_many_shots(count, pins)
    count.times do
      @game.record_shot(pins)
    end
  end
end