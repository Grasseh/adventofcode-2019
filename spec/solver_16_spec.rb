require_relative '../solvers/solver_16.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver16 do
  before(:each) do
    @solver = Solvers::Solver16.new
  end

  context 'Problem A' do
    it 'solves the mini example' do
      expect(@solver.solve_a(
        wrap_line_input(
          12_345_678
        ),
        phases: 4
      )).to eq('01029498')
    end

    it 'solves the base example' do
      expect(@solver.solve_a(
        wrap_line_input(
          80_871_224_585_914_546_619_083_218_645_595
        )
      )).to eq('24176176')
    end

    it 'solves the second example' do
      expect(@solver.solve_a(
        wrap_line_input(
          19_617_804_207_202_209_144_916_044_189_917
        )
      )).to eq('73745418')
    end

    it 'solves the third example' do
      expect(@solver.solve_a(
        wrap_line_input(
          69_317_163_492_948_606_335_995_924_319_873
        )
      )).to eq('52432133')
    end
  end

  context 'Problem B' do
    it 'solves the base example' do
      expect(@solver.solve_b(
        wrap_line_input(
          '03036732577212944063491565474664'
        )
      )).to eq('84462026')
    end

    it 'solves the second example' do
      expect(@solver.solve_b(
        wrap_line_input(
          '02935109699940807407585447034323'
        )
      )).to eq('78725270')
    end

    it 'solves the third example' do
      expect(@solver.solve_b(
        wrap_line_input(
          '03081770884921959731165446850517'
        )
      )).to eq('53553731')
    end
  end
end
