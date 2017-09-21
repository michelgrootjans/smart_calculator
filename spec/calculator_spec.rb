require "calculator"

describe "calculator" do
  it { expect(Calculator.solve({start: 0, goal: 0, moves: 0, operations: []})).to eq [] }
  it { expect(Calculator.solve({start: 0, goal: 0, moves: 0, operations: ["+1"]})).to eq [] }
  it { expect(Calculator.solve({start: 0, goal: 1, moves: 1, operations: ["+1"]})).to eq ["+1"] }
  it { expect(Calculator.solve({start: 0, goal: 2, moves: 1, operations: ["+2"]})).to eq ["+2"] }

  it { expect(Calculator.solve({start: 0,  goal: -1, moves: 1, operations: ["-1"]})).to eq ["-1"] }
  it { expect(Calculator.solve({start: 2,  goal: 1,  moves: 1, operations: ["/2"]})).to eq ["/2"] }
  it { expect(Calculator.solve({start: 1,  goal: 2,  moves: 1, operations: ["x2"]})).to eq ["x2"] }
  it { expect(Calculator.solve({start: 12, goal: 1,  moves: 1, operations: ["<<"]})).to eq ["<<"] }
  it { expect(Calculator.solve({start: 12, goal: 13, moves: 1, operations: ["2=>3"]})).to eq ["2=>3"] }
  
  it { expect(Calculator.solve({start: 0,  goal: 2,  moves: 2, operations: ["+1"]})).to eq ["+1","+1"] }
  it { expect(Calculator.solve({start: 0,  goal: 1,  moves: 1, operations: ["+1", "-1"]})).to eq ["+1"] }
  it { expect(Calculator.solve({start: 0,  goal: 1,  moves: 1, operations: ["-1", "+1"]})).to eq ["+1"] }
  it { expect(Calculator.solve({start: 11, goal: 29, moves: 5, operations: ["/2", "+3", "1=>2", "2=>9"]})).to eq ["+3", "1=>2", "/2", "2=>9", "1=>2"] }
end

# special operations that require attention
describe "division" do
  it { expect(Division.new("/2").apply(4)).to eq 2 }
  it { expect{Division.new("/2").apply(3)}.to raise_error("Error") }
  it { expect{Division.new("/0").apply(2)}.to raise_error(ZeroDivisionError) }
end

describe "shift" do
  it { expect(Shift.new("<<").apply(1234)).to eq 123 }
end

describe "replace" do
  it { expect(Replace.new("2=>3").apply(12)).to eq 13 }
end