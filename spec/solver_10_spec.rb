require_relative '../solvers/solver_10.rb'
require_relative './spec_helper.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver10 do
  before(:each) do
    @solver = Solvers::Solver10.new
  end

  context 'Problem A' do
    it 'solves the base example' do
      expect(@solver.solve_a(wrap_array_input(
        '.#..#',
        '.....',
        '#####',
        '....#',
        '...##',
      ))).to eq(8)
    end

    it 'solves the second example' do
      expect(@solver.solve_a(wrap_array_input(
        '......#.#.',
        '#..#.#....',
        '..#######.',
        '.#.#.###..',
        '.#..#.....',
        '..#....#.#',
        '#..#....#.',
        '.##.#..###',
        '##...#..#.',
        '.#....####',
      ))).to eq(33)
    end

    it 'solves the third example' do
      expect(@solver.solve_a(wrap_array_input(
        '#.#...#.#.',
        '.###....#.',
        '.#....#...',
        '##.#.#.#.#',
        '....#.#.#.',
        '.##..###.#',
        '..#...##..',
        '..##....##',
        '......#...',
        '.####.###.',
      ))).to eq(35)
    end

    it 'solves the fourth example' do
      expect(@solver.solve_a(wrap_array_input(
        '.#..#..###',
        '####.###.#',
        '....###.#.',
        '..###.##.#',
        '##.##.#.#.',
        '....###..#',
        '..#.#..#.#',
        '#..#.#.###',
        '.##...##.#',
        '.....#.#..',
      ))).to eq(41)
    end

    it 'solves the fifth example' do
      expect(@solver.solve_a(wrap_array_input(
        '.#..##.###...#######',
        '##.############..##.',
        '.#.######.########.#',
        '.###.#######.####.#.',
        '#####.##.#.##.###.##',
        '..#####..#.#########',
        '####################',
        '#.####....###.#.#.##',
        '##.#################',
        '#####.##.###..####..',
        '..######..##.#######',
        '####.##.####...##..#',
        '.#####..#.######.###',
        '##...#.##########...',
        '#.##########.#######',
        '.####.#.###.###.#.##',
        '....##.##.###..#####',
        '.#.#.###########.###',
        '#.#.#.#####.####.###',
        '###.##.####.##.#..##',
      ))).to eq(210)
    end
  end

  context 'Problem B' do
    it 'solves the fifth example' do
      expect(@solver.solve_b(wrap_array_input(
        '.#..##.###...#######',
        '##.############..##.',
        '.#.######.########.#',
        '.###.#######.####.#.',
        '#####.##.#.##.###.##',
        '..#####..#.#########',
        '####################',
        '#.####....###.#.#.##',
        '##.#################',
        '#####.##.###..####..',
        '..######..##.#######',
        '####.##.####...##..#',
        '.#####..#.######.###',
        '##...#.##########...',
        '#.##########.#######',
        '.####.#.###.###.#.##',
        '....##.##.###..#####',
        '.#.#.###########.###',
        '#.#.#.#####.####.###',
        '###.##.####.##.#..##',
      ))).to eq(802)
    end

    it 'solves the fifth example' do
      expect(@solver.solve_b(wrap_array_input(
        '.#..##.###...#######',
        '##.############..##.',
        '.#.######.########.#',
        '.###.#######.####.#.',
        '#####.##.#.##.###.##',
        '..#####..#.#########',
        '####################',
        '#.####....###.#.#.##',
        '##.#################',
        '#####.##.###..####..',
        '..######..##.#######',
        '####.##.####...##..#',
        '.#####..#.######.###',
        '##...#.##########...',
        '#.##########.#######',
        '.####.#.###.###.#.##',
        '....##.##.###..#####',
        '.#.#.###########.###',
        '#.#.#.#####.####.###',
        '###.##.####.##.#..##',
      ), goal: 299)).to eq(1101)
    end
  end

  context '#calculate_visible_asteroids' do
    it 'solves the first problem' do
      input = wrap_array_input(
        '.#..#',
        '.....',
        '#####',
        '....#',
        '...##'
      )

      grid = @solver.build_grid(input)

      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [1, 0]))
        .to eq(7)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [4, 0]))
        .to eq(7)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [0, 2]))
        .to eq(6)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [1, 2]))
        .to eq(7)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [2, 2]))
        .to eq(7)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [3, 2]))
        .to eq(7)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [4, 2]))
        .to eq(5)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [4, 3]))
        .to eq(7)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [3, 4]))
        .to eq(8)
      expect(@solver.calculate_visible_asteroids(grid, 0, 4, 0, 4, [4, 4]))
        .to eq(7)
    end

    it 'solves the line of sights example' do
      input = wrap_array_input(
        # '#.........',
        # '...A......',
        # '...B..a...',
        # '.EDCG....a',
        # '..F.c.b...',
        # '.....c....',
        # '..efd.c.gb',
        # '.......c..',
        # '....f...c.',
        # '...e..d..c'
        '#.........',
        '...#......',
        '...#..#...',
        '.####....#',
        '..#.#.#...',
        '.....#....',
        '..###.#.##',
        '.......#..',
        '....#...#.',
        '...#..#..#'
      )
      grid = @solver.build_grid(input)

      expect(@solver.calculate_visible_asteroids(grid, 0, 9, 0, 9, [0, 0]))
        .to eq(7)
    end

    it 'solves the fourth example' do
      input = wrap_array_input(
        '.#..#..###',
        '####.###.#',
        '....###.#.',
        '..###.##.#',
        '##.##.#.#.',
        '....###..#',
        '..#.#..#.#',
        '#..#.#.###',
        '.##...##.#',
        '.....#.#..',
      )

      grid = @solver.build_grid(input)

      expect(@solver.calculate_visible_asteroids(grid, 0, 9, 0, 9, [6, 3]))
        .to eq(41)
    end
  end

  context '#empty_between' do
    it 'should not fail in the corner like an idiot' do
      input = wrap_array_input(
        '.#..#..###',
        '####.###.#',
        '....###.#.',
        '..###.##.#',
        '##.##.#.#.',
        '....###..#',
        '..#.#..#.#',
        '#..#.#.###',
        '.##...##.#',
        '.....#.#..',
      )

      grid = @solver.build_grid(input)

      expect(@solver.empty_between(grid, 6, 3, 9, 0, true))
        .to eq(true)
    end
  end
end
