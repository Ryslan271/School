using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace School
{
    /// <summary>
    /// Логика взаимодействия для AdminOnePage.xaml
    /// </summary>
    public partial class AdminOnePage : Page
    {
        private ObservableCollection<Student> _students;
        private ObservableCollection<Employee> _employees;
        private ObservableCollection<Schedule> _schedules;

        #region DependencyProperty
        public ObservableCollection<Student> Students
        {
            get { return (ObservableCollection<Student>)GetValue(StudentsProperty); }
            set { SetValue(StudentsProperty, value); }
        }

        public static readonly DependencyProperty StudentsProperty =
            DependencyProperty.Register("Students", typeof(ObservableCollection<Student>), typeof(Administrator));

        public ObservableCollection<Employee> Employees
        {
            get { return (ObservableCollection<Employee>)GetValue(MyPropertyEmployees); }
            set { SetValue(MyPropertyEmployees, value); }
        }

        public static readonly DependencyProperty MyPropertyEmployees =
            DependencyProperty.Register("Employees", typeof(ObservableCollection<Employee>), typeof(Administrator));

        public ObservableCollection<Schedule> Schedules
        {
            get { return (ObservableCollection<Schedule>)GetValue(SchedulesProperty); }
            set { SetValue(SchedulesProperty, value); }
        }

        public static readonly DependencyProperty SchedulesProperty =
            DependencyProperty.Register("Schedules", typeof(ObservableCollection<Schedule>), typeof(Administrator));
        #endregion

        public AdminOnePage()
        {
            DBConnect.db.Student.Load();
            _students = DBConnect.db.Student.Local;
            Students = _students;

            DBConnect.db.Employee.Load();
            _employees = DBConnect.db.Employee.Local;
            Employees = _employees;

            DBConnect.db.Schedule.Load();
            _schedules = DBConnect.db.Schedule.Local;
            Schedules = _schedules;

            InitializeComponent();

            //// добавление в таблицы, отдельно создал методами что бы потом в будущем просто их вызывать
            UpdateListStudents();
            UpdateListEmployees();
            UpdateListSchedules();
        }

        // эти залупы все нужны что бы добавить ебанные записи в ебанную таблицу, binding меня нахуй послал
        private void UpdateListStudents()
        {
            foreach (var item in Students)
                DataGridStudents.Items.Add(item);
        }
        private void UpdateListEmployees()
        {
            foreach (var item in Employees)
                DataGridEmployee.Items.Add(item);
        }
        private void UpdateListSchedules()
        {
            foreach (var item in Schedules)
                DataGridSchedule.Items.Add(item);
        }
    }

    #region Конвертор для соединения имени, фамилии и отчество для учеников
    [ValueConversion(typeof(Student), typeof(string))]
    public class NameLastnameSurnameStudents : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is Student student == false)
                return null;

            return student.Surname + " " + student.Name + " " + student.Lastname + " ";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture) => null;
    }
    #endregion

    #region Конвертор для соединения имени, фамилии и отчество для сотрудников 
    [ValueConversion(typeof(Employee), typeof(string))]
    public class NameLastnameSurnameEmployees : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is Employee employee == false)
                return null;

            return employee.Surname + " " + employee.Name + " " + employee.Lastname + " ";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture) => null;
    }
    #endregion

    #region Конвертор для отображения название предмента
    [ValueConversion(typeof(int), typeof(string))]
    public class NameLessonFromDataGrid : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is int lessonId == false)
                return 0;

            var lesson = from lessons in DBConnect.db.Lesson
                         where lessons.id == lessonId
                         select lessons;

            return lesson.First().Name;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture) => null;
    }
    #endregion
}
