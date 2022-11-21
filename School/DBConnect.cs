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
        public static Entities db { get; }

        static DBConnect()
        {
            db = new Entities();

            db.Class.Load();
            db.Student.Load();
            db.Employee.Load();
            db.Lesson.Load();
            db.LessonEmployee.Load();
            db.Schedule.Load();
        }
    }
}
