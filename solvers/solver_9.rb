require_relative 'lib/opcode.rb'

module Solvers
  class Solver9
    def solve_a(input, _opts = {})
      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)

      computer.compute(input: [1])

      computer.output.last
    end

    def solve_b(input, _opts = {})
      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)

      computer.compute(input: [2])

      computer.output.last
    end
  end
end
