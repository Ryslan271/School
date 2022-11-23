using System.Collections.ObjectModel;
using System.Linq;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для AdminPageStudents.xaml
    /// </summary>
    public partial class AdminPageStudents : Page
    {
        private ObservableCollection<Class> _class;

        #region Связка с окном
        public ObservableCollection<Class> Classes
        {
            get { return _class; }
            set { _class = value; }
        }
        public ObservableCollection<Student> Students
        {
            get { return (ObservableCollection<Student>)GetValue(StudentsProperty); }
            set { SetValue(StudentsProperty, value); }
        }

        public static readonly DependencyProperty StudentsProperty =
            DependencyProperty.Register("Students", typeof(ObservableCollection<Student>), typeof(AdminPageStudents));
        #endregion

        public AdminPageStudents()
        {
            Students = DBConnect.db.Student.Local;

            _class = new ObservableCollection<Class> (DBConnect.db.Class.Local.Where(x => x.Activ == true));

            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DataGridStudents.SelectedItem != null && Administrator.Ask(true) == false)
                return;

            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (!(entry.Entity is Student student))
                    return true;

                if (EntityValidator(student) == false)
                {
                    Administrator.MessageInfoStart(false);
                    Administrator.TimerMessageInfo();
                    return false;
                }
                student.Surname.Trim();
                student.Name.Trim();
                student.Lastname.Trim();
                return true;
            });

            if (validationResult == false)
                return;

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();

        }
        private bool EntityValidator(Student student) =>
            Students.Count(x => x.Login == student.Login) == 1 &&
            student.Password != null &&
            Regex.IsMatch(student.Password.ToString().Trim(), @"\D") == false &&
            student.Lastname != null &&
            student.Name != null &&
            student.Surname != null;
        #endregion

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            Student student;
            if (Students.Count > 0)
                student = new Student() { Login = Students.Last().Login + 1, Activ = true };
            else
                student = new Student() { Login = 10001, Activ = true };
            Students.Add(student);
            DataGridStudents.SelectedIndex = DataGridStudents.Items.Count - 1;
            DataGridStudents.ScrollIntoView(student);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            if (DataGridStudents.SelectedItem == null)
                return;

            if (Administrator.Ask(false) == false)
                return;

            ObservableCollection<Student> students = new ObservableCollection<Student>();

            foreach (Student item in DataGridStudents.SelectedItems)
                students.Add(item);

            foreach (Student item in students)
            {
                if (EntityValidator(item))
                {
                    Students.Where(x => x.Login == item.Login).FirstOrDefault().Activ = false;
                }
                else
                {
                    Students.Remove(item);
                }
            }
            DataGridStudents.Items.Refresh();

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion

        private void DataGridStudents_LoadingRow(object sender, DataGridRowEventArgs e) => e.Row.Header = (e.Row.GetIndex() + 1).ToString();
    }
}
