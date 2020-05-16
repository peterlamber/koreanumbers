# frozen_string_literal: true

class ConverterReflex < ApplicationReflex
  def input
    @input = element[:value]
    if @input == ''
      @out = ''
      return
    end

    begin
      return @out = @input.to_han if @input == "0"
      @out = @input.to_i == 0 ? @input.han_to_i : @input.to_han
    rescue StandardError => e
      @out = ''
    end
  end
end
