require_relative '../solvers/solver_6.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver6 do
  before(:each) do
    @solver = Solvers::Solver6.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(wrap_array_input(
        'COM)B',
        'B)C',
        'C)D',
        'D)E',
        'E)F',
        'B)G',
        'G)H',
        'D)I',
        'E)J',
        'J)K',
        'K)L'
      ))).to eq(42)
    end
  end

  context 'Problem B' do
    it 'solves the base example' do
      expect(@solver.solve_b(wrap_array_input(
        'COM)B',
        'B)C',
        'C)D',
        'D)E',
        'E)F',
        'B)G',
        'G)H',
        'D)I',
        'E)J',
        'J)K',
        'K)L',
        'K)YOU',
        'I)SAN'
      ))).to eq(4)
    end
  end
end
