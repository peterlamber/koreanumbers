# Author: Peter Lamber
# Hangul to Number <=> Number to Hangul 

module Koreanumbers
numbers = { 일: 1, 이: 2, 삼: 3, 사: 4, 오: 5, 육: 6, 칠: 7, 팔: 8, 구: 9, 십: 10, 백: 100, 천: 1000, 만: 10_000, 억: 100_000_000, 조: 1_000_000_000_000 }
def to_i
  
end

def to_han
  
end
end


@numbers = { 일: 1, 이: 2, 삼: 3, 사: 4, 오: 5, 육: 6, 칠: 7, 팔: 8, 구: 9, 십: 10, 백: 100, 천: 1000, 만: 10_000, 억: 100_000_000, 조: 1_000_000_000_000 }
DATA = [
  ['오백삼십조칠천팔백구십만천오백삼십구', '삼조사천이만삼천구'],
  ['육십사억삼천십팔만칠천육백구', '사십삼'],
  ['구백육십조칠천억팔천백삼십이만칠천일', '사십삼조오천이백억육천구백십만일'],
  ['이천구백육십조천오백칠십만삼천구백구십', '삼천사백오십조일억이천만육백사십삼'],
  ['사십오억삼천육십만오백구십', '칠십억천이백삼십오만칠천구십이'],
  ['천백십일', '구천오백구십구'],
  ['오억사천', '백십일'],
  ['만오천사백삼십', '십구만삼천오백'],
  ['일조', '삼'],
  ['일억', '만'],
]

def convert_num(p)
  num = 1
  part = []
  result = []
  nums = p.chars.map { |n| @numbers[n.to_sym]}
  nums.each_with_index do|n,i |    
    num = n if n < 10
    if n > 9 && n < 10000
      part.push(n *= num)
      nums.size-1 != i ? num = 1 : num = 0
    end

    if n >= 10000      
      if part.size == 0
      	result.push(n*num)
      else
        result.push(num*n) if n == 1
        result.push(num*n) if num != 1
      	result.push(part.sum * n)
      end
      part = []
      nums.size-1 != i ? num = 1 : num = 0
    end   
  end
  result.push(part.push(num).sum).sum 
end

unit={십: 1, 백: 2, 천: 3, 만: 4, 억: 8, 조: 12 }
my_res = []
DATA.each do|rec|
  res = convert_num(rec[0]) + convert_num(rec[1])
  string = ''
  prev_num = 0
  digits=res.digits
  size=digits.size-1

  size.step(0,-1) do |i| 
    digit = digits[i]
    
    string << @numbers.key(digit).to_s if digit != 1 
    string << @numbers.key(digit).to_s if i == 0 && digit == 1

    string << @numbers.key(digit).to_s if digit == 1 && ( i == 8 || i == 12)
    string << @numbers.key(digit).to_s if digit == 1 && i == 4 && i != size

    if digit == 0 
      string << unit.key(i).to_s if prev_num != 0 && (i == 12 || i == 8 || i == 4)
      prev_num = 0
      next 
    end
    prev_num = digit

    if i > 12 && i-12 < 4
        string << unit.key(i-12).to_s
    elsif i > 8 && i-8 < 4
        string << unit.key(i-8).to_s 
    elsif i > 4 && i-4 < 4
        string << unit.key(i-4).to_s  
    end

    string << unit.key(i).to_s unless unit.key(i).nil?
  end

  my_res.push string
end

result = %w{
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
}

# check result
my_res.each_with_index do|res,i|
  p res
  # if res == result[i]
  #   p "#{i} good"
  # else
  #   p "#{i} nope" 
  #   p "O" + result[i]
  #   p "X" + res
  # end
end

# Expected Result
# 오백삼십삼조일억천팔백구십이만사천오백사십팔
# 육십사억삼천십팔만칠천육백오십이
# 천사조이천이백일억오천사십이만칠천이
# 육천사백십조일억삼천오백칠십만사천육백삼십삼
# 백십오억사천이백구십오만칠천육백팔십이
# 만칠백십
# 오억사천백십일
# 이십만팔천구백삼십
# 일조삼
# 일억일만
