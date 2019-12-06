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
    it 'uses an input of 1 to get the last output' do
      expect(@solver.solve_a(wrap_line_input('3,4,104,0,0,0,1,9,104,0,99')))
        .to eq(7)
    end
  end

  context 'Problem B' do
    it 'uses an input of below 8' do
      expect(@solver.solve_a(wrap_line_input(
        [
          '3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,',
          '1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,',
          '999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99'
        ].join('')
      ))).to eq(999)
    end
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

    it 'Handles mode 1' do
      expect(
        Helpers::OpcodeComputer
          .new('1001,2,12,9,102,20,3,10,99,0,0'.split(',').map(&:to_i))
          .compute(input: 12)
      ).to eq([1001, 2, 12, 9, 102, 20, 3, 10, 99, 24, 180])
    end

    it 'handles mode 1 example' do
      expect(
        Helpers::OpcodeComputer
          .new('1002,4,3,4,33'.split(',').map(&:to_i))
          .compute
      ).to eq([1002, 4, 3, 4, 99])
    end

    it 'handles negatives' do
      expect(
        Helpers::OpcodeComputer
          .new('1101,100,-1,4,0'.split(',').map(&:to_i))
          .compute
      ).to eq([1101, 100, -1, 4, 99])
    end

    it 'checks if input equals 8 with position mode' do
      computer = Helpers::OpcodeComputer
        .new('3,9,8,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i))
      computer.compute(input: 8)
      expect(computer.output).to eq([1])

      computer = Helpers::OpcodeComputer
        .new('3,9,8,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i))
      computer.compute(input: 9)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,9,8,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i))
      computer.compute(input: 7)
      expect(computer.output).to eq([0])
    end

    it 'checks if input is less than 8 with position mode' do
      computer = Helpers::OpcodeComputer
        .new('3,9,7,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i))
      computer.compute(input: 8)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,9,7,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i))
      computer.compute(input: 9)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,9,7,9,10,9,4,9,99,-1,8'.split(',').map(&:to_i))
      computer.compute(input: 7)
      expect(computer.output).to eq([1])
    end

    it 'checks if input equals 8 with immediate mode' do
      computer = Helpers::OpcodeComputer
        .new('3,3,1108,-1,8,3,4,3,99'.split(',').map(&:to_i))
      computer.compute(input: 8)
      expect(computer.output).to eq([1])

      computer = Helpers::OpcodeComputer
        .new('3,3,1108,-1,8,3,4,3,99'.split(',').map(&:to_i))
      computer.compute(input: 9)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,3,1108,-1,8,3,4,3,99'.split(',').map(&:to_i))
      computer.compute(input: 7)
      expect(computer.output).to eq([0])
    end

    it 'checks if input is less than 8 with immediate mode' do
      computer = Helpers::OpcodeComputer
        .new('3,3,1107,-1,8,3,4,3,99'.split(',').map(&:to_i))
      computer.compute(input: 8)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,3,1107,-1,8,3,4,3,99'.split(',').map(&:to_i))
      computer.compute(input: 9)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,3,1107,-1,8,3,4,3,99'.split(',').map(&:to_i))
      computer.compute(input: 7)
      expect(computer.output).to eq([1])
    end

    it 'works with jump-mode in position mode' do
      computer = Helpers::OpcodeComputer
        .new('3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9'.split(',').map(&:to_i))
      computer.compute(input: 0)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9'.split(',').map(&:to_i))
      computer.compute(input: 12)
      expect(computer.output).to eq([1])
    end

    it 'works with jump-mode in immediate mode' do
      computer = Helpers::OpcodeComputer
        .new('3,3,1105,-1,9,1101,0,0,12,4,12,99,1'.split(',').map(&:to_i))
      computer.compute(input: 0)
      expect(computer.output).to eq([0])

      computer = Helpers::OpcodeComputer
        .new('3,3,1105,-1,9,1101,0,0,12,4,12,99,1'.split(',').map(&:to_i))
      computer.compute(input: 12)
      expect(computer.output).to eq([1])
    end
  end
end
