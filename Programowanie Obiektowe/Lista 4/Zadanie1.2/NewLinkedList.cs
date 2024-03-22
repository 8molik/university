using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

public interface ListCollection<T>
{
    void PushFront(T val);
    void PushBack(T val);
    bool isEmpty();
    void PopFront();
    void PopBack();    
}

namespace NewLinkedList
{
    public class LinkedListNew<T> : ListCollection<T>
    {
        public class Element
        {
            public Element next;
            public Element prev;
            public T value;
            public Element(T value, Element prev, Element next)
            {
                this.value = value;
                this.prev = prev;
                this.next = next;
            }
        }
        private Element head;
        private Element tail;

        public LinkedListNew()
        {
            this.head = null;
            this.tail = null;
        }
        public bool isEmpty()
        {
            return head == null;
        }
        public void PushFront(T val)
        {
            Element node = new Element(val, null, null);
            if (head == null)
            {
                head = node;
                tail = node;
            }
            else
            {
                node.next = head;
                head.prev = node;
                head = node;
            }
        }
        public void PushBack(T val)
        {
            Element node = new Element(val, null, null);
            if (head == null)
            {
                head = node;
                tail = node;
            }
            else
            {
                tail.next = node;
                node.prev = tail;
                tail = node;
            }
        }
        public void PopFront()
        {
            if (head == null)
            {
                return;
            }
            else
            {
                head = head.next;
            }
        }

        public void PopBack()
        {
            if (tail == null)
            {
                return;
            }
            tail = tail.prev;
            if (tail != null)
            {
                tail.next = null;
            }
            else
            {
                head = null;
            }
        }
        public override string ToString()
        {
            StringBuilder text = new StringBuilder();
            Element current = head;
            while (current != null)
            {
                text.Append(current.value);
                text.Append(" ");
                current = current.next;
            }
            return text.ToString();
        }
    }
}