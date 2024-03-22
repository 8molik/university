import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.FileInputStream;
import java.io.ObjectInputStream;

public class SaveRead 
{
    public static void saveObject(Object o, String fileName) throws IOException
    {
        FileOutputStream fileOutputStream = new FileOutputStream(fileName, true);
        ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
        objectOutputStream.writeObject(o);
        objectOutputStream.close();
        fileOutputStream.close();
    }

    public static Triangle readTriangle(String name) throws IOException, ClassNotFoundException
    {
        FileInputStream fileInputStream = new FileInputStream(name);
        ObjectInputStream objectInputStream = new ObjectInputStream(fileInputStream);
        Triangle read = (Triangle)objectInputStream.readObject();
        fileInputStream.close();
        objectInputStream.close();
    
        return read;
    }

    public static Circle readCircle(String name) throws IOException, ClassNotFoundException
    {
        FileInputStream fileInputStream = new FileInputStream(name);
        ObjectInputStream objectInputStream = new ObjectInputStream(fileInputStream);
        Circle read = (Circle)objectInputStream.readObject();
        fileInputStream.close();
        objectInputStream.close();
        return read;
    }
}
