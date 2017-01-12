using LanguageReview.CSharp.Inheritance;
using System.Collections.Generic;

namespace LanguageReview.CSharp
{
    // Demo that will show the use of the various Lock classes
    public class LockDriver
    {
        private AbstractLock _TheLock;

        public LockDriver()
        {
            // Set up the fields/properties with values
            // A standard KeyLock
            // 1) Build a key pattern for the lock
            int[] keySequence = { 5, 7, 2, 3, 5 };
            List<KeyPin> key = new List<KeyPin>();
            key.Add(new KeyPin(5));
            key.Add(new KeyPin(7));
            key.Add(new KeyPin(2));
            key.Add(new KeyPin(3));
            key.Add(new KeyPin(5));

            _TheLock = new KeyLock(key);
        }

        public void PickLock()
        {

        }
    }
}
