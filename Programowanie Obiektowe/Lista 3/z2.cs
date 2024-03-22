using System;

namespace VectorLibrary
{
    public class NewVector
    {
        private int n;
        private float[] coordinates;
        public NewVector(int n, float[] coordinates)
        {
            if (n != coordinates.Length)
            {
                throw new ArgumentException("Coordinates number differs from vector dimension.");
            }
            this.n = n;
            this.coordinates = coordinates;
        }
        public static float operator *(NewVector a, NewVector b)
        {
            float result = 0;
            for (int i = 0; i < a.n; i++)
            {
                result += a.coordinates[i] * b.coordinates[i];
            }
            return result;
        }
        public static NewVector operator +(NewVector a, NewVector b)
        {
            int n = a.n;
            float[] result = new float[n];
            for (int i = 0; i < n; i++)
            {
                result[i] = a.coordinates[i] + b.coordinates[i];
            }
            return new NewVector(a.n, result);
        }
        public static NewVector operator *(NewVector a, float scalar)
        {
            float[] result = new float[a.n];
            for (int i = 0; i < a.n; i++)
            {
                result[i] = a.coordinates[i] * scalar;
            }
            return new NewVector(a.n, result);
        }
        public float norma()
        {
            float result = 0;
            for (int i = 0; i < this.n; i++)
            {
                result += this.coordinates[i] * this.coordinates[i];
            }
            return (float)Math.Sqrt(result);
        }
        public override string ToString()
        {
            return "(" + string.Join(", ", coordinates) + ")";
        }
    }
}