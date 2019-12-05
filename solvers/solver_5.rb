require('pry')
module Solvers
  class Solver5
    def solve_a(input)
      input = input.first.chomp.split(',').map(&:to_i)

      Helpers::OpcodeComputer.new(input).compute(input: 1)
    end

    def solve_b(input)
    end
  end
end
