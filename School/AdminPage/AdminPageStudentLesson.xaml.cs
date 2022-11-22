using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для AdminPageStudentLesson.xaml
    /// </summary>
    public partial class AdminPageStudentLesson : Page
    {
        #region Связка с окном
        public ObservableCollection<Lesson> Lessons
        {
            get { return (ObservableCollection<Lesson>)GetValue(LessonsProperty); }
            set { SetValue(LessonsProperty, value); }
        }

        public static readonly DependencyProperty LessonsProperty =
            DependencyProperty.Register("Lessons", typeof(ObservableCollection<Lesson>), typeof(AdminPageStudentLesson));

        public ObservableCollection<Student> Students
        {
            get { return (ObservableCollection<Student>)GetValue(StudentsProperty); }
            set { SetValue(StudentsProperty, value); }
        }

        public static readonly DependencyProperty StudentsProperty =
            DependencyProperty.Register("Students", typeof(ObservableCollection<Student>), typeof(AdminPageStudentLesson));

        public ObservableCollection<StudentLesson> StudentLessons
        {
            get { return (ObservableCollection<StudentLesson>)GetValue(StudentLessonsProperty); }
            set { SetValue(StudentLessonsProperty, value); }
        }

        public static readonly DependencyProperty StudentLessonsProperty =
            DependencyProperty.Register("StudentLessons", typeof(ObservableCollection<StudentLesson>), typeof(AdminPageStudentLesson));
        #endregion

        public AdminPageStudentLesson()
        {
            Lessons = new ObservableCollection<Lesson> (DBConnect.db.Lesson.Local.Where(x => x.Active == true));

            Students = new ObservableCollection<Student> (DBConnect.db.Student.Local.Where(x => x.Activ == true));

            StudentLessons = new ObservableCollection<StudentLesson> 
                (DBConnect.db.StudentLesson.Local.Where(x => x.Student.Activ == true && x.Lesson.Active == true));

            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DataGridStudentLesson.SelectedItem != null && Administrator.Ask(true) == false)
                return;

            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (!(entry.Entity is StudentLesson studentLesson))
                    return true;

                if (EntityValidator(studentLesson) == false)
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
        #endregion

        private bool EntityValidator(StudentLesson studentLesson) =>
            StudentLessons.Count(x => studentLesson.IdStudent == x.IdStudent &&
                                       studentLesson.IdLesson == x.IdLesson) == 1;

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            var studentLesson = new StudentLesson();
            StudentLessons.Add(studentLesson);
            DataGridStudentLesson.SelectedIndex = DataGridStudentLesson.Items.Count - 1;
            DataGridStudentLesson.ScrollIntoView(studentLesson);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            if (DataGridStudentLesson.SelectedItem == null)
                return;

            if (Administrator.Ask(false) == false)
                return;

            ObservableCollection<StudentLesson> studentLesson = new ObservableCollection<StudentLesson>();

            foreach (StudentLesson item in DataGridStudentLesson.SelectedItems)
                studentLesson.Add(item);

            foreach (StudentLesson item in studentLesson)
            {
                if (!(item.IdLesson.ToString() != "" && item.IdStudent.ToString() != "" &&
                    item.IdLesson != null && item.IdStudent != null))
                    continue;

                StudentLessons.Remove(item);
            }

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();

            DataGridStudentLesson.Items.Refresh();
        }
        #endregion
    }
}
