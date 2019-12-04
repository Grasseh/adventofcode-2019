require_relative '../solvers/solver_1.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver1 do
  before(:each) do
    @solver = Solvers::Solver1.new
  end

  context 'Problem A' do
    it 'calculates one data correctly' do
      expect(@solver.solve_a(wrap_array_input(12))).to eq(2)
    end

    it 'calculates the sum correctly' do
      expect(@solver.solve_a(wrap_array_input(12, 14, 1969, 100_756)))
        .to eq(34_241)
    end
  end

  context 'Problem B' do
    it 'calculates one data correctly' do
      expect(@solver.solve_b(wrap_array_input(12))).to eq(2)
    end

    it 'calculates a bigger data correctly' do
      expect(@solver.solve_b(wrap_array_input(1969))).to eq(966)
    end

    it 'calculates the sum correctly' do
      expect(@solver.solve_b(wrap_array_input(12, 14, 1969, 100_756)))
        .to eq(51_316)
    end
  end
end
