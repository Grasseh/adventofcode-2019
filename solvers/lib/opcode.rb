module Helpers
  class OpcodeComputer
    def initialize(program)
      @operations = {
        1 => { op: method(:op_1), inc: 4 },
        2 => { op: method(:op_2), inc: 4 }
      }

      @program = program
      @output = []
    end

    def compute(opts = {})
      i = 0

      loop do
        operation = @program[i]

        break unless @operations.key?(operation)

        @operations.dig(operation, :op).call(i, opts)

        i += @operations.dig(operation, :inc)
      end

      @program
    end

    def op_1(position, _)
      @program[@program[position + 3]] = @program[@program[position + 1]] +
        @program[@program[position + 2]]
    end

    def op_2(position, _)
      @program[@program[position + 3]] = @program[@program[position + 1]] *
        @program[@program[position + 2]]
    end
  end
end
