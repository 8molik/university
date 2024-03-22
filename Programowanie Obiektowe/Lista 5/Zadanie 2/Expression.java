//Błażej Molik
//Zadanie 2
//jdk 20
//Aby uruchomić program należy otworzyć terminal w folderze i wpisać java OrderedList

public abstract class Expression 
{
    public abstract int evaluate();
    public abstract String toString();
    public static void main(String[] args) 
    {
        Const x = new Const(3);
        Variable y = new Variable("y", 4);

        System.out.println(y.display());
        Expression test1 = new Add(x, y);
        System.out.println("Dodawanie: " );
        System.out.println(test1.toString());

        Expression test2 = new Mult(x, y);
        System.out.println("Mnozenie: " );
        System.out.println(test2.toString());
    }
}

class Const extends Expression
{
    private final int value;

    public Const(int val)
    {
        this.value = val;
    }

    @Override
    public int evaluate()
    {
        return value;
    }

    @Override
    public String toString()
    {
        return Integer.toString(value);
    }
}

class Variable extends Expression
{
    private int value = 0;
    private String name;

    public Variable(String name, int val)
    {
        this.name = name;
        this.value = val;
    }

    public void setValue(int newValue)
    {
        this.value = newValue;
    }

    @Override
    public int evaluate()
    {
        return value;
    }

    @Override
    public String toString()
    {
        return name;
    }
    public String display()
    {
        return name + " = " + Integer.toString(value);
    }
}

abstract class Operation extends Expression
{
    protected Expression left;
    protected Expression right;

    public Operation(Expression left, Expression right) {
        this.left = left;
        this.right = right;
    }
}

class Add extends Operation
{
    public Add(Expression left, Expression right)
    {
        super(left, right);
    }

    @Override
    public int evaluate()
    {
        return left.evaluate() + right.evaluate();
    }

    @Override
    public String toString()
    {
        return (left.toString() + " + " + right.toString() + " = " + this.evaluate());
    }
}


class Mult extends Operation
{
    public Mult(Expression left, Expression right)
    {
        super(left, right);
    }

    @Override
    public int evaluate()
    {
        return left.evaluate() * right.evaluate();
    }

    @Override
    public String toString()
    {
        return (left.toString() + " * " + right.toString() + " = " + this.evaluate());
    }
}
