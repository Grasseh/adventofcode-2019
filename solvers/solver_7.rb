require_relative 'lib/opcode.rb'

module Solvers
  class Solver7
    def solve_a(input)
      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)
      phase_inputs = [0, 1, 2, 3, 4]

      highest_amplifier = 0

      phase_inputs.permutation do |perm|
        previous_output = 0

        5.times do |i|
          computer.compute(input: [perm[i], previous_output])
          previous_output = computer.output.last
        end

        highest_amplifier = [computer.output.last, highest_amplifier].max
      end

      highest_amplifier
    end

    def solve_b(input)
      input = input.first.chomp.split(',').map(&:to_i)

      phase_inputs = [5, 6, 7, 8, 9]

      highest_amplifier = 0

      phase_inputs.permutation do |perm|
        amplifier_a = Helpers::OpcodeComputer.new(input)
        amplifier_b = Helpers::OpcodeComputer.new(input)
        amplifier_c = Helpers::OpcodeComputer.new(input)
        amplifier_d = Helpers::OpcodeComputer.new(input)
        amplifier_e = Helpers::OpcodeComputer.new(input)

        amplifier_a.compute(input: [perm[0], 0])
        amplifier_b.compute(input: [perm[1], amplifier_a.output])
        amplifier_c.compute(input: [perm[2], amplifier_b.output])
        amplifier_d.compute(input: [perm[3], amplifier_c.output])
        amplifier_e.compute(input: [perm[4], amplifier_d.output])

        loop do
          amplifier_a.resume(input: [amplifier_e.output])
          amplifier_b.resume(input: [amplifier_a.output])
          amplifier_c.resume(input: [amplifier_b.output])
          amplifier_d.resume(input: [amplifier_c.output])
          amplifier_e.resume(input: [amplifier_d.output])
          break if amplifier_e.state == Helpers::OpcodeComputer::HALT_STATE
        end

        highest_amplifier = [amplifier_e.output.last, highest_amplifier].max
      end

      highest_amplifier
    end
  end
end
