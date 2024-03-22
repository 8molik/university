//Błażej Molik
//Zadanie 3, Lista 6
//jdk 20

public class Main
{
    public static void main(String[] args)
    {
        Buffer<String> buffer = new Buffer<String>(20);

        Producer producer = new Producer(buffer);
        Consumer consumer = new Consumer(buffer);

        producer.start();
        consumer.start();
    }
}
