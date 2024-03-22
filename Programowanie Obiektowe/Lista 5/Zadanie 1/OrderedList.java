//Błażej Molik
//Zadanie 1
//jdk 20
//Aby uruchomić program należy otworzyć terminal w folderze i wpisać java OrderedList

interface Rank extends Comparable<Rank>
{
    String getName();
    int getLevel();
}

class Private implements Rank
{
    private int level = 1;

    public int getLevel()
    {   
        return this.level;
    }
    public String getName()
    {
        return "Private";
    }
    @Override
    public int compareTo(Rank otherRank)
    {
        return Integer.compare(level, otherRank.getLevel());
    }
}

class Corporal implements Rank
{
    private int level = 2;

    public int getLevel()
    {   
        return this.level;
    }
    public String getName()
    {
        return "Corporal";
    }
    @Override
    public int compareTo(Rank otherRank)
    {
        return Integer.compare(level, otherRank.getLevel());
    }
}

class Sergeant implements Rank
{
    private int level = 3;

    public int getLevel()
    {   
        return this.level;
    }
    public String getName()
    {
        return "Sergeant";
    }
    @Override
    public int compareTo(Rank otherRank)
    {
        return Integer.compare(level, otherRank.getLevel());
    }
}

class Major implements Rank
{
    private int level = 4;

    public int getLevel()
    {   
        return this.level;
    }
    public String getName()
    {
        return "Major";
    }
    @Override
    public int compareTo(Rank otherRank)
    {
        return Integer.compare(level, otherRank.getLevel());
    }
}

public class OrderedList<T extends Comparable<T>>
{
    private T value;
    private OrderedList<T> next;

    public OrderedList(T val)
    {
        this.value = val;
        this.next = null;
    }

    public T getValue()
    {
        return value;
    }
    
    public void setNext(OrderedList<T> item)
    {
        this.next = item;
    }

    public void Add(T item)
    {
        OrderedList<T> newNode = new OrderedList<>(item);
        OrderedList<T> current = this;

        while (current.next != null)
        {
            current = current.next;
        }
        current.setNext(newNode);
    }
    public static void main(String[] args) {
        OrderedList<Rank> ranks = new OrderedList<>(new Private());
        ranks.Add(new Corporal());
        ranks.Add(new Sergeant());
        ranks.Add(new Major());
        
        System.out.println("Posortowane według poziomu rangi:");
        OrderedList<Rank> current = ranks;
        while (current.next != null) 
        {
            //Sprawdza czy rangi rzeczywiście rosną, tylko wtedy wypisuje
            if (current.getValue().getLevel() < current.next.getValue().getLevel()){
                System.out.println(current.getValue().getName());
                current = current.next;
            }
        }
        System.out.println(current.getValue().getName());
    }
}

