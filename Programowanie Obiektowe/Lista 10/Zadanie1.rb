class Collection
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def length
    @items.length
  end

  def get(index)
    @items[index]
  end

  def swap(i, j)
    @items[i], @items[j] = @items[j], @items[i]
  end

  def to_s
    @items.to_s
  end
end

class Sorter
  def sort1(collection)
    n = collection.length

    loop do
      swapped = false
      (n - 1).times do |i|
        if collection.get(i) > collection.get(i + 1)
          collection.swap(i, i + 1)
          swapped = true
        end
      end
      break unless swapped
    end
    collection
  end

  def sort2(collection)
    n = collection.length
    (1..n - 1).each do |i|
      key = collection.get(i)
      j = i - 1

      while j >= 0 && collection.get(j) > key
        collection.swap(j, j + 1)
        j -= 1
      end

      collection.items[j + 1] = key
    end

    collection
  end
end

#oba sortowania mają podobną złożoność czasową
#sort1 - sortowanie bąbelkowe O(n^2)
#sort2 - sortowanie przez wstawianie O(n^2)

collection = Collection.new([4, 2, 7, 1, 3])
puts "Przed sortowaniem: #{collection}"
Sorter.new.sort1(collection)
puts "Po sortowaniu: #{collection}"

collection1 = Collection.new([4, 2, 7, 1, 3])
puts "Przed sortowaniem: #{collection1}"
Sorter.new.sort2(collection1)
puts "Po sortowaniu: #{collection1}"
