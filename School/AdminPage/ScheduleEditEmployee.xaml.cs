using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для ScheduleEditEmployee.xaml
    /// </summary>
    public partial class ScheduleEditEmployee : Window
    {
        ObservableCollection<Lesson> _lesson;
        ObservableCollection<LessonEmployee> _lessonEmployees;
        ObservableCollection<Schedule> _schedule;
        public Employee EmployeeEdit
        {
            get { return (Employee)GetValue(EmployeeEditProperty); }
            set { SetValue(EmployeeEditProperty, value); }
        }

        public static readonly DependencyProperty EmployeeEditProperty =
            DependencyProperty.Register("EmployeeEdit", typeof(Employee), typeof(ScheduleEditEmployee));

        public ObservableCollection<Lesson> Lessons
        {
            get { return _lesson; }
            set { _lesson = value; }
        }

        public ScheduleEditEmployee(Employee _employee)
        {
            EmployeeEdit = _employee;

            DBConnect.db.LessonEmployee.Load();
            _lessonEmployees = DBConnect.db.LessonEmployee.Local;

            _lesson = new ObservableCollection<Lesson> (_lessonEmployees.Where(x => x.IdEmployees == _employee.id).Select(e => e.Lesson));

            DBConnect.db.Schedule.Load();
            _schedule = new ObservableCollection<Schedule> (
                                                              from schedule in DBConnect.db.Schedule.Local
                                                              from lessomEmployee in _lessonEmployees
                                                              where schedule.idLessonEmloyee == lessomEmployee.id &&
                                                              lessomEmployee.IdEmployees == _employee.id
                                                              select schedule
                                                           );


            InitializeComponent();
        }

        private void Window_Closed(object sender, EventArgs e) => Administrator.Instance.Show();
    }
}
