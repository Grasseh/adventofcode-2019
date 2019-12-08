module Solvers
  class Solver4
    def solve_a(input, _)
      min = input.first.chomp.to_i
      max = input[1].chomp.to_i

      get_valid_passwords(min, max).count
    end

    def solve_b(input, _)
      min = input.first.chomp.to_i
      max = input[1].chomp.to_i

      get_valid_passwords(min, max, true).count
    end

    def get_valid_passwords(min, max, multiple = false)
      valid = []

      (min..max).each do |i|
        no_dec = true
        pairs = false
        number_string = i.to_s.rjust(6, '0')
        index = 0

        while index < number_string.length - 1
          if number_string[index] > number_string[index + 1]
            no_dec = false
            break
          end

          if !multiple
            pairs ||= number_string[index] == number_string[index + 1]
            index += 1
          else
            count = 1

            while count + index < number_string.length &&
                number_string[index] == number_string[index + count]
              count += 1
            end

            pairs ||= count == 2
            index += (count - 1).positive? ? count - 1 : 1
          end
        end

        valid << i if no_dec && pairs
      end

      valid
    end
  end
end
