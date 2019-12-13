require_relative './lib/printer.rb'

module Solvers
  class Solver8
    def solve_a(input, opts = {})
      width = opts.fetch(:width, 25)
      height = opts.fetch(:height, 6)

      input = input.first.chomp.split('').map(&:to_i)

      least_zeros = 100_000_000
      answer = -1

      input.each_slice(width * height) do |layer|
        zero_count = layer.select(&:zero?).count

        next if zero_count >= least_zeros

        least_zeros = zero_count
        answer = layer.select{ |x| x == 1 }.count *
          layer.select{ |x| x == 2 }.count
      end

      answer
    end

    def solve_b(input, opts = {})
      print = opts.fetch(:print, true)
      width = opts.fetch(:width, 25)
      height = opts.fetch(:height, 6)

      input = input.first.chomp.split('').map(&:to_i)

      answer = Array.new(width * height, 2)

      input.each_slice(width * height) do |layer|
        (width * height).times do |index|
          next unless answer[index] == 2

          answer[index] = layer[index]
        end
      end

      Helpers::Printer::grid_print(answer, width) if print
      answer.join('')
    end
  end
end
