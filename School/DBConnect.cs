using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace School
{
    internal class DBConnect
    {
        public static School1Entities db { get; }

        static DBConnect()
        {
            db = new School1Entities();

            db.Class.Load();
            db.Student.Load();
            db.Employee.Load();
            db.Lesson.Load();
            db.LessonEmployee.Load();
            db.Schedule.Load();
        }
    }
}
