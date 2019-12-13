module Helpers
  module Printer
    def self.grid_print(grid, width)
      white = '▓'
      black = '░'

      grid.each_slice(width) do |line|
        string = ''

        line.each do |char|
          string += char.zero? ? black : white
        end

        puts string
      end
    end

    def self.grid_print_hash(grid)
      white = '▓'
      black = '░'

      min_x, _ = grid.min_by { |key, _| key.first }
      max_x, _ = grid.max_by { |key, _| key.first }
      min_y, _ = grid.min_by { |key, _| key.last }
      max_y, _ = grid.max_by { |key, _| key.last }

      (min_y.last..max_y.last).reverse_each do |y|
        string = ''

        (min_x.first..max_x.first).each do |x|
          string += grid[[x, y]].nil? || grid[[x, y]].zero? ? black : white
        end

        puts string
      end
      puts '====='
    end

    def self.convert_grid_custom(grid, values)
      min_x, _ = grid.min_by { |key, _| key.first }
      max_x, _ = grid.max_by { |key, _| key.first }
      min_y, _ = grid.min_by { |key, _| key.last }
      max_y, _ = grid.max_by { |key, _| key.last }

      arr = []

      (min_y.last..max_y.last).reverse_each do |y|
        string = ''

        (min_x.first..max_x.first).each do |x|
          string += values[grid[[x, y]] || 0].split('').sample
        end

        arr << string
      end

      arr
    end
  end
end
