using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для AdminPageLesson.xaml
    /// </summary>
    public partial class AdminPageLesson : Page
    {
        public ObservableCollection<Lesson> Lessons // вместо студента лесон
        {
            get { return (ObservableCollection<Lesson>)GetValue(LessonsProperty); }
            set { SetValue(LessonsProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty LessonsProperty =
            DependencyProperty.Register("Lessons", typeof(ObservableCollection<Lesson>), typeof(AdminPageLesson));
        public AdminPageLesson()
        {
            Lessons = DBConnect.db.Lesson.Local;
            
            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DataGridLessons.SelectedItem != null && Administrator.Ask(true) == false)
                return;

            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (entry.Entity is Lesson lesson == false)
                    return true;

                if (EntityValidator(lesson) == false)
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
        private bool EntityValidator(Lesson lesson) =>
            Lessons.Count(x => x.Name == lesson.Name) == 1;
        #endregion

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            var lesson = new Lesson() { Active = true };
            Lessons.Add(lesson);
            DataGridLessons.SelectedIndex = DataGridLessons.Items.Count - 1;
            DataGridLessons.ScrollIntoView(lesson);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            if (DataGridLessons.SelectedItem != null && Administrator.Ask(false) == false)
                return;

            ObservableCollection<Lesson> lessons = new ObservableCollection<Lesson>();

            foreach (Lesson item in DataGridLessons.SelectedItems)
                lessons.Add(item);

            foreach (Lesson item in lessons)
            {
                if (EntityValidator(item))
                {
                    Lessons.Where(x => x.id == item.id).FirstOrDefault().Active = false;
                }
                else
                {
                    Lessons.Remove(item);
                }
            }
            DataGridLessons.Items.Refresh();

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion
    }
}
