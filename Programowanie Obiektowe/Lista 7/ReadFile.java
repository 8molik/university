import java.io.IOException;

public class ReadFile {
    public static void main(String[] args) 
    {
        String fileName = args[0];
        String objectType = args[1];
        try 
        {   
            if (objectType.equals("Triangle"))
            {
                System.out.println(SaveRead.readTriangle(fileName).ToString()); 
    
            }
            else if (objectType.equals("Circle"))
            {
                System.out.println(SaveRead.readCircle(fileName).ToString()); 
            }
            else
            {
                System.out.println("Wrong type");
            }
        } 
        catch (IOException | ClassNotFoundException e) 
        {
            e.printStackTrace(System.err);
        }    
    }
}
