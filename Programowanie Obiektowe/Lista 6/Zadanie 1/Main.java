//Błażej Molik
//Zadanie 1, Lista 6
//jdk 20

import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.io.IOException;

public class Main implements Serializable{
    public static void main(String[] args) {
        try {
            OrderedList<String> Lista1 = new OrderedList<String>("abc");
            Lista1.Add("def");
            Lista1.Add("ghi");
            
            FileOutputStream fileOutputStream = new FileOutputStream("testfile.txt");
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
            objectOutputStream.writeObject(Lista1);
            objectOutputStream.flush();
            objectOutputStream.close();
            
            FileInputStream fileInputStream = new FileInputStream("testfile.txt");
            ObjectInputStream objectInputStream = new ObjectInputStream(fileInputStream);

            @SuppressWarnings("unchecked")
            OrderedList<String> Lista2 = (OrderedList<String>) objectInputStream.readObject();
            objectInputStream.close(); 

            OrderedList<String> current1 = Lista1;
            OrderedList<String> current2 = Lista2;
            while (current1 != null) 
            {
                System.out.println("Wartość listy początkowej: " + current1.getValue());
                System.out.println("Wartość listy odczytanej: " + current2.getValue());
                current1 = current1.next;
                current2 = current2.next;
            }            
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
