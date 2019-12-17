require 'json'

module Solvers
  class Solver12
    def solve_a(input, opts = {})
      moons = parse_input(input)

      steps = opts.fetch(:steps, 1_000)

      steps.times do
        moons = calculate_velocity(moons)
        moons = calculate_positions(moons)
      end

      calculate_energy(moons)
    end

    def solve_b(input, _opts = {})
      moons = parse_input(input)

      i = 0

      lowest_periods = {}

      loop do
        moons = calculate_velocity(moons)
        moons = calculate_positions(moons)

        i += 1

        %i(x y z).each do |axis|
          if moons.all? do |moon|
            moon[:velocity][axis].zero?
          end
            lowest_periods[axis] ||= i
          end
        end

        break if lowest_periods.count == 3
      end

      numbers = lowest_periods.map{ |_, a| a }

      numbers.reduce(1, :lcm) * 2
    end

    def calculate_velocity(moons)
      moons.each do |moon|
        update_velocity(moons, moon, :x)
        update_velocity(moons, moon, :y)
        update_velocity(moons, moon, :z)
      end
    end

    def update_velocity(moons, moon, axis)
      moon[:velocity][axis] += moons.reduce(0) do |acc, x|
        acc += x.dig(:position, axis) <=> moon.dig(:position, axis)
      end

      moon
    end

    def calculate_positions(moons)
      moons.each do |moon|
        moon[:position][:x] += moon[:velocity][:x]
        moon[:position][:y] += moon[:velocity][:y]
        moon[:position][:z] += moon[:velocity][:z]
      end
    end

    def calculate_energy(moons)
      moons.reduce(0) do |acc, moon|
        potential = moon[:position][:x].abs +
          moon[:position][:y].abs +
          moon[:position][:z].abs

        kinetic = moon[:velocity][:x].abs +
          moon[:velocity][:y].abs +
          moon[:velocity][:z].abs

        acc += potential * kinetic
      end
    end

    def parse_input(input)
      input.map do |line|
        entry = line.chomp.split(',')

        {
          position: {
            x: entry.first.split('=').last.to_i,
            y: entry[1].split('=').last.to_i,
            z: entry.last.split('=').last[0..-2].to_i
          },
          velocity: {x: 0, y: 0, z: 0}
        }
      end
    end
  end
end
