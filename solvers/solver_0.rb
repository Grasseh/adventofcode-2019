require('pry')
module Solvers
  class Solver0
    def solve_a(input)
      input = input.first.chomp
      input.count('(') - input.count(')')
    end

    def solve_b(input)
      input = input.first.chomp

      input.length.times do |i|
        return i + 1 if input[0..i].count(')') > input[0..i].count('(')
      end

      -1
    end
  end
end
