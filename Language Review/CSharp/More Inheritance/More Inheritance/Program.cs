using System;
using System.Collections.Generic;
using LanguageReview.CSharp.Inheritance;
namespace LanguageReview.CSharp
{
    public class Program
    {
        public static void Main(string[] args)
        {
            DemonstrateInheritance();

            Console.ReadLine();
        }

        private static void DemonstrateInheritance()
        {
            int[] keySequence = { 5, 7, 2, 3, 5 };
            List<KeyPin> key = new List<KeyPin>();
            key.Add(new KeyPin(5));
            key.Add(new KeyPin(7));
            key.Add(new KeyPin(2));
            key.Add(new KeyPin(3));
            key.Add(new KeyPin(5));

            AbstractLock myLock = new KeyLock(key);
            myLock.Lock();
            myLock.Unlock(keySequence);
            if (myLock.IsLocked)
                Console.WriteLine("Hmm. It should be unlocked...");
            else
                Console.WriteLine("Good! The key worked for my new lock");

            myLock.Lock();
            int tries = PickLock(myLock, 5);
            Console.WriteLine("The computer picked the lock after " + tries.ToString() + " tries for sequence: ");
            DisplayKeySequence(keySequence);
        }

        private static int PickLock(AbstractLock theLock, int keyLength)
        {
            int count = 0;
            int[] keySequence = new int[keyLength];
            while (theLock.IsLocked)
            {
                count++;
                bool noMoreNumbers = IncrementKeySequence(keySequence);
                if (noMoreNumbers)
                {
                    count = -1;
                    break;
                }
                else
                {
                    DisplayKeySequence(keySequence);
                    theLock.Unlock(keySequence);
                }
            }
            return count;
        }

        private static bool IncrementKeySequence(int[] sequence)
        {
            sequence[sequence.Length - 1]++;
            for (int index = sequence.Length - 1; index > 0; index--)
            {
                if (sequence[index] > 10)
                {
                    sequence[index - 1]++;
                    sequence[index] = 0;
                }
                if (sequence[index] == 0)
                    sequence[index] = 1;
            }
            if (sequence[0] == 0) sequence[0]++;
            return sequence[0] > 10;
        }

        private static void DisplayKeySequence(int[] sequence)
        {
            foreach (int item in sequence)
            {
                Console.Write(item.ToString() + " ");
            }
            Console.WriteLine();
        }
    }
}
