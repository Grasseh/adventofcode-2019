require_relative '../solvers/solver_3.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver3 do
  before(:each) do
    @solver = Solvers::Solver3.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(wrap_array_input(
        'R8,U5,L5,D3',
        'U7,R6,D4,L4'
      ))).to eq(6)
    end

    it 'solves the second example' do
      expect(@solver.solve_a(wrap_array_input(
        'R75,D30,R83,U83,L12,D49,R71,U7,L72',
        'U62,R66,U55,R34,D71,R55,D58,R83'
      ))).to eq(159)
    end

    it 'solves the third example' do
      expect(@solver.solve_a(wrap_array_input(
        'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
        'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
      ))).to eq(135)
    end
  end

  context 'Problem B' do
    it 'solves the base example' do
      expect(@solver.solve_b(wrap_array_input(
        'R8,U5,L5,D3',
        'U7,R6,D4,L4'
      ))).to eq(30)
    end

    it 'solves the second example' do
      expect(@solver.solve_b(wrap_array_input(
        'R75,D30,R83,U83,L12,D49,R71,U7,L72',
        'U62,R66,U55,R34,D71,R55,D58,R83'
      ))).to eq(610)
    end

    it 'solves the third example' do
      expect(@solver.solve_b(wrap_array_input(
        'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
        'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
      ))).to eq(410)
    end
  end
end
