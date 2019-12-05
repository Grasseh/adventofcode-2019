require_relative '../solvers/solver_5.rb'
require_relative './spec_helper.rb'
require_relative '../solvers/lib/opcode.rb'

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Solvers::Solver5 do
  before(:each) do
    @solver = Solvers::Solver5.new
  end

  context 'Problem A' do
  end

  context 'Problem B' do
  end

  context '#computer' do
  end
end
