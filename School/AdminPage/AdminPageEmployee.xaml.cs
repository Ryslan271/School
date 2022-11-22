using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для AdminPageEmployee.xaml
    /// </summary>
    public partial class AdminPageEmployee : Page
    {
        #region Связка с окном
        public ObservableCollection<Employee> Employees
        {
            get { return (ObservableCollection<Employee>)GetValue(EmployeesProperty); }
            set { SetValue(EmployeesProperty, value); }
        }

        public static readonly DependencyProperty EmployeesProperty =
            DependencyProperty.Register("Employees", typeof(ObservableCollection<Employee>), typeof(AdminPageEmployee));
        #endregion

        public AdminPageEmployee()
        {
            Employees = DBConnect.db.Employee.Local;

            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DataGridEmployee.SelectedItem != null && Administrator.Ask(true) == false)
                return;

            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (!(entry.Entity is Employee employee))
                    return true;

                if (EntityValidator(employee) == false)
                {
                    Administrator.MessageInfoStart(false);
                    Administrator.TimerMessageInfo();
                    return false;
                }
                employee.Name.Trim();
                employee.Surname.Trim();
                employee.FullName.Trim();
                return true;
            });

            if (validationResult == false)
                return;

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();

        }
        private bool EntityValidator(Employee employee) =>
            employee.Lastname != "" &&
            employee.Name != "" &&
            employee.Surname != "" &&
            employee.Lastname != null &&
            employee.Name != null &&
            employee.Surname != null &&
            employee.Password > 0 &&
            employee.Password.ToString().Length >= 3;
        #endregion

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            Employee employee;
            if (Employees.Count > 0)
                employee = new Employee() { IdJobTitle = 2, Login = Employees.Last().Login + 1, Activ = true };
            else
                employee = new Employee() { IdJobTitle = 2, Login = 232001, Activ = true };
            Employees.Add(employee);
            DataGridEmployee.SelectedIndex = DataGridEmployee.Items.Count - 1;
            DataGridEmployee.ScrollIntoView(employee);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            if (DataGridEmployee.SelectedItem == null)
                return;

            if (Administrator.Ask(false) == false)
                return;

            ObservableCollection<Employee> employees = new ObservableCollection<Employee>();

            foreach (Employee item in DataGridEmployee.SelectedItems)
                employees.Add(item);

            foreach (Employee item in employees)
            {
                if (EntityValidator(item))
                {
                    Employees.Where(x => x.Login == item.Login).FirstOrDefault().Activ = false;
                }
                else
                {
                    Employees.Remove(item);
                }
            }

            DataGridEmployee.Items.Refresh();

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();

        }
        #endregion
    }
}
