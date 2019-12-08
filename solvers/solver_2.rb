require_relative 'lib/opcode.rb'

module Solvers
  class Solver2
    def solve_a(input, _)
      input = input.first.chomp.split(',').map(&:to_i)
      input[1] = 12
      input[2] = 2

      Helpers::OpcodeComputer.new(input).compute.first
    end

    def solve_b(input, _)
      input = input.first.chomp.split(',').map(&:to_i)

      noun = 0
      verb = 0
      val = 0

      (0..99).each do |v|
        (0..99).each do |n|
          copy = input.dup
          noun = n
          verb = v

          copy[1] = noun
          copy[2] = verb

          val = Helpers::OpcodeComputer.new(copy).compute.first

          break if val == 19_690_720
        end

        break if val == 19_690_720
      end

      100 * noun + verb
    end

  end
end
