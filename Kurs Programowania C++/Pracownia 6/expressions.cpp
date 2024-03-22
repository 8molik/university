#include "expressions.hpp"
vector<pair<string, double>> Variable::variables;

Number::Number(double value)
{
    this->value = value;
}

string Number::notation() 
{
    stringstream stream;
    if (value == (int)value) 
    {
        stream << fixed << setprecision(0) << value;
    } 
    else 
    {
        stream << fixed << setprecision(ceil(value)) << value;
    }
    return stream.str();
}

double Number::eval()
{
    return value;
}

Variable::Variable(string name)
{
    this->name = name;
}

string Variable::notation()
{
    return name;
}

string Variable::allVariables()
{
    string res = "";
    for (int i = 0; i < variables.size(); i++)
    {
        res += variables[i].first + " " + to_string(variables[i].second) +"\n";
    }
    return res;
}

double Variable::eval()
{
    try
    {
        for (int i = 0; i < variables.size(); i++)
        {
            if (variables[i].first == name)
            {
                return variables[i].second;
            }
        }
        return 0;
        throw runtime_error("Variable::eval(): Element not found");
    }
    catch(const exception& e)
    {
        cerr << e.what() << '\n';
    }
    //return 0;
}

void Variable::addVariable(string name, double val)
{
    try 
    {
        for (int i = 0; i < variables.size(); i++)
        {
            if (variables[i].first == name)
            {
                throw invalid_argument("Element already exsits");
            }
        }
        variables.push_back(pair<string, double> (name, val));
    }
    catch(const exception& e)
    {
        cerr << e.what() << '\n';
    }
}

void Variable::deleteVariable(string name)
{
    try
    {
        int num = Variable::variables.size();
        for (int i = 0; i < num; i++)
        {
            if (Variable::variables[i].first == name)
            {
                Variable::variables.erase(Variable::variables.begin() + i);
                return;
            }
        }
        throw invalid_argument("deleteVariable: Variable not found");
    }
    catch(const exception& e)
    {
        cerr << e.what() << '\n';
    }
}

void Variable::modifyVariable(string name, double val)
{
    try
    {
        for (int i = 0; i < variables.size(); i++)
        {
            if (variables[i].first == name)
            {
                variables[i].second = val;
            }
        }
        string err = "modifyVarirable: Variable not found.";
    }
    catch(string err)
    {
        cerr << err << '\n';
    }
}

pi::pi()
{
    value = 3.1415926535897;
}

string pi::notation()
{
    return "pi";
}

double pi::eval()
{
    return value;
}

e::e()
{
    value = 2.7182818284590;
}

string e::notation()
{
    return "e";
}

double e::eval()
{
    return value;
}

fi::fi()
{
    value = 1.618033988749;
}

string fi::notation()
{
    return "fi";
}

double fi::eval()
{
    return value;
}

Operator1Arg::Operator1Arg(Expression *a1)
{
    this->a1 = a1;
}

string Sin::notation()
{
    return "sin(" + a1->notation() + ")";
}

double Sin::eval()
{
    return sin(a1->eval());
}

string Ln::notation()
{
    return "ln(" + a1->notation() + ")";
}

double Ln::eval()
{
    return log(a1->eval());
}

string Exp::notation()
{
    return "exp(" + a1->notation() + ")";
}

double Exp::eval()
{
    return exp(a1->eval());
}

string Cos::notation()
{
    return "cos(" + a1->notation() + ")";
}

double Cos::eval()
{
    return cos(a1->eval());
}

string Abs::notation()
{
    return "|" + a1->notation() + "|";
}

double Abs::eval()
{
    return abs(a1->eval());
}

string Opposite::notation()
{
    return "-(" + a1->notation() + ")";
}

double Opposite::eval()
{
    return a1->eval() * (-1);
}

string Reverse::notation()
{
    return "1/(" + a1->notation() + ")";
}

double Reverse::eval()
{
    return 1 / a1->eval();
}

Operator2arg::Operator2arg(Expression *a1, Expression *a2) : Operator1Arg(a1)
{
    this->a2 = a2;
}

string Add::notation()
{
    string left = a1->notation();
    string right = a2->notation();
    if (a1->priority() < Add::priority())
    {
        left = "(" + left + ")";
    }
    if (a2->priority() <= Add::priority())
    {
        right = "(" + right + ")";
    }
    return left + " + " + right;
}


double Add::eval()
{
    return a1->eval() + a2->eval();
}

string Substract::notation()
{
    string left = a1->notation();
    string right = a2->notation();
    if (a1->priority() < Substract::priority())
    {
        left = "(" + left + ")";
    }
    if (a2->priority() <= Substract::priority())
    {
        right = "(" + right + ")";
    }
    return left + " - " + right;
}

double Substract::eval()
{
    return a1->eval() - a2->eval();
}

string Multiply::notation()
{
    string left = a1->notation();
    string right = a2->notation();
    if (a1->priority() < Multiply::priority())
    {
        left = "(" + left + ")";
    }
    if (a2->priority() <= Multiply::priority())
    {
        right = "(" + right + ")";
    }
    return left + " * " + right;
}

double Multiply::eval()
{
    return a1->eval() * a2->eval();
}

string Divide::notation()
{
    string left = a1->notation();
    string right = a2->notation();
    if (a1->priority() < Divide::priority())
    {
        left = "(" + left + ")";
    }
    if (a2->priority() <= Divide::priority())
    {
        right = "(" + right + ")";
    }
    return left + " / " + right;
}

double Divide::eval()
{
    return a1->eval() / a2->eval();
}

string Modulo::notation()
{
    string left = a1->notation();
    string right = a2->notation();
    if (a1->priority() < Modulo::priority())
    {
        left = "(" + left + ")";
    }
    if (a2->priority() <= Modulo::priority())
    {
        right = "(" + right + ")";
    }
    return left + " % " + right;
}

double Modulo::eval()
{
    return fmod(a1->eval(), a2->eval());
}

string Power::notation()
{
    string left = a1->notation();
    string right = a2->notation();
    if (a1->priority() <= Power::priority())
    {
        left = "(" + left + ")";
    }
    if (a2->priority() < Power::priority())
    {
        right = "(" + right + ")";
    }
    return left + " ^ " + right;
}

double Power::eval()
{
    return pow(a1->eval(), a2->eval());
}

string Logarithm::notation()
{
    return "log_" + a1->notation() + "(" + a2->notation() + ")";
}

double Logarithm::eval()
{
    return log(a2->eval() / log(a1->eval()));
}

