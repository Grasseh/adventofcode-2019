require_relative 'lib/opcode.rb'
require_relative './lib/printer.rb'
require 'curses'

module Solvers
  class Solver15
    NORTH = 1
    SOUTH = 2
    WEST = 3
    EAST = 4

    UP = 0
    RIGHT = 1
    DOWN = 2
    LEFT = 3

    WALL = 0
    EMPTY = 1
    OXYGEN = 2

    def solve_a(input, opts = {})
      opts[:print] = false # We print in part two anyways ^^

      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)

      grid = build_map(computer, opts)

      oxygen_supply = grid.select{ |_, val| val == 2 }.keys.first

      a_star(grid, [0, 0], oxygen_supply).first
    end

    def solve_b(input, opts = {})
      Curses.init_screen if opts.fetch(:print, true)

      input = input.first.chomp.split(',').map(&:to_i)

      computer = Helpers::OpcodeComputer.new(input)

      grid = build_map(computer, opts)

      oxygen_supply = grid.select{ |_, val| val == 2 }.keys.first

      oxygenate(grid, oxygen_supply, opts)
    ensure
      Curses.close_screen if opts.fetch(:print, true)
    end

    def print_map(arr)
      arr.each_with_index do |line, index|
        Curses.setpos(index, 0)
        Curses.addstr(line)
      end

      Curses.refresh
    end

    def build_map(computer, opts)
      @grid = { [0, 0] => 1 }

      @stack = [{
        position: [0, 0],
        to_visit: [NORTH, EAST, SOUTH, WEST],
        previous: nil
      }]

      loop do
        if @stack.last.dig(:to_visit).empty?
          current = @stack.pop

          break if current.dig(:previous).nil?

          move(computer, current.dig(:previous))

          next
        end

        direction = @stack.last.dig(:to_visit).shift

        cell_to_visit = calculate_position(
          @stack.last.dig(:position),
          direction
        )

        next if @grid.key?(cell_to_visit)

        cell_content = move(computer, direction)

        @grid[cell_to_visit] = cell_content

        unless cell_content.zero?
          @stack << {
            position: cell_to_visit,
            to_visit: [NORTH, EAST, SOUTH, WEST],
            previous: opposite_direction(direction)
          }
        end

        next unless opts.fetch(:print, true)

        print_map(
          Helpers::Printer.convert_grid_custom(
            @grid,
            ['█', ' ', 'x', '░'],
            3
          )
        )
      end

      @grid
    end

    def move(computer, direction)
      computer.resume(input: [direction])
      computer.output.first
    end

    def calculate_position(cell, movement)
      x = cell.first
      y = cell.last

      x = if movement == EAST
        x + 1
      elsif movement == WEST
        x - 1
      else
        x
      end

      y = if movement == NORTH
        y + 1
      elsif movement == SOUTH
        y - 1
      else
        y
      end

      [x, y]
    end

    def opposite_direction(direction)
      opposites = {
        NORTH => SOUTH,
        SOUTH => NORTH,
        EAST => WEST,
        WEST => EAST,
      }

      opposites[direction]
    end

    def a_star(grid, start, goal)
      to_visit_queue = { start => 0 } # Ruby has no PriorityQueue so eh
      path_to = { start => nil }
      cost_to = { start => 0 }

      until to_visit_queue.empty?
        current = to_visit_queue.min_by{ |_k, val| val}
        current_position = current.first
        to_visit_queue.delete(current_position)

        break if grid[current_position] == OXYGEN

        find_adjacent(current_position, grid).each do |adjacent|
          cost_to_move_to_adjacent = cost_to[current_position] + 1

          if !cost_to.keys.include?(adjacent) ||
             cost_to_move_to_adjacent < cost_to[adjacent]
            cost_to[adjacent] = cost_to_move_to_adjacent
            heuristic = cost_to_move_to_adjacent + manhattan(goal, adjacent)
            to_visit_queue[adjacent] = heuristic
            path_to[adjacent] = current_position
          end
        end
      end

      [cost_to[goal]]
    end

    def manhattan(a, b)
      (a.first - b.first).abs + (a.last - b.last).abs
    end

    def find_adjacent(current, grid)
      adjacent = [
        [current.first + 1, current.last],
        [current.first - 1, current.last],
        [current.first, current.last + 1],
        [current.first, current.last - 1],
      ]

      adjacent.reject{ |x| grid[x].zero? }
    end

    # Breadth wide search wooooo
    def oxygenate(grid, oxygen_supply, opts)
      to_visit_queue = [oxygen_supply]
      next_minute_queue = []
      i = 0

      while !to_visit_queue.empty? || !next_minute_queue.empty?
        if to_visit_queue.empty?
          to_visit_queue = next_minute_queue
          next_minute_queue = []

          i += 1

          if opts.fetch(:print, true)
            print_map(
              Helpers::Printer.convert_grid_custom(
                grid,
                ['█', ' ', 'x', '░'],
                3
              )
            )
          end
        end

        current_position = to_visit_queue.shift

        find_adjacent(current_position, grid).each do |adjacent|
          next_minute_queue << adjacent unless grid[adjacent] == OXYGEN
          grid[adjacent] = OXYGEN
        end
      end

      i
    end
  end
end
