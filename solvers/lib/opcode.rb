module Helpers
  class OpcodeComputer
    RUNNING_STATE = 0
    WAIT_STATE = 1
    HALT_STATE = 99

    attr_accessor :output
    attr_accessor :state

    def initialize(program)
      @operations = {}

      8.times do |i|
        index = i + 1
        @operations[index] = method("op_#{index}".to_sym)
      end

      @base_program = program
    end

    def compute(opts = {})
      @pointer = 0
      @relative_pointer = 0
      @program = @base_program.dup
      @output = []
      @input = []
      @opts = opts
      @state = RUNNING_STATE

      resume(opts)

      @program
    end

    def resume(opts = {})
      @input.concat(opts.fetch(:input, [])).flatten!
      @output = []
      @state = RUNNING_STATE

      loop do
        operation, modes = parse_command(@program[@pointer])

        @state = HALT_STATE unless @operations.key?(operation)
        break unless @state == RUNNING_STATE

        @operations.dig(operation).call(@pointer, modes, @opts)
        break unless @state == RUNNING_STATE
      end
    end

    def parse_command(command)
      justified_command = command.to_s.rjust(5, '0')

      operation = justified_command[-2..-1]
      modes = justified_command[0..-3].split('').reverse.map(&:to_i)

      [operation.to_i, modes]
    end

    def get_value_at(position, mode)
      if mode.zero?
        @program[@program[position]]
      elsif mode == 1
        @program[position]
      elsif mode == 2
        @program[@relative_pointer + position]
      end
    end

    def set_value_at(position, mode, value)
      if mode.zero? || mode == 1
        @program[@program[position]] = value
      else
        @program[@relative_pointer + position] = value
      end
    end

    def op_1(position, modes, _opts)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])
      set_value_at(position + 3, modes[2], a + b)

      @pointer += 4
    end

    def op_2(position, modes, _opts)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])
      set_value_at(position + 3, modes[2], a * b)

      @pointer += 4
    end

    def op_3(position, modes, _opts)
      @state = WAIT_STATE if @input.empty?
      return if @input.empty?

      set_value_at(position + 1, modes[0], @input.shift)

      @pointer += 2
    end

    def op_4(position, modes, _)
      a = get_value_at(position + 1, modes[0])

      @output << a

      @pointer += 2
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
      set_value_at(position + 3, modes[2], a < b ? 1 : 0)

      @pointer += 4
    end

    def op_8(position, modes, _)
      a = get_value_at(position + 1, modes[0])
      b = get_value_at(position + 2, modes[1])
      set_value_at(position + 3, modes[2], a == b ? 1 : 0)

      @pointer += 4
    end
  end
end
