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
    
    10000.times do
      operations = (1..number_of_moves).map{|| available_operations.sample }
      outcome = operations.inject(start){|current_value, operation| operation.apply(current_value)}
      if outcome == goal
        solution = operations.map(&:render)
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

