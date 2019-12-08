module Solvers
  class Solver6
    def solve_a(input, _)
      orbits = generate_orbits(input)
      current_stack = %i[COM]
      next_stack = []
      i = 0

      orbit_count = 0

      until current_stack.empty?
        orbit_count += i

        orbit = current_stack.pop

        next_stack.concat(orbits[orbit]).flatten if orbits.key?(orbit)

        next unless current_stack.empty?

        i += 1
        current_stack = next_stack
        next_stack = []
      end

      orbit_count
    end

    def solve_b(input, _)
      orbits = generate_orbits(input)
      start_point = orbits.find{ |_, v| v.include?(:YOU) }.first
      end_point = orbits.find{ |_, v| v.include?(:SAN) }.first
      current_stack = [start_point]
      next_stack = []

      i = 0

      visited = [:YOU]

      until current_stack.empty?
        orbit = current_stack.pop

        return i if orbit == end_point

        visited << orbit
        next_stack.concat(orbits[orbit]).flatten if orbits.key?(orbit)
        next_stack
          .concat(orbits.select{ |_, v| v.include?(orbit) }.map{ |k, _| k })
          .flatten!
        next_stack.reject!{ |v| visited.include?(v) }

        next unless current_stack.empty?

        i += 1
        current_stack = next_stack
        next_stack = []
      end
    end

    def generate_orbits(input)
      orbits = {}

      input.each do |orbit|
        orbit_array = orbit.chomp.split(')')
        orbits[orbit_array.first.to_sym] ||= []
        orbits[orbit_array.first.to_sym] << orbit_array[1].to_sym
      end

      orbits
    end
  end
end
