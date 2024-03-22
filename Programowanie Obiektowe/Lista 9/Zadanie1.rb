#Blazej Molik
#Zadanie 1
#Aby uruchomic program nalezy w konosle wpisac ruby Zadanie1.rb

class Function
    def initialize(block)
        @block = block
    end
    
    def value(x)
        @block.call(x)
    end

    def zero(a, b, e)
        if value(a) * value(b) >= 0
          return nil
        end
      
        while (b - a) >= e
          c = (a + b).to_f / 2
          fc = value(c)
      
          if fc.abs < e
            return c
          elsif fc * value(a) > 0
            a = c
          else
            b = c
          end
        end
        return nil
    end
      
    def field(a, b, n = 1000)
        h = (b - a).to_f / n
        sum = 0
        (1..n).each do |i|
            sum += (value(a + (i - 1) * h).abs + value(a + i * h).abs).to_f / 2 * h
        end
        sum
    end 

    def deriv(x, h = 0.0001)
        (value(x + h) - value(x)).to_f / h
    end
end


f = Function.new(Proc.new { |x| x ** 2 - 2  }) 

puts "Testowana funkcja: y = x ^ 2 - 2"

puts "Wartość funkcji w punkcie 3: ",  f.value(3) 

puts "Miejsce zerowe funkcji w przedziale [-1, 2] z dokładnością 0.0001", f.zero(-1, 2, 0.001) 

puts "Pole pod krzywą funkcji w przedziale [0, 3]", f.field(0, 3) 

puts "Wartość pochodnej funkcji w punkcie 2", f.deriv(2) 
