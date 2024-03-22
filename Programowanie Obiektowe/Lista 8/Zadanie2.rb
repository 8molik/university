#Blazej Molik
#Zadanie 2 
#Aby uruchomic program nalezy w konosle wpisac ruby Zadanie3.rb

class Length
    def initialize(distance, unit)
        @distance  = distance
        @unit = unit
    end

    def to_meters
        case @unit
        when 'km'
            @distance * 1000
        when 'mi'
            @distance * 1852
        when 'm'
            @distance
        else
            raise "Error: wrong unit"
        end
    end        

    def to_kilometers
        case @unit
        when 'km'
            @distance
        when 'mi'
            @distance * 1.852
        when 'm'
            @distance / 1000
        else
            raise "Error: wrong unit"
        end
    end
    
    def to_miles
        case @unit
        when 'km'
            @distance * 0.53996
        when 'mi'
            @distance
        when 'm'
            @distance * 0.0005399
        else
            raise "Error: wrong unit"
        end
    end
end

class Time
    def initialize(time, unit)
        @time = time
        @unit = unit
    end

    def to_seconds
        case @unit
        when 's'
            @time
        when 'h'
            @time * 3600
        else
            raise "Error: wrong unit"
        end
    end

    def to_hours
        case @unit
        when 's'
            @time / 3600
        when 'h'
            @time
        else
            raise "Error: wrong unit"
        end
    end
end

class Velocity
    def initialize(distance, distance_unit, time, time_unit)
        @length = Length.new(distance, distance_unit)
        @time = Time.new(time, time_unit)
    end
    def to_kilometers_per_hour
        (@length.to_kilometers / @time.to_hours).round(2)
    end
    
    def to_knots
        (@length.to_miles / @time.to_hours * 0.8689).round(2)
    end
end

class Acceleration
    def initialize(distance, distance_unit, time, time_unit)
        @length = Length.new(distance, distance_unit)
        @time = Time.new(time, time_unit)
    end
    def to_meters_per_second_squared
        (@length.to_meters / @time.to_seconds ** 2).round(2)
    end
    def to_miles_per_hour_squared
        (@length.to_miles / @time.to_hours ** 2).round(2)
    end
end


puts "Velocity tests:"
puts "----------------"
puts "%-25s %-25s" % ["kilometers/hour", "knots"]
puts "-" * 40
velocities = [[50, "km", 2, "h"], [30, "mi", 1, "h"], [1000, "m", 0.5, "h"]]
velocities.each do |v|
    velocity = Velocity.new(v[0], v[1], v[2], v[3])
    puts "%-25s %-25s" % [velocity.to_kilometers_per_hour.to_s + " km/h", velocity.to_knots.to_s + " knots"]
end

puts "\nAcceleration tests:"
puts "-------------------"
puts "%-25s %-25s" % ["meters/seconds^2", "miles/hour^2"]
puts "-" * 40
accelerations = [[100, "km", 1, "h"], [0.2, "mi", 1, "h"]]
accelerations.each do |a|
    acceleration = Acceleration.new(a[0], a[1], a[2], a[3])
    puts "%-25s %-25s" % [acceleration.to_meters_per_second_squared.to_s + " m/s^2", acceleration.to_miles_per_hour_squared.to_s + " mm/h^2"]
end
