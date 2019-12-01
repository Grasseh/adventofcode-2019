module Helpers
  def wrap_line_input(input)
    ["#{input}\n"]
  end

  def wrap_array_input(*inputs)
    inputs.map{ |input| "#{input}\n" }
  end
end
