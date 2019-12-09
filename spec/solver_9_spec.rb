require_relative '../solvers/solver_9.rb'
require_relative './spec_helper.rb'
require_relative '../solvers/lib/opcode.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver9 do
  before(:each) do
    @solver = Solvers::Solver9.new
  end

  context 'Problem A' do
    it 'uses an input of 1 to get the last output' do
      expect(@solver.solve_a(wrap_line_input('109,1,204,-1,99')))
        .to eq(109)
    end
  end

  context '#computer' do
    it 'Supports Relative positions' do
      computer = Helpers::OpcodeComputer.new(
        '109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99'
        .split(',')
        .map(&:to_i)
      )

      computer.compute

      expect(computer.output).to eq([
        109, 1, 204, -1, 1001, 100, 1, 100, 1008, 100, 16, 101, 1006, 101, 0, 99
      ])
    end

    it 'Supports fat numbers' do
      computer = Helpers::OpcodeComputer.new(
        '1102,34915192,34915192,7,4,7,99,0'
        .split(',')
        .map(&:to_i)
      )

      computer.compute

      expect(computer.output.first.to_s.length).to eq(16)
    end

    it 'Actually returns the right fat number' do
      computer = Helpers::OpcodeComputer.new(
        '104,1125899906842624,99'
        .split(',')
        .map(&:to_i)
      )

      computer.compute

      expect(computer.output.first).to eq(1125899906842624)
    end
  end
end
