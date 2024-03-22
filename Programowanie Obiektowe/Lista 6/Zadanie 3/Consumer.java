public class Consumer extends Thread
{
    private Buffer<String> buffer;
    private int size;
    private int current;

    public Consumer(Buffer<String> buffer)
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
                System.out.println("Consumed: " + buffer.consume());
                current++;
                Thread.sleep(1);
            }
            catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}