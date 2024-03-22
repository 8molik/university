
#include <iostream>
#include <vector>
#include <cmath>
#include <stdexcept>
#include <iomanip>

using namespace std;

class Expression
{
    public:
        Expression() = default;
        Expression(const Expression&) = delete;
        Expression(Expression&&) = delete;
        Expression& operator=(const Expression&) = delete;
        Expression& operator=(Expression&&) = delete;
        virtual string notation() = 0;
        virtual double eval() = 0;
        virtual int priority() {return 4;}
        virtual ~Expression(){};
};

class Number : public virtual Expression
{
    public:
        double value;
        Number(double value);
        string notation();
        double eval();
};

class Variable : public virtual Expression
{
    private:
        static vector<pair<string, double>> variables;
    
    public:
        string name;
        Variable(string name);
        string notation();
        double eval();
        static void addVariable(string name, double val);
        static void deleteVariable(string name);
        static void modifyVariable(string name, double val);
        string allVariables();
};

class Const : public virtual Expression
{
    protected:
        double value;
};

class pi : public Const
{
    public:
        pi();
        string notation();
        double eval();
};

class e : public Const
{
    public:
        e();
        string notation();
        double eval();
};

class fi : public Const
{
    public:
        fi();
        string notation();
        double eval();
};


class Operator1Arg : public virtual Expression
{
    public:
        Expression *a1;
        Operator1Arg(Expression *a1);
};

class Sin : public Operator1Arg
{
    public:
        Sin(Expression *a1) : Operator1Arg(a1) {}
        string notation();
        double eval();
};

class Ln : public Operator1Arg
{
    public:
        Ln(Expression *a1) : Operator1Arg(a1) {}
        string notation();
        double eval();
};

class Exp : public Operator1Arg
{
    public:
        Exp(Expression *a1) : Operator1Arg(a1) {}
        string notation();
        double eval();
};

class Cos : public Operator1Arg
{
    public:
        Cos(Expression *a1) : Operator1Arg(a1) {}
        string notation();
        double eval();
};

class Abs : public Operator1Arg
{
    public:
        Abs(Expression *a1) : Operator1Arg(a1) {}
        string notation();
        double eval();
};

class Opposite : public Operator1Arg
{
    public:
        Opposite(Expression *a1) : Operator1Arg(a1) {}
        string notation();
        double eval();
};

class Reverse : public Operator1Arg
{
    public:
        Reverse(Expression *a1) : Operator1Arg(a1) {}
        string notation();
        double eval();
};

class Operator2arg : public Operator1Arg
{
    public:
        Expression *a2;
        Operator2arg(Expression *a1, Expression *a2);
};

class Add : public Operator2arg
{
    public:
        Add(Expression *a1, Expression *a2) : Operator2arg(a1, a2) {}
        string notation();
        double eval();
        int priority() override {return 1;}
};

class Substract : public Operator2arg
{
    public:
        Substract(Expression *a1, Expression *a2) : Operator2arg(a1, a2) {}
        string notation();
        double eval();
        int priority() override {return 1;}
};

class Multiply : public Operator2arg
{
    public:
        Multiply(Expression *a1, Expression*a2) : Operator2arg(a1, a2) {}
        string notation();
        double eval();
        int priority() override {return 2;}
};

class Divide : public Operator2arg
{
    public:
        Divide(Expression *a1, Expression*a2) : Operator2arg(a1, a2) {}
        string notation();
        double eval();
        int priority() override {return 2;}
};

class Modulo : public Operator2arg
{
    public:
        Modulo(Expression *a1, Expression*a2) : Operator2arg(a1, a2) {}
        string notation();
        double eval();
        int priority() override {return 2;}
};


class Power : public Operator2arg
{
    public:
        Power(Expression *a1, Expression*a2) : Operator2arg(a1, a2) {}
        string notation();
        double eval();
        int priority() override {return 3;}
};

class Logarithm : public Operator2arg
{
    public:
        Logarithm(Expression *a1, Expression *a2) : Operator2arg(a1, a2) {}
        string notation();
        double eval();
        int priority() override {return 3;}
};


