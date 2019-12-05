module Helpers
  class OpcodeComputer
    attr_accessor :output

    def initialize(program)
      @operations = {
        1 => { op: method(:op_1), inc: 4 },
        2 => { op: method(:op_2), inc: 4 },
        3 => { op: method(:op_3), inc: 2 },
        4 => { op: method(:op_4), inc: 2 }
      }

      @program = program
      @output = []
    end

    def compute(opts = {})
      i = 0

      loop do
        operation, modes = parse_command(@program[i])

        break unless @operations.key?(operation)

        @operations.dig(operation, :op).call(i, modes, opts)

        i += @operations.dig(operation, :inc)
      end

      @program
    end

    def parse_command(command)
      # The integer here should be the highest amount of parameters an op
      # can take + 1
      justified_command = command.to_s.rjust(5, '0')

      operation = justified_command[-2..-1]
      modes = justified_command[0..-3].split('').reverse.map(&:to_i)

      [operation.to_i, modes]
    end

    def get_value_at(position, mode)
      if mode.zero?
        @program[@program[position]]
      else
        @program[position]
      end
    end

    def op_1(position, modes, _opts)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])

      @program[@program[position + 3]] = a + b
    end

    def op_2(position, modes, _opts)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])

      @program[@program[position + 3]] = a * b
    end

    def op_3(position, _modes, opts)
      @program[@program[position + 1]] = opts.fetch(:input)
    end

    def op_4(position, modes, _)
      a = get_value_at(position + 1, modes[0])

      @output << a
    end
  end
end
