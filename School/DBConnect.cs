using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School
{
    internal class DBConnect
    {
        public static Entities db { get; }

        static DBConnect() => db = new Entities();
    }
}
