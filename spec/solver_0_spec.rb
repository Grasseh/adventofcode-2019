require_relative '../solvers/solver_0.rb'

RSpec.describe Solvers::Solver0 do
  before(:each) do
    @solver = Solvers::Solver0.new
  end

  context 'Problem A' do
    it 'returns the entrance on the wrapped parens' do
      expect(@solver.solve_a(["(())\n"])).to eq(0)
    end

    it 'returns the entrance on the pairs of parens' do
      expect(@solver.solve_a(["()()\n"])).to eq(0)
    end

    it 'gets up to the third floor if it just goes up' do
      expect(@solver.solve_a(["(((\n"])).to eq(3)
    end

    it 'can go up and down to the third floor' do
      expect(@solver.solve_a(["(()(()(\n"])).to eq(3)
    end

    it 'can go down first and then straight up to the third floor' do
      expect(@solver.solve_a(["))(((((\n"])).to eq(3)
    end

    it 'can go up and then reach the basement' do
      expect(@solver.solve_a(["())\n"])).to eq(-1)
    end

    it 'can go down and up in the basement' do
      expect(@solver.solve_a(["))(\n"])).to eq(-1)
    end

    it 'can go straight to B3F' do
      expect(@solver.solve_a([")))\n"])).to eq(-3)
    end

    it 'can go to B3F by messing around' do
      expect(@solver.solve_a([")())())\n"])).to eq(-3)
    end
  end

  context 'Problem B' do
    it 'returns the first move if he goes straight to the basement' do
      expect(@solver.solve_b([")\n"])).to eq(1)
    end

    it 'returns the fifth move if he messes around' do
      expect(@solver.solve_b(["()())\n"])).to eq(5)
    end
  end
end
