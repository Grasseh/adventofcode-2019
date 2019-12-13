require_relative 'lib/opcode.rb'
require_relative './lib/printer.rb'

module Solvers
  class Solver11
    UP = 0
    RIGHT = 1
    DOWN = 2
    LEFT = 3

    def solve_a(input, opts = {})
      input = input.first.chomp.split(',').map(&:to_i)

      run_robot(0, input, opts)
    end

    def solve_b(input, opts = {})
      input = input.first.chomp.split(',').map(&:to_i)

      run_robot(1, input, opts)
    end

    def run_robot(start_value, input, opts)
      computer = Helpers::OpcodeComputer.new(input)
      grid = {[0, 0] => start_value}
      painted = []
      x = 0
      y = 0
      facing = UP

      computer.compute(input: [start_value])

      loop do
        color = computer.output.first
        direction = computer.output.last

        # Paint, Turn, Move
        unless color == grid[[x, y]]
          painted << [x, y] unless painted.include?([x, y])
          grid[[x, y]] = color
        end

        facing = if direction.zero?
          (facing - 1) % 4
        else
          (facing + 1) % 4
        end

        x = if facing == RIGHT
          x + 1
        elsif facing == LEFT
          x - 1
        else
          x
        end

        y = if facing == UP
          y + 1
        elsif facing == DOWN
          y - 1
        else
          y
        end

        break if computer.state == Helpers::OpcodeComputer::HALT_STATE

        color = grid[[x,y]] || 0

        computer.resume(input: [color])
      end

      Helpers::Printer.grid_print_hash(grid) if opts.fetch(:print, true)
      painted.count
    end
  end
end
