import java.util.LinkedList;

public class Buffer<T>
{
    private LinkedList<T> buffer;
    public int maxSize;

    public Buffer(int maxSize)
    {
        this.buffer = new LinkedList<>();
        this.maxSize = maxSize;
    }
    
    public synchronized void produce(T item) throws InterruptedException
    {
        while (buffer.size() == maxSize)
        {
            wait();
        }
        buffer.addLast(item); //dodaje wyprodukowany element i powiadamia konsumenta
        notify();
    }

    public synchronized T consume() throws InterruptedException
    {
        while (buffer.size() == 0)
        {
            wait();
        }
        T element = buffer.removeFirst();
        notify();
        return element;
    }
}