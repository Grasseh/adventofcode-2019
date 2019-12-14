require_relative '../solvers/solver_13.rb'
require_relative './spec_helper.rb'
require_relative '../solvers/lib/opcode.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver13 do
  before(:each) do
    @solver = Solvers::Solver13.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(
        wrap_line_input([
          '104,1,104,2,104,3,',
          '104,6,104,5,104,4,',
          '104,0,104,0,104,2,99'
        ].join('')),
        print: false
      )).to eq(1)
    end

    it 'returns the score' do
      expect(@solver.solve_b(
        wrap_line_input([
          '2,1,1,1,',
          '104,-1,104,0,104,3,',
          '104,6,104,5,104,4,',
          '104,6,104,4,104,3,',
          '104,6,104,3,104,2,',
          '104,6,104,2,104,1,',
          '3,1,',
          '104,-1,104,0,104,9,',
          '104,0,104,1,104,0,99'
        ].join('')),
        print: false
      )).to eq(9)
    end
  end
end
