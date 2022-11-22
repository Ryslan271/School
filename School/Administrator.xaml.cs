using System;
using System.Data.Entity.Validation;
using System.Windows;
using System.Windows.Media;
using System.Windows.Threading;

namespace School
{
    /// <summary>
    /// Логика взаимодействия для Паненли администратора
    /// </summary>
    public partial class Administrator : Window
    {
        public static Administrator Instance { get; private set; }

        public Administrator()
        {
            InitializeComponent();
            Instance = this;
        }

        #region Кнопки для перехода по страничкам
        private void Window_Closed(object sender, EventArgs e) => new MainWindow().Show();
        private void ButtonClickEmployee(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageEmployee());
        private void ButtonClickStudent(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageStudents());
        private void ButtonClickSchedules(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageSchedules());
        private void ButtonClickClass(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageClass());
        private void ButtonClickLesson(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageLesson());
        private void ButtonClickLessonEmployee(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageLessonEmployees());
        private void DuttonClickStudentLesson(object sender, RoutedEventArgs e) => PageAdmin.Navigate(new AdminPage.AdminPageStudentLesson());
        #endregion

        #region Вывод информации о сохранении
        public static bool Ask(bool flag)
        {
            if (flag == true)
                return MessageBox.Show("Сохранить изменения", "Уведомление", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes;
            else
                return MessageBox.Show("Удалить выделенную(ые) записи", "Уведомление", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes;
        }
        #endregion

        #region Сохранение изменений в бд
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
        #endregion

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
