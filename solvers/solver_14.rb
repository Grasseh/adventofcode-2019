module Solvers
  class Solver14
    def solve_a(input, _opts = {})
      recipes = parse_input(input)

      get_ore_necessary_for_fuel(recipes)
    end

    def get_ore_necessary_for_fuel(recipes, fuel_goal = 1)
      goal = 'FUEL'
      ore_count = 0

      extra_resources = {}
      stack = [{ goal => fuel_goal }]

      loop do
        break if stack.empty?

        material = stack.shift
        material_name = material.first.first.to_sym
        material_needed = [
          material.first.last - (extra_resources[material_name] || 0),
          0
        ].max

        # Adjust resources we already have
        extra_resources[material_name] ||= 0
        extra_resources[material_name] -= material.first.last
        extra_resources[material_name] = [
          extra_resources[material_name],
          0
        ].max

        recipe_count = (
          (material_needed * 1.0) / recipes[material_name].dig(:amount)
        ).ceil

        produced_count = recipe_count * recipes[material_name].dig(:amount)

        extra_resources[material_name] += produced_count - material_needed

        recipes[material_name].dig(:prerequisites).each do |name, req_amount|
          break if recipe_count.zero?

          if name == :ORE
            ore_count += req_amount * recipe_count
            next
          end

          this_component = stack.select{ |x| x.first.first == name }.first
          if this_component
            this_component[name] += req_amount * recipe_count
          else
            stack << { name => req_amount * recipe_count }
          end
        end
      end

      ore_count
    end

    def solve_b(input, _opts = {})
      recipes = parse_input(input)
      base_count = 1_000_000_000_000

      (1..base_count).bsearch do |x|
        ore = get_ore_necessary_for_fuel(recipes, x)
        ore >= base_count
      end - 1
    end

    def parse_input(input)
      input.map do |line|
        entry = line.chomp.split('=>')

        prereqs = entry.first.split(',').map do |component|
          [
            component.split(' ').last.to_sym,
            component.split(' ').first.to_i
          ]
        end.to_h

        [
          entry.last.split(' ').last.to_sym,
          {
            prerequisites: prereqs,
            amount: entry.last.split(' ').first.to_i
          }
        ]
      end.to_h
    end
  end
end
