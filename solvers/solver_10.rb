module Solvers
  class Solver10
    attr_accessor :visited
    def solve_a(input, _opts = {})
      grid = build_grid(input)

      min_x, _ = grid.min_by { |key, _| key.first }
      max_x, _ = grid.max_by { |key, _| key.first }
      min_y, _ = grid.min_by { |key, _| key.last }
      max_y, _ = grid.max_by { |key, _| key.last }

      most_visible = get_station(grid, min_x, max_x, min_y, max_y)

      calculate_visible_asteroids(
        grid,
        min_x.first,
        max_x.first,
        min_y.last,
        max_y.last,
        most_visible.first
      )
    end

    def solve_b(input, opts = {})
      grid = build_grid(input)
      goal = opts.fetch(:goal, 200)
      vaporized = 0

      min_x, _ = grid.min_by { |key, _| key.first }
      max_x, _ = grid.max_by { |key, _| key.first }
      min_y, _ = grid.min_by { |key, _| key.last }
      max_y, _ = grid.max_by { |key, _| key.last }

      most_visible = get_station(grid, min_x, max_x, min_y, max_y)

      station = most_visible.first

      loop do
        count = calculate_visible_asteroids(
          grid,
          min_x.first,
          max_x.first,
          min_y.last,
          max_y.last,
          most_visible.first
        )

        asteroids_to_vaporise_this_round = @visited

        if count + vaporized < goal
          asteroids_to_vaporise_this_round.each do |key|
            grid[key.first] = 0
          end

          vaporized += count
        else
          giggles = asteroids_to_vaporise_this_round.map do |ast|
            x = ast.first.first
            y = ast.first.last
            [
              ast.first,
              Math.atan2(
                x - station.first,
                y - station.last
              )
            ]
          end.sort do |a, b|
            b.last <=> a.last
          end

          giggles.each do |destroyed|
            vaporized += 1
            if vaporized == goal
              return destroyed.first.first * 100 + destroyed.first.last
            end
          end
        end
      end
    end

    def get_station(grid, min_x, max_x, min_y, max_y)
      grid.max_by do |key, _|
        next -1 if grid[[key.first, key.last]].zero?

        calculate_visible_asteroids(
          grid,
          min_x.first,
          max_x.first,
          min_y.last,
          max_y.last,
          key
        )
      end
    end

    def build_grid(input)
      grid = {}

      input.each_with_index do |line, y|
        line.chomp.each_char.with_index do |char, x|
          grid[[x, y]] = char == '#' ? 1 : 0
        end
      end

      grid
    end

    def calculate_visible_asteroids(grid, min_x, max_x, min_y, max_y, key)
      x = key.first
      y = key.last
      @visited = []

      count = 0

      count_asteroid_in_direction = ->(small_y, big_y, small_x, big_x, count_zero){
        (small_y..big_y).each do |y|
          (small_x..big_x).each do |x|
            count += 1 if empty_between(grid, x, y, key.first, key.last, count_zero)
            @visited << [[x, y]] if empty_between(grid, x, y, key.first, key.last, count_zero)
          end
        end
      }

      count_asteroid_in_direction.call(min_y, y, min_x, x, true)
      count_asteroid_in_direction.call(min_y, y, x, max_x, false)
      count_asteroid_in_direction.call(y, max_y, min_x, x, false)
      count_asteroid_in_direction.call(y, max_y, x, max_x, true)

      count
    end

    def empty_between(grid, x1, y1, x2, y2, count_zero)
      small_x, big_x = [x1, x2].sort
      small_y, big_y = [y1, y2].sort

      return false if grid[[x1, y1]].zero?
      return false if grid[[x2, y2]].zero?
      return false if x1 == x2 && count_zero
      return false if y1 == y2 && count_zero
      return false if [x1, y1] == [x2, y2]

      divisor = (small_x - big_x).gcd(big_y - small_y)

      valid = true

      x_step = (x2 - x1) / divisor
      y_step = (y2 - y1) / divisor

      (divisor - 1).times do |i|
        valid &&= grid[[
          x1 + (i + 1) * x_step,
          y1 + (i + 1) * y_step
        ]].zero?
      end

      valid
    end
  end
end
