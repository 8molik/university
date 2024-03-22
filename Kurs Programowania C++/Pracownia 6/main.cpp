#include "expressions.hpp"

void test(Expression* w, Expression*  w1,Expression*  w2,Expression*  w3,Expression* w4);
int main()
{
    Expression *w = new Substract(
        new pi(),
        new Add(
            new Number(2), new Multiply(
                new Variable("x"), new Number(1)
                )
            )
    );

    Expression *w1 = new Divide(
        new Multiply(
            new Substract(
                new Variable("x"), new Number(1)
                ),
                new Variable("x")
        ),
        new Number(2)
    );
    
    Expression *w2 = new Divide(
        new Add(
            new Number(3), new Number(5)
        ),
        new Add(
            new Number(2), new Multiply(
                new Variable("x"), new Number(7)
                )
        )
    );

    Expression *w3 = new Substract(
        new Add(
            new Number(2), new Multiply(
                new Variable("x"), new Number(7)
            )
        ),
        new Add(
            new Multiply(
                new Variable("y"), new Number(3)
            ),
            new Number(5)
        )
    );
    
    Expression *w4 = new Divide(
        new Cos(
            new Multiply(
                new Add(
                    new Variable("x"),
                    new Number(1)
                ),
                new pi()
            )
        ),
        new Power(
            new e(),
            new Power(
                new Variable("x"),
                new Number(2)
            )
        )
    );
    
    Variable::addVariable("x", 0);
    Variable::addVariable("y", 0);

    test(w, w1, w2, w3, w4);

    Variable::modifyVariable("y", 0.5);

    test(w, w1, w2, w3, w4);
    
    Variable::modifyVariable("x", 0.5);
    Variable::modifyVariable("y", 0);

    test(w, w1, w2, w3, w4);

    Variable::modifyVariable("y", 0.5);
    test(w, w1, w2, w3, w4);

    Variable::modifyVariable("x", 1);
    Variable::modifyVariable("y", 1);

    test(w, w1, w2, w3, w4);

    return 0;
}

void test(Expression *w, Expression *w1, Expression *w2, Expression *w3, Expression *w4)
{
    cout << "x = " << Variable("x").eval() << endl;
    cout << "y = " << Variable("y").eval() << endl;
    cout << w->notation() << " = " << w->eval() << endl;
    cout << w1->notation() << " = " << w1->eval() << endl;
    cout << w2->notation() << " = " << w2->eval() << endl;
    cout << w3->notation() << " = " << w3->eval() << endl;
    cout << w4->notation() << " = " << w4->eval() << endl;

}