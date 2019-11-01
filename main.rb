puts 'Welcome to Grasseh\'s Advent of Code 2019 solutions.'
puts 'Please enter below the number of the problem you wish to solve: '

number = STDIN.gets.chomp

puts "You selected problem ##{number}"

require_relative "solvers/solver_#{number}.rb"

solver = eval("Solvers::Solver#{number}").new

input = File.open("inputs/#{number}.txt").readlines

puts solver.solve_a input
puts solver.solve_b input
