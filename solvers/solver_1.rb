module Solvers
  class Solver1
    def solve_a(input, _opts = {})
      input = input.map(&:chomp).map(&:to_i)

      input.reduce(0){ |sum, line| sum + calculate_mass(line) }
    end

    def solve_b(input, _opts = {})
      input = input.map(&:chomp).map(&:to_i)

      input.reduce(0){ |sum, line| sum + calculate_fuel(line) }
    end

    private

    def calculate_mass(line)
      (line / 3) - 2
    end

    def calculate_fuel(line)
      required = calculate_mass(line)

      return 0 if required <= 0

      required + calculate_fuel(required)
    end
  end
end
