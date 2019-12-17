require_relative '../solvers/solver_12.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver12 do
  before(:each) do
    @solver = Solvers::Solver12.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(
        wrap_array_input(
          '<x=-1, y=0, z=2>',
          '<x=2, y=-10, z=-7>',
          '<x=4, y=-8, z=8>',
          '<x=3, y=5, z=-1>'
        ),
        steps: 10
      )).to eq(179)
    end

    it 'solves the second example' do
      expect(@solver.solve_a(
        wrap_array_input(
          '<x=-8, y=-10, z=0>',
          '<x=5, y=5, z=10>',
          '<x=2, y=-7, z=3>',
          '<x=9, y=-8, z=-3>'
        ),
        steps: 100
      )).to eq(1940)
    end
  end

  context 'Problem B' do
    it 'solves the base example' do
      expect(@solver.solve_b(wrap_array_input(
        '<x=-1, y=0, z=2>',
        '<x=2, y=-10, z=-7>',
        '<x=4, y=-8, z=8>',
        '<x=3, y=5, z=-1>'
      ))).to eq(2772)
    end

    it 'solves the second example' do
      expect(@solver.solve_b(wrap_array_input(
        '<x=-8, y=-10, z=0>',
        '<x=5, y=5, z=10>',
        '<x=2, y=-7, z=3>',
        '<x=9, y=-8, z=-3>'
      ))).to eq(4_686_774_924)
    end
  end
end
