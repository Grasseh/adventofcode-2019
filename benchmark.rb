require 'benchmark'
require 'pry'

puts 'Reporting each test ran 100 times'
Benchmark.bm(15) do |x|
  Dir
    .glob(File.join('.', 'inputs', '*'))
    .select{ |file| File.file?(file) }
    .map{ |file| File.basename(file, '.*') }
    .each do |number|
      require_relative "solvers/solver_#{number}.rb"
      solver = eval("Solvers::Solver#{number}").new
      input = File.open("inputs/#{number}.txt").readlines

      x.report("Problem ##{number}A:") do
        100.times do
          solver.solve_a(input)
        end
      end

      x.report("Problem ##{number}B:") do
        100.times do
          solver.solve_b(input)
        end
      end
    end
end
