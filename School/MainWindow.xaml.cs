using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure.Design;
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
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography.X509Certificates;
using School.Properties;
using System.Security.Policy;
using System.Windows.Threading;

namespace School
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        IEnumerable<Employee> employees = DBConnect.db.Employee;
        IEnumerable<Student> students = DBConnect.db.Student;
        public MainWindow()
        {

            InitializeComponent();
        }
        private void BtnInput_Click(object sender, RoutedEventArgs e)
        {
            if (LoginTextBox.Text != "" && PasswordBox.Password != "")
            {
                try
                {
                    int s = Convert.ToInt32(LoginTextBox.Text);
                    int d = Convert.ToInt32(PasswordBox.Password);
                }
                catch (FormatException)
                {
                    InfoMessage.Text = "В поле логина и пароля можно ввести только число";
                    LoginTextBox.Clear();
                    PasswordBox.Clear();
                    return;
                }
                #region check login and password

                foreach (var entity in employees.Where(employee => employee.IdJobTitle == 2))
                {
                    if (Convert.ToInt32(LoginTextBox.Text) == entity.Login && Convert.ToInt32(PasswordBox.Password) == entity.Password && entity.Activ == true)
                    {
                        IdUSer.Id = entity.id;
                        new Teacher().Show();
                        Hide();
                        return;
                    }
                }

                foreach (var entity in employees.Where(employee => employee.IdJobTitle != 2))
                {
                    if (Convert.ToInt32(LoginTextBox.Text) == entity.Login && Convert.ToInt32(PasswordBox.Password) == entity.Password  && entity.Activ == true)
                    {
                        IdUSer.Id = entity.id;
                        new Administrator().Show();
                        Hide();
                        return;
                    }
                }

                foreach (var entity in students)
                {
                    if (Convert.ToInt32(LoginTextBox.Text) == entity.Login && PasswordBox.Password == entity.Password && entity.Activ == true)
                    {
                        IdUSer.Id = entity.id;
                        new StudentWindow().Show();
                        Hide();
                        return;
                    }
                }



                InfoMessage.Text = "Логин или пароль неверный";
                #endregion
            }
            else InfoMessage.Text = "Не введены значения";
        }
        private void Window_Closed(object sender, EventArgs e) => Application.Current.Shutdown();

        private void Image_MouseUp(object sender, MouseButtonEventArgs e) => ThemeChange.Change();
    }
    public class IdUSer
    {
        public static int Id { get; set; }
    }
    public class ThemeChange
    {
        public static bool position { get; set; }
        public static void Change()
        {
            if (ThemeChange.position)
            {
                var uri = new Uri(@"StyleDictionary/WhiteTheme.xaml", UriKind.Relative);
                ResourceDictionary resourceDict = Application.LoadComponent(uri) as ResourceDictionary;
                Application.Current.Resources.Clear();
                Application.Current.Resources.MergedDictionaries.Add(resourceDict);
                ThemeChange.position = false;
            }
            else
            {
                var uri = new Uri(@"StyleDictionary/BlackTheme.xaml", UriKind.Relative);
                ResourceDictionary resourceDict = Application.LoadComponent(uri) as ResourceDictionary;
                Application.Current.Resources.Clear();
                Application.Current.Resources.MergedDictionaries.Add(resourceDict);
                ThemeChange.position = true;
            }
        }
        public static void ShowTheme()
        {
            if (!ThemeChange.position)
            {
                var uri = new Uri(@"StyleDictionary/WhiteTheme.xaml", UriKind.Relative);
                ResourceDictionary resourceDict = Application.LoadComponent(uri) as ResourceDictionary;
                Application.Current.Resources.Clear();
                Application.Current.Resources.MergedDictionaries.Add(resourceDict);
                ThemeChange.position = false;
            }
            if (ThemeChange.position)
            {
                var uri = new Uri(@"StyleDictionary/BlackTheme.xaml", UriKind.Relative);
                ResourceDictionary resourceDict = Application.LoadComponent(uri) as ResourceDictionary;
                Application.Current.Resources.Clear();
                Application.Current.Resources.MergedDictionaries.Add(resourceDict);
                ThemeChange.position = true;
            }
        }
    }
}
