require_relative '../solvers/solver_5.rb'
require_relative './spec_helper.rb'
require_relative '../solvers/lib/opcode.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver5 do
  before(:each) do
    @solver = Solvers::Solver5.new
  end

  context 'Problem A' do
  end

  context 'Problem B' do
  end

  context '#computer' do
    it 'Opcode 3 takes an input and stores it at the following index' do
      expect(
        Helpers::OpcodeComputer
          .new('3,6,99,0,0,0,0'.split(',').map(&:to_i))
          .compute(input: 12)
      ).to eq([3, 6, 99, 0, 0, 0, 12])
    end

    it 'Opcode 4 stoers the value at an index into an output getter' do
      computer = Helpers::OpcodeComputer
        .new('4,3,99,13'.split(',').map(&:to_i))
      computer.compute
      expect(computer.output).to eq([13])
    end
  end
end
