using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для AdminPageLessonEmployees.xaml
    /// </summary>
    public partial class AdminPageLessonEmployees : Page
    {
        private ObservableCollection<Lesson> _lessons;

        #region Связка с окном
        public ObservableCollection<Employee> Employees
        {
            get { return (ObservableCollection<Employee>)GetValue(EmployeesProperty); }
            set { SetValue(EmployeesProperty, value); }
        }

        public static readonly DependencyProperty EmployeesProperty =
            DependencyProperty.Register("Employees", typeof(ObservableCollection<Employee>), typeof(AdminPageLessonEmployees));

        public ObservableCollection<Lesson> Lessons
        {
            get { return _lessons; }
            set { _lessons = value; }
        }

        public ObservableCollection<LessonEmployee> LessonEmployees
        {
            get { return (ObservableCollection<LessonEmployee>)GetValue(LessonEmployeesProperty); }
            set { SetValue(LessonEmployeesProperty, value); }
        }

        public static readonly DependencyProperty LessonEmployeesProperty =
            DependencyProperty.Register("LessonEmployees", typeof(ObservableCollection<LessonEmployee>), typeof(AdminPageLessonEmployees));
        #endregion

        public AdminPageLessonEmployees()
        {
            Employees = new ObservableCollection<Employee> (DBConnect.db.Employee.Local.Where(x => x.Activ == true));

            _lessons = new ObservableCollection<Lesson>(DBConnect.db.Lesson.Local.Where(x => x.Active == true));

            LessonEmployees = new ObservableCollection<LessonEmployee> 
                (DBConnect.db.LessonEmployee.Local.Where(x => x.Lesson.Active == true && x.Employee.Activ == true));

            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DataGridLessonEmployees.SelectedItem != null && Administrator.Ask(true) == false)
                return;

            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (!(entry.Entity is LessonEmployee lessonEmployee))
                    return true;

                if (EntityValidator(lessonEmployee) == false)
                {
                    Administrator.MessageInfoStart(false);
                    Administrator.TimerMessageInfo();
                    return false;
                }
                return true;
            });

            if (validationResult == false)
                return;

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();

        }
        private bool EntityValidator(LessonEmployee lessonEmployee) => LessonEmployees.Count(x => x.IdLesson == lessonEmployee.IdLesson &&
                                                                       x.IdEmployees == lessonEmployee.IdEmployees) == 1;
        #endregion

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            LessonEmployee lessonEmployee = new LessonEmployee();

            LessonEmployees.Add(lessonEmployee);
            DataGridLessonEmployees.SelectedIndex = DataGridLessonEmployees.Items.Count - 1;
            DataGridLessonEmployees.ScrollIntoView(lessonEmployee);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            if (DataGridLessonEmployees.SelectedItem == null)
                return;

            if (Administrator.Ask(false) == false)
                return;

            ObservableCollection<LessonEmployee> essonEmployees = new ObservableCollection<LessonEmployee>();

            foreach (LessonEmployee item in DataGridLessonEmployees.SelectedItems)
                essonEmployees.Add(item);

            foreach (var item in essonEmployees)
                LessonEmployees.Remove(item);

            DataGridLessonEmployees.Items.Refresh();

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion

        private void DataGridLessonEmployees_LoadingRow(object sender, DataGridRowEventArgs e) => e.Row.Header = (e.Row.GetIndex() + 1).ToString();
    }
}
