module Solvers
  class Solver0
    def solve_a(input)
      input = input.first.chomp
      solution = input.count("(") - input.count(")")
    end

    def solve_b(input)
      input = input.first.chomp

      for i in 0..input.length - 1 do
        return i + 1 if input[0..i].count(")") > input[0..i].count("(")
      end

      -1
    end
  end
end
