using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
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
    /// Логика взаимодействия для AdminPageStudentLesson.xaml
    /// </summary>
    public partial class AdminPageStudentLesson : Page
    {
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


        public AdminPageStudentLesson()
        {
            Lessons = DBConnect.db.Lesson.Local;

            Students = DBConnect.db.Student.Local;

            StudentLessons = DBConnect.db.StudentLesson.Local;

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
            StudentLessons.Count( x => studentLesson.IdStudent == x.IdStudent &&
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

            if (IfDelete(studentLesson)) {
                Administrator.SaveChangeDB();

                Administrator.MessageInfoStart(true);
                Administrator.TimerMessageInfo();
            }

            DataGridStudentLesson.Items.Refresh();
        }

        private bool IfDelete(ObservableCollection<StudentLesson> studentLesson)
        {
            bool f = true;

            foreach (StudentLesson item in studentLesson)
            {
                if (!(item.IdLesson.ToString() != "" && item.IdStudent.ToString() != "" &&
                    item.IdLesson.ToString() != null && item.IdStudent.ToString() != null))
                    continue;

                StudentLessons.Remove(item);
                f = false;
            }
            return f;
        }
        #endregion
    }
}
