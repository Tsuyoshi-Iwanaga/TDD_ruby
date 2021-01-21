require 'minitest/autorun'
require_relative 'bowling_game'

class BowlingGameTest < MiniTest::Unit::TestCase
  def test_all_gutter_game
    game = BowlingGame.new
  end
end