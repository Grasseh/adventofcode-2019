class Solvers::Solver2
  def solve_a(input)
    input = input.first.chomp.split(',').map(&:to_i)
    input[1] = 12
    input[2] = 2

    compute(input).first
  end

  def solve_b(input)
    input = input.first.chomp.split(',').map(&:to_i)

    noun = 0
    verb = 0
    val = 0

    (0..99).each do |v|
      (0..99).each do |n|
        copy = input.dup
        noun = n
        verb = v

        copy[1] = noun
        copy[2] = verb

        val = compute(copy).first

        break if val == 19_690_720
      end

      break if val == 19_690_720
    end

    100 * noun + verb
  end

  def compute(program)
    i = 0

    operations = {
      1 => { op: method(:op_1), inc: 4 },
      2 => { op: method(:op_2), inc: 4 }
    }

    loop do
      operation = program[i]

      break unless operations.key?(operation)

      program = operations.dig(operation, :op).call(program, i)

      i += operations.dig(operation, :inc)
    end

    program
  end

  def op_1(program, position)
    program[program[position + 3]] = program[program[position + 1]] +
      program[program[position + 2]]

    program
  end

  def op_2(program, position)
    program[program[position + 3]] = program[program[position + 1]] *
      program[program[position + 2]]

    program
  end
end
