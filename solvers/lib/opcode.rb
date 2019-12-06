module Helpers
  class OpcodeComputer
    attr_accessor :output

    def initialize(program)
      @operations = {}

      8.times do |i|
        index = i + 1
        @operations[index] = method("op_#{index}".to_sym)
      end

      @pointer = 0
      @program = program
      @output = []
    end

    def compute(opts = {})
      @pointer = 0

      loop do
        operation, modes = parse_command(@program[@pointer])

        break unless @operations.key?(operation)

        @operations.dig(operation).call(@pointer, modes, opts)
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

      @pointer += 4

      @program[@program[position + 3]] = a + b
    end

    def op_2(position, modes, _opts)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])

      @pointer += 4

      @program[@program[position + 3]] = a * b
    end

    def op_3(position, _modes, opts)
      @pointer += 2

      @program[@program[position + 1]] = opts.fetch(:input)
    end

    def op_4(position, modes, _)
      @pointer += 2

      a = get_value_at(position + 1, modes[0])

      @output << a
    end

    def op_5(position, modes, _)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])

      if !a.zero?
        @pointer = b
      else
        @pointer += 3
      end
    end

    def op_6(position, modes, _)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])

      if a.zero?
        @pointer = b
      else
        @pointer += 3
      end
    end

    def op_7(position, modes, _)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])

      @program[@program[position + 3]] = a < b ? 1 : 0

      @pointer += 4
    end

    def op_8(position, modes, _)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])

      @program[@program[position + 3]] = a == b ? 1 : 0

      @pointer += 4
    end
  end
end
