require_relative 'lib/opcode.rb'
require_relative './lib/printer.rb'

module Solvers
  class Solver13
    # 0 is an empty tile. No game object appears in this tile.
    # 1 is a wall tile. Walls are indestructible barriers.
    # 2 is a block tile. Blocks can be broken by the ball.
    # 3 is a horizontal paddle tile. The paddle is indestructible.
    # 4 is a ball tile. The ball moves diagonally and bounces off objects.
    EMPTY = 0
    WALL = 1
    BLOCK = 2
    PADDLE = 3
    BALL = 4


    def solve_a(input, opts = {})
      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)

      computer.compute

      build_map(computer.output, opts)
        .first
        .select{ |_, v| v == BLOCK }
        .count
    end

    def solve_b(input, opts = {})
      input = input.first.chomp.split(',').map(&:to_i)
      input[0] = 2

      computer = Helpers::OpcodeComputer.new(input)

      computer.compute

      score = 0
      grid = build_map(computer.output, opts).first

      loop do
        input = find_x(grid, BALL) <=> find_x(grid, PADDLE)

        computer.resume(input: [input])
        grid, new_score = build_map(computer.output, opts, grid)

        score = [score, new_score].max
        puts score

        break if computer.state == Helpers::OpcodeComputer::HALT_STATE
      end

      score
    end

    def build_map(output, opts, grid = {})
      score = 0

      output.each_slice(3) do |x, y, z|
        score = z if x == -1
        next if x == -1

        grid[[x, y]] = z
      end

      if opts.fetch(:print, true)
        Helpers::Printer.grid_print_custom(
          grid,
          [' ', '▓', '◧◨◩◪', '═', '■']
        )
      end

      [grid, score]
    end

    def find_x(grid, type)
      pos = grid
        .select{ |_, v| v == type }
        .first
        .first
        .first
    end
  end
end
