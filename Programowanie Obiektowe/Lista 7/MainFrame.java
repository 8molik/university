import javax.swing.*;
import java.awt.Container;
import java.awt.GridLayout;
import java.awt.event.*;
import java.io.*;

public class MainFrame extends JFrame implements ActionListener
{
    protected Triangle triangle;
    protected Circle circle;
    protected JTextField TNameField, TAreaField, TColorField;
    protected JTextField CNameField, CAreaField, CColorField;

    public MainFrame(Circle circle, Triangle triangle)
    {
        this.triangle = triangle;
        this.circle = circle;
        
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        Container container = getContentPane();
        GridLayout layout = new GridLayout(8, 2);
        container.setLayout(layout);
        
        JLabel TNameLabel = new JLabel("Nazwa");
        container.add(TNameLabel);
        TNameField = new JTextField(triangle.name, 40);
        container.add(TNameField);

        JLabel TColorLabel = new JLabel("Kolor");
        container.add(TColorLabel);
        TColorField = new JTextField(triangle.color, 40);
        container.add(TColorField);

        JLabel TAreaLabel = new JLabel("Pole");
        container.add(TAreaLabel);
        TAreaField = new JTextField(Double.toString(triangle.area), 40);
        container.add(TAreaField);

        JButton b1 = new JButton("Zapisz trójkąt");
        b1.addActionListener(this);
        container.add(b1);

        JLabel emptyLabel = new JLabel();
        emptyLabel.setEnabled(false);
        container.add(emptyLabel);

        JLabel CNameLabel = new JLabel("Nazwa");
        container.add(CNameLabel);
        CNameField = new JTextField(circle.name, 40);
        container.add(CNameField);

        JLabel CColorLabel = new JLabel("Kolor");
        container.add(CColorLabel);
        CColorField = new JTextField(circle.color, 40);
        container.add(CColorField);

        JLabel pole_etykieta1 = new JLabel("Pole");
        container.add(pole_etykieta1);

        CAreaField = new JTextField(Double.toString(circle.area), 40);
        container.add(CAreaField);
        JButton b2 = new JButton("Zapisz koło");
        
        b2.addActionListener(this);
        container.add(b2);
        pack();
        setVisible(true);
    }
    public void actionPerformed(ActionEvent ev)
    {
        if (ev.getActionCommand().equals("Zapisz trójkąt"))
        {           
            Triangle triangleSave = new Triangle(TNameField.getText(), TColorField.getText(), Double.parseDouble(TAreaField.getText()));

            try 
            {
                SaveRead.saveObject(triangleSave, "triangle.ser");
            }
            catch (IOException e)
            {
                e.printStackTrace(System.err);
            }            
        }
        else if (ev.getActionCommand() == "Zapisz koło")
        {
            Circle circleSave = new Circle(CNameField.getText(), CColorField.getText(), Double.parseDouble(CAreaField.getText()));
            try 
            {
                SaveRead.saveObject(circleSave, "circle.ser");
            }
            catch (IOException e)
            {
                e.printStackTrace(System.err);
            }        
        }
    }
}
