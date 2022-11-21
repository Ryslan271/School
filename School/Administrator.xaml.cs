using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
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
using System.Windows.Shapes;
using System.Windows.Threading;
using static System.Net.Mime.MediaTypeNames;

namespace School
{
    /// <summary>
    /// Логика взаимодействия для Administrator.xaml
    /// </summary>
    public partial class Administrator : Window
    {
        public static Administrator Instance { get; private set; }

        public Administrator()
        {
            InitializeComponent();
            Instance = this;
        }

        private void Window_Closed(object sender, EventArgs e) => new MainWindow().Show();
        private void ButtonClickEmployee(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageEmployee());
        private void ButtonClickStudent(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageStudents());
        private void ButtonClickSchedules(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageSchedules());
        private void ButtonClickClass(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageClass());
        private void ButtonClickLesson(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageLesson());
        private void ButtonClickLessonEmployee(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageLessonEmployees());
        public static bool Ask(bool flag)
        {
            if (flag == true)
                return MessageBox.Show("Сохранить изменения", "Уведомление", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes;
            else
                return MessageBox.Show("Удалить выделенную(ые) записи", "Уведомление", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes;
        }

        public static void SaveChangeDB()
        {
            try
            {
                DBConnect.db.SaveChanges();
            }
            catch (DbEntityValidationException)
            {
                MessageInfoStart(false);
                TimerMessageInfo();
            }
        }

        #region Штука для вывода инфы
        public static void TimerMessageInfo()
        {
            DispatcherTimer timer = new DispatcherTimer();
            timer.Tick += new EventHandler(Timer_Tick);
            timer.Interval = new TimeSpan(0, 0, 5);
            timer.Start();
        }

        public static void MessageInfoStart(bool flag)
        {
            if (flag == true)
            {
                Instance.MessageInfo.Text = "Все данные сохранены";
                Instance.MessageInfo.Foreground = Brushes.Green;
            }
            else
            {
                Instance.MessageInfo.Text = "Произошла ошибка, пожалуйста, проверьте введенные данные";
                Instance.MessageInfo.Foreground = Brushes.Red;
            }
        }
        private static void Timer_Tick(object sender, EventArgs e)
        {
            Instance.MessageInfo.Text = "";
        }
        #endregion

    }
}
