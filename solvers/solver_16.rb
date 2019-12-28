module Solvers
  class Solver16
    PATTERN = [0, 1, 0, -1].freeze

    def solve_a(input, opts = {})
      input = input.first.chomp

      phases = opts.fetch(:phases, 100)

      input = fft(input, phases)

      input[0..7]
    end

    def solve_b(input, _opts = {})
      input = input.first.chomp

      solution_offset = input[0..6].to_i

      long_input = ''

      10_000.times do
        long_input << input
      end

      input = fft(long_input, 100, solution_offset)

      input[solution_offset..solution_offset + 7]
    end

    def fft(input, phases, solution_offset = 0)
      phases.times do
        output = ''

        solution_offset.times do
          output << 0
        end

        output << fft_first_half(input, solution_offset)

        output << fft_second_half(input, solution_offset)

        input = output
      end

      input
    end

    def fft_first_half(input, solution_offset)
      output = ''

      ((input.length / 2) - solution_offset).times do |temp_offset|
        offset = temp_offset + solution_offset

        value = 0

        (input.length - solution_offset).times do |character_temp_offset|
          character = character_temp_offset + solution_offset

          next if character < offset

          multiplier = PATTERN[((character + 1) / (offset + 1)) % 4]

          value += input[character].to_i * multiplier
        end

        output << (value.abs % 10).to_s
      end

      output
    end

    def fft_second_half(input, solution_offset)
      second_half_times = [
        input.length / 2,
        (input.length / 2) - (solution_offset - input.length / 2)
      ].min

      second_half = ''

      second_half_times.times do |offset_from_end|
        if offset_from_end.zero?
          second_half << input[-1]
          next
        end

        value = second_half[offset_from_end - 1].to_i
        value += input[(offset_from_end + 1) * -1].to_i
        second_half << (value % 10).to_s
      end

      second_half.reverse
    end
  end
end
