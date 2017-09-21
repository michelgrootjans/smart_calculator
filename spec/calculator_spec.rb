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
  it { expect(Calculator.solve({start: 1,  goal: 11, moves: 1, operations: ["1"]})).to eq ["1"] }
  
  # multiple moves
  it { expect(Calculator.solve({start: 0,  goal: 2,  moves: 2, operations: ["+1"]})).to eq ["+1","+1"] }
  it { expect(Calculator.solve({start: 0,  goal: 1,  moves: 1, operations: ["+1", "-1"]})).to eq ["+1"] }
  it { expect(Calculator.solve({start: 0,  goal: 1,  moves: 1, operations: ["-1", "+1"]})).to eq ["+1"] }
  it { expect(Calculator.solve({start: 0,  goal: 11, moves: 2, operations: ["1"]})).to eq ["1", "1"] }

  # challenges
  it { expect(Calculator.solve({start: 11, goal: 29, moves: 5, operations: ["/2", "+3", "1=>2", "2=>9"]})).to eq ["+3", "1=>2", "/2", "2=>9", "1=>2"] }
  it { expect(Calculator.solve({start: 9,  goal: 10, moves: 5, operations: ["+5", "x5", "+/-"]})).to eq ["+/-", "+5", "+5", "x5", "+5"] }
end

describe Addition do
  it { expect(Addition.new("+2").apply(2)).to eq 4 }
  it { expect(Addition.new("+20").apply(2)).to eq 22 }
end

describe Subtraction do
  it { expect(Subtraction.new("-2").apply(4)).to eq 2 }
  it { expect(Subtraction.new("-2").apply(2)).to eq 0 }
  it { expect(Subtraction.new("-2").apply(0)).to eq -2 }
  it { expect(Subtraction.new("-20").apply(2)).to eq -18 }
end

describe Multiplication do
  it { expect(Multiplication.new("x2").apply(2)).to eq 4 }
  it { expect(Multiplication.new("x20").apply(2)).to eq 40 }
end

describe Division do
  it { expect(Division.new("/2").apply(4)).to eq 2 }
  it { expect(Division.new("/20").apply(40)).to eq 2 }
  it { expect{Division.new("/2").apply(3)}.to raise_error("Error") }
  it { expect{Division.new("/0").apply(2)}.to raise_error(ZeroDivisionError) }
end

describe Shift do
  it { expect(Shift.new("<<").apply(1234)).to eq 123 }
end

describe Replace do
  it { expect(Replace.new("2=>3").apply(12)).to eq 13 }
  it { expect(Replace.new("23=>45").apply(1236)).to eq 1456 }
end

describe Number do
  it { expect(Number.new("1").apply(0)).to eq 1 }
  it { expect(Number.new("1").apply(1)).to eq 11 }
  it { expect(Number.new("4").apply(123)).to eq 1234 }
end

describe ToggleSign do
  it { expect(ToggleSign.new("+/-").apply(1234)).to eq -1234 }
end
