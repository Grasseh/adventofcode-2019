require 'benchmark'
require 'pry'

puts "Reporting each test ran 100 times"
Benchmark.bm(15) do |x|
  # x.report("for:")   { for i in 1..n; a = "1"; end }
  files = Dir
    .glob(File.join('.', 'inputs', '*'))
    .select{|file| File.file?(file)}
    .map{|file| File.basename(file, '.*')}
    .each do |number|
      require_relative "solvers/solver_#{number}.rb"
      solver = eval("Solvers::Solver#{number}").new
      input = File.open("inputs/#{number}.txt").readlines

      x.report("Problem ##{number}A:") do
        for i in 0..100 do
          solver.solve_a input
        end
      end

      x.report("Problem ##{number}B:") do
        for i in 0..100 do
          solver.solve_b input
        end
      end
    end
end
