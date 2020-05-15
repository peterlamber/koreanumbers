class ConverterController < ApplicationController
  include Koreanumbers::Converter
  String.include Koreanumbers::Converter
  def index
    @message ||= "
Base numbers:
일: 1, 이: 2, 삼: 3, 사: 4, 오: 5, 육: 6, 칠: 7, 팔: 8, 구: 9

Small Units:
십: 10, 백: 100, 천: 1000

Big Units:
만: 10_000, 억: 100_000_000, 조: 1_000_000_000_000

Examples:
오백삼십조칠천팔백구십만천오백삼십구
삼조사천이만삼천구
육십사억삼천십팔만칠천육백구
사십삼
구백육십조칠천억팔천백삼십이만칠천일
사십삼조오천이백억육천구백십만일
이천구백육십조천오백칠십만삼천구백구십
삼천사백오십조일억이천만육백사십삼
사십오억삼천육십만오백구십
칠십억천이백삼십오만칠천구십이
천백십일, 구천오백구십구,  오억사천, 백십일,  만오천사백삼십, 
십구만삼천오백, 일조, 삼, 일억, 만
"
  end

  # def new
  #   @message = "Result is
  #   hangul to number: #{hangul.han_to_i}
  #   number to hangul: #{number.to_han}"
  #   @out = true
  #   render :index
  # end

  # private 
  # def hangul
  #   params[:hangul]
  # end

  # def number
  #   params[:number]
  # end
end
