require_relative '../solvers/solver_15.rb'
require_relative './spec_helper.rb'
require_relative '../solvers/lib/opcode.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver15 do
  before(:each) do
    @solver = Solvers::Solver15.new
  end
  #   ##
  #  #..#
  # #D.#
  #  ##

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(
        wrap_line_input([
          '3, 1, 104, 0,',
          '3, 1, 104, 1,',
          '3, 1, 104, 0,',
          '3, 1, 104, 0,',
          '3, 1, 104, 0,',
          '3, 1, 104, 1,',
          '3, 1, 104, 1,',
          '3, 1, 104, 0,',
          '3, 1, 104, 2,',
          '3, 1, 104, 0,',
          '3, 1, 104, 0,',
          '3, 1, 104, 0,',
          '3, 1, 104, 1,',
          '3, 1, 104, 1,',
        ].join('')),
        print: false
      )).to eq(2)
    end
  end

  #  ##
  # #..##
  # #.#..#
  # #.O.#
  #  ###
  context 'Problem B' do
    it 'fills the grid with air in minutes' do
      grid = {
        [0, 0] => 1,
        [1, 0] => 1,
        [0, -1] => 1,
        [-1, -1] => 2,
        [-2, -1] => 1,
        [-2, 0] => 1,
        [-2, 1] => 1,
        [-1, 1] => 1,
        [-2, 2] => 0,
        [-1, 2] => 0,
        [-3, 1] => 0,
        [0, 1] => 0,
        [1, 1] => 0,
        [-3, 0] => 0,
        [-1, 0] => 0,
        [2, 0] => 0,
        [-3, -1] => 0,
        [1, -1] => 0,
        [-2, -2] => 0,
        [-1, -2] => 0,
        [0, -2] => 0,
      }

      expect(@solver.oxygenate(grid, [-1, -1], { print: false })).to eq(4)
    end
  end
end
