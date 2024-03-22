import java.io.Serializable;

public class Figure implements Serializable
{
    protected String name;
    protected String color;
    protected double area;
    
    public Figure() {
        this.name = "";
        this.color = "";
        this.area = 0;
    }
    public Figure(String name, String color, double area)
    {
        this.name = name;
        this.color = color;
        this.area = area;
    }

    public String ToString()
    {
        return "Name: " + name + "\n" +
               "Color: " + color + "\n" +
               "Area: " + area + "\n";       
    }
};
