require_relative '../solvers/solver_4.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver4 do
  before(:each) do
    @solver = Solvers::Solver4.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(wrap_array_input(
        '111111',
        '111111'
      ))).to eq(1)
    end

    it 'solves the second example' do
      expect(@solver.solve_a(wrap_array_input(
        '223450',
        '223450'
      ))).to eq(0)
    end

    it 'solves the third example' do
      expect(@solver.solve_a(wrap_array_input(
        '123789',
        '123789'
      ))).to eq(0)
    end

    it 'works on a bigger range' do
      expect(@solver.solve_a(wrap_array_input(
        '123789',
        '124000'
      ))).to eq(5) # 123888, 123889, 123899, 123999, 123799
    end
  end

  context 'Problem B' do
    it 'solves the base example' do
      expect(@solver.solve_b(wrap_array_input(
        '112233',
        '112233'
      ))).to eq(1)
    end

    it 'solves the second example' do
      expect(@solver.solve_b(wrap_array_input(
        '123444',
        '123444'
      ))).to eq(0)
    end

    it 'solves the third example' do
      expect(@solver.solve_b(wrap_array_input(
        '111122',
        '111122'
      ))).to eq(1)
    end

    it 'works on a bigger range' do
      expect(@solver.solve_b(wrap_array_input(
        '123789',
        '124000'
      ))).to eq(3) # No 123888, Yes 123889, Yes 123899, No 123999, Yes 123799
    end
  end
end
