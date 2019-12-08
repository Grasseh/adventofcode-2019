require_relative '../solvers/solver_8.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver8 do
  before(:each) do
    @solver = Solvers::Solver8.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(
        wrap_line_input('123456789012'),
        width: 3,
        height: 2
      )).to eq(1)
    end
  end

  context 'Problem B' do
    it 'solves the base example' do
      expect(@solver.solve_b(
        wrap_line_input('0222112222120000'),
        print: false,
        height: 2,
        width: 2
      )).to eq('0110')
    end
  end
end
