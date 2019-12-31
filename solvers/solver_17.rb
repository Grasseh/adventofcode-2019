require_relative 'lib/opcode.rb'
require_relative './lib/printer.rb'
require 'curses'

module Solvers
  class Solver17
    SCAFFOLD = 35
    VOID = 46
    NEW_LINE = 10

    UP = 94
    DOWN = 118
    LEFT = 60
    RIGHT = 62

    def solve_a(input, opts = {})
      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)

      grid = build_map(computer, opts)

      calculate_alignment(grid)
    end

    def solve_b(input, opts = {})
      # Curses.init_screen if opts.fetch(:print, true)

      @output = []

      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)

      grid = build_map(computer, opts)

      input[0] = 2

      computer = Helpers::OpcodeComputer.new(input)

      input = [
        "A,B,B,C,C,A,B,B,C,A\n",
        "R,4,R,12,R,10,L,12\n",
        "L,12,R,4,R,12\n",
        "L,12,L,8,R,10\n",
        "n\n"
      ].join.split('').map(&:ord)

      computer.resume(input: input)

      output = computer.output

      puts output[0..-2].map(&:chr).join('') if opts.fetch(:print, true)

      output.last
    end

    def print_map(grid)
      lines = Helpers::Printer.convert_grid_custom(
        grid,
        {
          SCAFFOLD => '░',
          VOID => '.',
          RIGHT => '→',
          LEFT => '←',
          UP => '↑',
          DOWN => '↓',
        },
        46
      )

      lines.reverse.each_with_index do |line, index|
        Curses.setpos(index, 0)
        Curses.addstr(line)
      end

      Curses.refresh
    end

    def build_map(computer, opts)
      grid = {}
      x = 0
      y = 0

      computer.compute

      computer.output.each do |output|
        if output == NEW_LINE
          x = 0
          y += 1
          next
        end

        if y >= 60
          @output << output
          y += 1
          next
        end

        grid[[x, y]] = output
        x += 1
      end

      grid
    end

    def calculate_alignment(grid)
      grid.reduce(0) do |acc, (position, value)|
        x = position.first
        y = position.last

        next(acc) unless value == SCAFFOLD

        if grid[[x - 1, y]] == SCAFFOLD &&
           grid[[x + 1, y]] == SCAFFOLD &&
           grid[[x, y + 1]] == SCAFFOLD &&
           grid[[x, y + 1]] == SCAFFOLD
          acc += x * y
        end

        acc
      end
    end
  end
end
