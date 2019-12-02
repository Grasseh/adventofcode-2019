require_relative '../solvers/solver_2.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver2 do
  before(:each) do
    @solver = Solvers::Solver2.new
  end

  context 'Problem A' do
    it 'changes the first two inputs to 12 and 2 and returns the first ine' do
      expect(@solver.solve_a(wrap_line_input('1,0,0,0,99,0,0,0,0,0,0,0,123')))
        .to eq(125)
    end
  end

  context 'Problem B' do
    it' Does 100 * Noun + Verb' do
      expect(@solver.solve_b(wrap_line_input(
        [1,0,0,9,2,9,10,0,99,0,984536,0,18].fill(999, 13..99).join(',')
      ))).to eq(1202)
    end
  end

  context '#computer' do
    it 'calculates one data correctly' do
      expect(
        @solver.compute('1,9,10,3,2,3,11,0,99,30,40,50'.split(',').map(&:to_i))
      ).to eq([3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50])
    end

    it 'changes the state correctly with a 1-code' do
      expect(@solver.compute('1,0,0,0,99'.split(',').map(&:to_i)))
        .to eq([2, 0, 0, 0, 99])
    end

    it 'changes the state correctly with a 2-code' do
      expect(@solver.compute('2,3,0,3,99'.split(',').map(&:to_i)))
        .to eq([2, 3, 0, 6, 99])
    end

    it 'changes the state correctly with something further' do
      expect(@solver.compute('2,4,4,5,99,0'.split(',').map(&:to_i)))
        .to eq([2, 4, 4, 5, 99, 9801])
    end

    it 'changes the state correctly with three commands' do
      expect(@solver.compute('1,1,1,4,99,5,6,0,99'.split(',').map(&:to_i)))
        .to eq('30,1,1,4,2,5,6,0,99'.split(',').map(&:to_i))
    end
  end

  context 'Problem B' do
  end
end
