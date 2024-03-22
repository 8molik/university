public class Producer extends Thread
{
    private Buffer<String> buffer;
    private int size;
    private int current;
    
    public Producer(Buffer<String> buffer)
    {
        this.size = buffer.maxSize;
        this.buffer = buffer;
        this.current = 0;
    }

    @Override
    public void run()
    {
        while(current != size)
        {
            try 
            {
                buffer.produce(String.valueOf(current));
                System.out.println("Produced: " + String.valueOf(current));
                current++;
                Thread.sleep(1);
            }
            catch (InterruptedException e) 
            {
                e.printStackTrace();
            }
    
        }
    }
}