#Blazej Molik
#Zadanie 2

class Kolekcja
  Node = Struct.new(:value, :prev, :next)

  def initialize
    @head = Node.new(nil, nil, nil)
    @tail = Node.new(nil, @head, nil)
    @head.next = @tail
    @size = 0
  end

  def add(value)
    node = Node.new(value, nil, nil)
    curr = @head
    while curr.next != @tail && curr.next.value < value
      curr = curr.next
    end
    node.next = curr.next
    node.prev = curr
    curr.next.prev = node
    curr.next = node
    @size += 1
  end

  def each
    curr = @head.next
    while curr != @tail
      yield curr.value
      curr = curr.next
    end
  end

  def size
    @size
  end

  def get(index)
    if index < 0 || index >= @size
      raise IndexError, "index #{index} out of bounds"
    end
    curr = @head.next
    index.times { curr = curr.next }
    curr.value
  end

  def to_s
    elements = []
    curr = @head.next
    while curr != @tail
      elements << curr.value.to_s
      curr = curr.next
    end
    "[" + elements.join(", ") + "]"
  end
end

class Wyszukiwanie
  def initialize(kolekcja)
    @kolekcja = kolekcja
  end

  def wyszukaj_binarnie(needle)
    low = 0
    high = @kolekcja.size - 1
    while low <= high
      mid = (low + high) / 2
      if @kolekcja.get(mid) == needle
        return mid
      elsif @kolekcja.get(mid) < needle
        low = mid + 1
      else
        high = mid - 1
      end
    end
    nil
  end

  def wyszukaj_interpolacyjnie(needle)
    low = 0
    high = @kolekcja.size - 1
    while low <= high && needle >= @kolekcja.get(low) && needle <= @kolekcja.get(high)
      mid = low + ((needle - @kolekcja.get(low)) * (high - low)) / (@kolekcja.get(high) - @kolekcja.get(low))
      if @kolekcja.get(mid) == needle
        return mid
      elsif @kolekcja.get(mid) < needle
        low = mid + 1
      else
        high = mid - 1
      end
    end
    nil
  end
end

kolekcja = Kolekcja.new
kolekcja.add(5)
kolekcja.add(3)
kolekcja.add(7)
wyszukiwanie = Wyszukiwanie.new(kolekcja)

puts "Kolekcja: #{kolekcja}"
needle = 3
puts "Wyszukiwanie binarne dla #{needle}:"
index = wyszukiwanie.wyszukaj_binarnie(needle)
if index
  puts "Znaleziono na indeksie: #{index}"
else
  puts "Nie znaleziono"
end

needle = 5
puts "Wyszukiwanie interpolacyjne dla #{needle}:"
index = wyszukiwanie.wyszukaj_interpolacyjnie(needle)
if index
  puts "Znaleziono na indeksie: #{index}"
else
  puts "Nie znaleziono"
end

needle = 4
puts "Wyszukiwanie binarne dla #{needle}:"
index = wyszukiwanie.wyszukaj_binarnie(needle)
if index
  puts "Znaleziono na indeksie: #{index}"
else
  puts "Nie znaleziono"
end

