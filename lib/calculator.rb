class Addition
  def self.can_perform?(operation)
    operation[0] == "+"
  end

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

class Subtraction
  def self.can_perform?(operation)
    operation[0] == "-"
  end

  def initialize(operation)
    @term = operation.to_i
  end

  def apply(other_term)
    other_term + @term
  end

  def render
    @term.to_s
  end
end

class Multiplication
  def self.can_perform?(operation)
    operation[0] == "x"
  end

  def initialize(operation)
    @term = operation[1].to_i
  end

  def apply(other_term)
    other_term * @term
  end

  def render
    "x" + @term.to_s
  end
end

class Division
  def self.can_perform?(operation)
    operation[0] == "/"
  end

  def initialize(operation)
    @term = operation[1].to_i
  end

  def apply(other_term)
    div, mod = other_term.divmod(@term)
    raise "Error" if mod != 0
    div
  end

  def render
    "/" + @term.to_s
  end
end

class Shift
  def self.can_perform?(operation)
    operation == "<<"
  end

  def initialize(operation)
    # no need to save anything, operation contains exactly "<<"
  end

  def apply(term)
    term / 10 # surprised?
    # 123/10 = 12 in ruby
  end

  def render
    "<<"
  end
end

class Replace
  def self.can_perform?(operation)
    operation[1..2] == "=>"
  end

  def initialize(operation)
    @from = operation[0]
    @to = operation[3]
  end

  def apply(number)
    number.to_s.gsub(@from, @to).to_i
  end

  def render
    @from.to_s + "=>" + @to.to_s
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
      end
      if outcome == goal
        solution = operations.map(&:render)
        break        
      end
  end

    return solution
  end

  
  @operations = [
    Addition, Subtraction, Multiplication, Division, Shift, Replace
  ]

  def self.create_operation(operation_description)
    @operations.each do |operation|
      if operation.can_perform?(operation_description)
        return operation.new(operation_description)
      end
    end

    raise "Operation not supported"
  end
end

