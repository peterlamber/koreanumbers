# frozen_string_literal: true

require 'test_helper'

class Converter < ActiveSupport::TestCase
  String.include Koreanumbers::Converter
  test 'to han' do
    assert_equal('0'.to_han, '공')
    assert_equal('1'.to_han, '일')
    assert_equal('2'.to_han, '이')
    assert_equal('3'.to_han, '삼')
    assert_equal('4'.to_han, '사')
    assert_equal('5'.to_han, '오')
    assert_equal('6'.to_han, '육')
    assert_equal('7'.to_han, '칠')
    assert_equal('8'.to_han, '팔')
    assert_equal('9'.to_han, '구')
    assert_equal('10'.to_han, '십')
    # 일: 1, 이: 2, 삼: 3, 사: 4, 오: 5, 육: 6, 칠: 7, 팔: 8, 구: 9, 십: 10, 백: 100, 천: 1000, 만: 10_000, 억: 100_000_000, 조: 1_000_000_000_000 }
  end
  test 'to number' do
    assert_equal('일'.han_to_i, 1)
    assert_equal('공'.han_to_i, 0)
  end

  test '10000 to han' do
    assert_equal('10000'.to_han, '만')
    assert_equal('90000'.to_han, '구만')
    assert_equal('900000'.to_han, '구십만')
    assert_equal('9000000'.to_han, '구백만')
    assert_equal('90000000'.to_han, '구천만')
  end

  test 'problem' do
    assert_equal('900000000'.to_han, '구억')
  end

  test 'han to 10000' do
    assert_equal('만'.han_to_i, 10_000)
    assert_equal('구만'.han_to_i, 90_000)
    assert_equal('구십만'.han_to_i, 900_000)
    assert_equal('구백만'.han_to_i, 9_000_000)
    assert_equal('구천만'.han_to_i, 90_000_000)
  end

  test 'basic examples han_to_i' do
    assert_equal('오백삼십조칠천팔백구십만천오백삼십구'.han_to_i, 530_000_078_901_539)
    assert_equal('삼조사천이만삼천구'.han_to_i, 3_000_040_023_009)
    assert_equal('만'.han_to_i, 10_000)
    # assert_equal( "육십사억삼천십팔만칠천육백구".han_to_i, 64_uhhh)
    # 육십사억삼천십팔만칠천육백구
    # 사십삼
    # 구백육십조칠천억팔천백삼십이만칠천일
    # 사십삼조오천이백억육천구백십만일
    # 이천구백육십조천오백칠십만삼천구백구십
    # 삼천사백오십조일억이천만육백사십삼
    # 사십오억삼천육십만오백구십
    # 칠십억천이백삼십오만칠천구십이
    # 천백십일, 구천오백구십구,  오억사천, 백십일,  만오천사백삼십,
    # 십구만삼천오백, 일조, 삼, 일억
  end

  test 'basic examples to_han' do
    assert_equal('10000'.to_han, '만')
    assert_equal('530_000_078_901_539'.to_han, '오백삼십조칠천팔백구십만천오백삼십구')
  end

  test 'sums' do
    data = [
      %w[오백삼십조칠천팔백구십만천오백삼십구 삼조사천이만삼천구],
      %w[육십사억삼천십팔만칠천육백구 사십삼],
      %w[구백육십조칠천억팔천백삼십이만칠천일 사십삼조오천이백억육천구백십만일],
      %w[이천구백육십조천오백칠십만삼천구백구십 삼천사백오십조일억이천만육백사십삼],
      %w[사십오억삼천육십만오백구십 칠십억천이백삼십오만칠천구십이],
      %w[천백십일 구천오백구십구],
      %w[오억사천 백십일],
      %w[만오천사백삼십 십구만삼천오백],
      %w[일조 삼],
      %w[일억 만]
    ]
    result = %w[
      오백삼십삼조일억천팔백구십이만사천오백사십팔
      육십사억삼천십팔만칠천육백오십이
      천사조이천이백일억오천사십이만칠천이
      육천사백십조일억삼천오백칠십만사천육백삼십삼
      백십오억사천이백구십오만칠천육백팔십이
      만칠백십
      오억사천백십일
      이십만팔천구백삼십
      일조삼
      일억일만
    ]
    data.each_with_index do |rec, i|
      assert_equal((rec[0].han_to_i + rec[1].han_to_i).to_s.to_han, result[i])
    end
  end

  test 'reject higher than max' do
    assert_equal('10000000000000000'.to_han, '죄송합니다, maximum is 조')
    assert_equal('1000000000000000'.to_han, '천조')
  end
end
