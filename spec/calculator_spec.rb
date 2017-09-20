require 'pry'

class Plus
  def initialize(term)
    @term = term.to_i
  end

  def apply(other_term)
    @term + other_term
  end

  def render
    "+" + @term.to_s
  end
end

class Min
  def initialize(term)
    @term = term.to_i
  end

  def apply(other_term)
    other_term - @term
  end

  def render
    "-" + @term.to_s
  end
end

class Calculator
  def self.solve(arguments)
    
    number_of_moves = arguments[:moves]
    available_operations = arguments[:operations].map{|operation| create_operation(operation)}
    start = arguments[:start]
    goal = arguments[:goal]
    solution = []
    
    1000.times do
      operations = (1..number_of_moves).map{|| available_operations.sample }
      outcome = operations.inject(start){|current_value, operation| operation.apply(current_value)}
      # print outcome
      # print operations
      if outcome == goal
        solution = operations.map(&:render)
        # print solution
        break        
      end
    end

    return solution
  end

  
  def self.create_operation(description)
    if(description[0] == "+")
      return Plus.new(description[1])
    end
    if(description[0] == "-")
      return Min.new(description[1])
    end
    raise "Operation not supported"
  end
end

describe "calculator" do
  it "null calculator returns an empty list of operations" do
    expect(Calculator.solve({start: 0, goal: 0, moves: 0, operations: []})).to eq []
  end

  it "null calculator with an operation returns an empty list of operations" do
    expect(Calculator.solve({start: 0, goal: 0, moves: 0, operations: ["+1"]})).to eq []
  end

  it "goal of 1 with an operation +1 returns +1" do
    expect(Calculator.solve({start: 0, goal: 1, moves: 1, operations: ["+1"]})).to eq ["+1"]
  end

  it "goal of 2 with an operation +2 returns +2" do
    expect(Calculator.solve({start: 0, goal: 2, moves: 1, operations: ["+2"]})).to eq ["+2"]
  end

  it "goal of 2 with an operation +1 returns [+1,+1]" do
    expect(Calculator.solve({start: 0, goal: 2, moves: 2, operations: ["+1"]})).to eq ["+1","+1"]
  end

  it "goal of -1 with an operation -1 returns [-1]" do
    expect(Calculator.solve({start: 0, goal: -1, moves: 1, operations: ["-1"]})).to eq ["-1"]
  end

  it { expect(Calculator.solve({start: 0, goal: 1, moves: 1, operations: ["+1", "-1"]})).to eq ["+1"] }
  
  it { expect(Calculator.solve({start: 0, goal: 1, moves: 1, operations: ["-1", "+1"]})).to eq ["+1"] }

  it { expect(Calculator.solve({start: 11, goal: 29, moves: 5, operations: ["/2", "+3", "1=>2", "2=>9"]})).to eq [] }
  
  end