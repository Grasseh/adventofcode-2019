require_relative '../solvers/solver_0.rb'
require_relative './spec_helper.rb'
require 'pry'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver0 do
  before(:each) do
    @solver = Solvers::Solver0.new
  end

  context 'Problem A' do
    [
      ["(())", 0, 'returns the entrance on the wrapped parens'],
      ["()()", 0, 'returns the entrance on the pairs of parens'],
      ["(((", 3, 'gets up to the third floor if it just goes up'],
      ["(()(()(", 3, 'can go up and down to the third floor'],
      ["))(((((", 3, 'can go down first and then straight up to the third floor'],
      ["())", -1, 'can go up and then reach the basement'],
      ["))(", -1, 'can go down and up in the basement'],
      [")))", -3, 'can go straight to B3F'],
      [")())())", -3, 'can go to B3F by messing around'],
    ].each do |(input, expected, description)|
      it description do
        expect(@solver.solve_a(wrap_line_input(input))).to eq(expected)
      end
    end
  end

  context 'Problem B' do
    [
      [")", 1, 'returns the first move if he goes straight to the basement'],
      ["()())", 5, 'returns the fifth move if he messes around'],
    ].each do |(input, expected, description)|
      it description do
        expect(@solver.solve_b(wrap_line_input(input))).to eq(expected)
      end
    end
  end
end
