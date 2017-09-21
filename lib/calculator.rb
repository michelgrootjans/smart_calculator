class Addition
  def self.can_perform?(description)
    description[0] == "+"
  end

  attr_reader :description, :term
  def initialize(description)
    @description = description
    @term = description.to_i
  end

  def apply(other_term)
    term + other_term
  end
end

class Subtraction
  def self.can_perform?(description)
    description[0] == "-"
  end

  attr_reader :description, :term
  def initialize(description)
    @description = description
    @term = description.to_i
  end

  def apply(other_term)
    term + other_term
  end
end

class Multiplication
  def self.can_perform?(description)
    description[0] == "x"
  end

  attr_reader :description, :factor
  def initialize(description)
    @description = description
    @factor = description[1..-1].to_i
  end

  def apply(other_factor)
    factor * other_factor
  end
end

class Division
  def self.can_perform?(description)
    description[0] == "/"
  end

  attr_reader :description, :divisor
  def initialize(description)
    @description = description
    @divisor = description[1..-1].to_i
  end

  def apply(dividend)
    div, mod = dividend.divmod(divisor)
    raise "Error" if mod != 0
    div
  end
end

class Shift
  def self.can_perform?(description)
    description == "<<"
  end

  def initialize(description)
    # no need to save anything, operation contains exactly "<<"
  end

  def apply(term)
    term / 10
    # surprised? In ruby, these are the rules FOR INTEGERS:
    # 129/10 = 12
    # 130/10 = 13
  end

  def description
    "<<"
  end
end

class Replace
  def self.can_perform?(description)
    description.include? "=>"
  end

  attr_reader :description, :from, :to
  def initialize(description)
    @description = description
    @from = description.split("=>")[0]
    @to = description.split("=>")[1]
  end

  def apply(number)
    number.to_s.gsub(from, to).to_i
  end
end

# monkey patching String
class String
  def is_i?
     /\A[-+]?\d+\z/ === self
  end
end

class Number
  def self.can_perform?(description)
    description.is_i?
  end

  attr_reader :description
  def initialize(description)
    @description = description
  end

  def apply(number)
    (number.to_s + description).to_i
  end
end


class Calculator
  def self.solve(arguments)
    
    number_of_moves = arguments[:moves]
    available_operations = arguments[:operations].map{|operation_description| create_operation(operation_description)}
    start = arguments[:start]
    goal = arguments[:goal]
    solution = []
    
    10000.times do
      operations = (1..number_of_moves).map{|| available_operations.sample }
      begin
        outcome = operations.inject(start){|current_value, operation| operation.apply(current_value)}
      rescue
        # an illegal operation occurred
        # just go to the next set of operations
      end
      if outcome == goal
        solution = operations.map(&:description)
        break        
      end
    end

    return solution
  end

  def self.create_operation(operation_description)
    operations.each do |operation|
      if operation.can_perform?(operation_description)
        return operation.new(operation_description)
      end
    end

    raise "Operation not supported"
  end

  def self.operations
    [ Addition, Subtraction, Multiplication, Division, Shift, Replace, Number ]
  end
end

