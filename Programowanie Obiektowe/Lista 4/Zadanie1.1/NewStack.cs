using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

public interface ListCollection<T>
{
    void Push(T element);
    T Pop();
    bool isEmptyStack();
    void Destroy();
    int Length();
}

namespace NewStack
{
    public class NewStack<T> : ListCollection<T>, IEnumerable<T>
    {
        private List<T> stack;
        private int stackIndex;
        public NewStack()
        {
            stack = new List<T>();
            stackIndex = -1;
        }
        public void Push(T item)
        {
            stack.Add(item);
            stackIndex ++;
        }
        public T Pop()
        {
            if (isEmptyStack())
            {
                throw new InvalidOperationException("Stack is empty");
            }
            T topItem = stack[stackIndex];
            stack.RemoveAt(stackIndex);
            stackIndex--;
            return topItem;
        }

        public bool isEmptyStack()
        {
            return stack.Count() == 0;
        }

        public void Destroy()
        {
            stack.Clear();
        }
        
        public int Length()
        {
            return stack.Count();
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
        public IEnumerator<T> GetEnumerator()
        {
            return stack.GetEnumerator();
        }

        public override string ToString()
        {
            StringBuilder stackString = new StringBuilder();
            stackString.Append("[");
            
            for (int i = 0; i <= stackIndex; i++)
            {
                stackString.Append(stack[i]);
                if (i != stackIndex)
                {
                    stackString.Append(", ");
                }
            }
            stackString.Append("]");
            return stackString.ToString();
        }
    }
}