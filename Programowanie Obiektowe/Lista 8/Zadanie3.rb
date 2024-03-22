#Blazej Molik
#Zadanie 3 - ONP
#Aby uruchomic program nalezy w konosle wpisac ruby Zadanie3.rb

class ONPExpression    
  def initialize(expressions)
    @expressions = expressions
  end

  def eval(vars)
    stack = []

    @expressions.each do |expression|
      case expression
      when Integer
        stack.push(expression)
      when '+'
        if stack.size < 2
          raise "Not enough operands for '+' operator"
        end
        b = stack.pop
        a = stack.pop
        stack.push(a + b)
        puts "Stack: #{stack.join(' ')}"
      when '-'
        if stack.size < 2
          raise "Not enough operands for '-' operator"
        end
        b = stack.pop
        a = stack.pop
        stack.push(a - b)
        puts "Stack: #{stack.join(' ')}"
      when '*'
        if stack.size < 2
          raise "Not enough operands for '*' operator"
        end
        b = stack.pop
        a = stack.pop
        stack.push(a * b)
        puts "Stack: #{stack.join(' ')}"
      when '/'
        if stack.size < 2
          raise "Not enough operands for '/' operator"
        end
        b = stack.pop
        a = stack.pop
        stack.push(a / b)
        puts "Stack: #{stack.join(' ')}"
      when String
        if vars.has_key?(expression)
          stack.push(vars[expression])          
        else
          raise "Undefined variable"
        end
      else
        raise "Invalid expression"
      end
    end
    if stack.size != 1
      raise "Invalid expression"
    end
    return stack.pop  
  end
end

expressions = [
  [2, 3, '+'],
  [3, 4, 5],
  [4, 2, 1, '+', '*'],
  ['x', 'y', 'z', '*', '+']
]

variables = {'x' => 2, 'y' => 3, 'z' => 4}


expressions.each do |expression|
  puts "Evaluating expression: #{expression.join(' ')}"
  begin
    result = ONPExpression.new(expression).eval(variables)
    puts "Result: #{result}"
  rescue => e
    puts "Error: #{e.message}"
  end
  puts "-" * 20
end
