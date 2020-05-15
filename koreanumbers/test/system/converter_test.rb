require "test_helper"

class Converter < ActiveSupport::TestCase
  String.include Koreanumbers::Converter
  test "to han" do
    assert_equal( "1".to_han, "일")
    assert_equal( "2".to_han, "이")
    assert_equal( "3".to_han, "삼")
    assert_equal( "4".to_han, "사")
    assert_equal( "5".to_han, "오")
    assert_equal( "6".to_han, "육")
    assert_equal( "7".to_han, "칠")
    assert_equal( "8".to_han, "팔")
    assert_equal( "9".to_han, "구")
    assert_equal( "10".to_han, "십")
    # 일: 1, 이: 2, 삼: 3, 사: 4, 오: 5, 육: 6, 칠: 7, 팔: 8, 구: 9, 십: 10, 백: 100, 천: 1000, 만: 10_000, 억: 100_000_000, 조: 1_000_000_000_000 }
  end
  test "to number" do
    assert_equal( "일".han_to_i, 1)
  end
  
  test "10000" do
    assert_equal( "10000".to_han, "만")
    assert_equal( "90000".to_han, "구만")
    assert_equal( "900000".to_han, "구십만")
    assert_equal( "9000000".to_han, "구백만")
    assert_equal( "90000000".to_han, "구천만")
  end
end