class Solvers::Solver3
  def solve_a(input)
    first_line = input.first.chomp.split(',').map{ |x| generate_moves(x) }
    second_line = input[1].chomp.split(',').map{ |x| generate_moves(x) }

    passed_count_one = generate_passes(first_line)
    passed_count_two = generate_passes(second_line)

    passed_count = passed_count_one.merge(passed_count_two) do |_, one, two|
      one + two
    end

    collisions = passed_count.select{ |_, v| v >= 2 }

    closest = collisions.min do |x, y|
      manhattan_zero(x) <=> manhattan_zero(y)
    end

    manhattan_zero(closest)
  end

  def solve_b(input)
    first_line = input.first.chomp.split(',').map{ |x| generate_moves(x) }
    second_line = input[1].chomp.split(',').map{ |x| generate_moves(x) }

    passed_count_one = generate_passes(first_line, true)
    passed_count_two = generate_passes(second_line, true)

    min = 10_000_00

    passed_count_one.merge(passed_count_two) do |_, one, two|
      min = [one + two, min].min
    end

    min
  end

  def generate_moves(string)
    {
      direction: string.slice!(0),
      distance: string.to_i
    }
  end

  def manhattan_zero(point_set)
    point_set.first[0].abs + point_set.first[1].abs
  end

  def generate_passes(line, increment = false)
    x = 0
    y = 0
    i = 1
    passed_count = {}

    line.each do |line_movement|
      line_movement.dig(:distance).times do
        case line_movement.dig(:direction)
          when 'R'
            x += 1
          when 'L'
            x -= 1
          when 'U'
            y += 1
          when 'D'
            y -= 1
        end

        passed_count[[x, y]] ||= increment ? i : 1

        i += 1
      end
    end

    passed_count
  end
end
