using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School
{
    public partial class Employee
    {
        public string FullName
        {
            get => $"{Surname} {Name[0]}. {Lastname[0]}.";
        }
    }
}
