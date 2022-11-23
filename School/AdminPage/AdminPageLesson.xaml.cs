using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для AdminPageLesson.xaml
    /// </summary>
    public partial class AdminPageLesson : Page
    {
        #region Связка с окном
        public ObservableCollection<Lesson> Lessons
        {
            get { return (ObservableCollection<Lesson>)GetValue(LessonsProperty); }
            set { SetValue(LessonsProperty, value); }
        }

        public static readonly DependencyProperty LessonsProperty =
            DependencyProperty.Register("Lessons", typeof(ObservableCollection<Lesson>), typeof(AdminPageLesson));
        #endregion

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
                if (!(entry.Entity is Lesson lesson))
                    return true;

                if (EntityValidator(lesson) == false)
                {
                    Administrator.MessageInfoStart(false);
                    Administrator.TimerMessageInfo();
                    return false;
                }
                lesson.Name.Trim();
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
            if (DataGridLessons.SelectedItem == null)
                return;

            if (Administrator.Ask(false) == false)
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

        private void DataGridLessons_LoadingRow(object sender, DataGridRowEventArgs e) => e.Row.Header = (e.Row.GetIndex() + 1).ToString();
    }
}
