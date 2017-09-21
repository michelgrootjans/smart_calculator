class Addition
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

class Multiplication
  def initialize(term)
    @term = term.to_i
  end

  def apply(other_term)
    other_term * @term
  end

  def render
    "x" + @term.to_s
  end
end

class Division
  def initialize(term)
    @term = term.to_i
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
  def self.matches(operation)
    operation == "<<"
  end

  def initialize(operation)
  end

  def apply(term)
    term.to_s[0...-1].to_i
  end

  def render
    "<<"
  end
end

class Replace
  
  def self.matches(operation)
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
    available_operations = arguments[:operations].map{|operation| create_operation(operation)}
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
    Shift, Replace
  ]

  def self.create_operation(description)
    if(description[0] == "+")
      return Addition.new(description[1])
    end
    if(description[0] == "-")
      return Subtraction.new(description[1])
    end
    if(description[0] == "x")
      return Multiplication.new(description[1])
    end
    if(description[0] == "/")
      return Division.new(description[1])
    end
    # if(description == "<<")
      # return Shift.new()
    # end
    @operations.each do |operation|
      if operation.matches(description)
        return operation.new(description)
      end
    end

    raise "Operation not supported"
  end
end

