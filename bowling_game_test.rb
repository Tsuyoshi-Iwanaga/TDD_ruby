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

  def test_spare_is_madeup_only_evenshot
    @game.record_shot(2)
    @game.record_shot(5)
    @game.record_shot(5) #直前の投球との合計は10だがフレームが異なるのでスペアではない
    @game.record_shot(1)
    record_many_shots(16, 0)
    assert_equal 13, @game.score
  end

  def test_get_strike
    @game.record_shot(10) #10 + 3 + 3
    @game.record_shot(3)
    @game.record_shot(3)
    @game.record_shot(1)
    record_many_shots(15, 0) #全体では15投になる
    assert_equal 23, @game.score
  end

  def record_many_shots(count, pins)
    count.times do
      @game.record_shot(pins)
    end
  end
end