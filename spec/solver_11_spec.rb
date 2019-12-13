require_relative '../solvers/solver_11.rb'
require_relative './spec_helper.rb'
require_relative '../solvers/lib/opcode.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver11 do
  before(:each) do
    @solver = Solvers::Solver11.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(
        wrap_line_input([
          '3,100,104,1,104,0,',
          '3,101,104,0,104,0,',
          '3,102,104,1,104,0,',
          '3,103,104,1,104,0,',
          '3,104,104,0,104,1,',
          '3,105,104,1,104,0,',
          '3,106,104,1,104,0,99'
        ].join('')),
        print: false
      )).to eq(6)
    end
  end

  context 'Problem B' do
    it 'solves the base example' do
      expect(@solver.solve_a(
        wrap_line_input([
          '3,100,104,1,104,0,',
          '3,101,104,0,104,0,',
          '3,102,104,1,104,0,',
          '3,103,104,1,104,0,',
          '3,104,104,0,104,1,',
          '3,105,104,1,104,0,',
          '3,106,104,1,104,0,99'
        ].join('')),
        print: false
      )).to eq(6)
    end
  end
end
