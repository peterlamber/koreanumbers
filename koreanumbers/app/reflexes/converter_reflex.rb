# frozen_string_literal: true

class ConverterReflex < ApplicationReflex
  
  def input
    @input = element[:value]
    if @input == ''
      @out = ''
      return
    end

    begin
       @out = if @input.to_i == 0
                @input.han_to_i
              else
                @input.to_han
              end
    rescue StandardError => e
      @out = ''
    end
  end
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com
end
