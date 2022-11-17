using System;
using System.Collections.Generic;
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

namespace School.ListWindow
{
    /// <summary>
    /// Логика взаимодействия для DeleteStudents.xaml
    /// </summary>
    public partial class DeleteStudents : Window
    {
        IEnumerable<Student> students = DBConnect.db.Student;
        IEnumerable<StudentLesson> studentlesson = DBConnect.db.StudentLesson;
        IEnumerable<Lesson> lesson = DBConnect.db.Lesson;

        public static bool deleteStudentsLoad = false;
        List<string> missingStudentList = new List<string>();
        public DeleteStudents()
        {
            InitializeComponent();

            foreach (var entity in DBConnect.db.Employee.Where(employee => employee.id == IdUSer.Id).SelectMany(l => l.LessonEmployee.Select(less => less.Lesson)).Distinct())
                if (studentlesson.Where(sl => sl.IdLesson == entity.id).Select(sl => sl).FirstOrDefault() != null)
                    lessonList.Items.Add(entity.Name.ToString());
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {

            if (studentList.SelectedItems.Count < studentList.Items.Count)
            {
                List<Object> items = new List<Object>();
                foreach (var entity in studentList.Items)
                {
                    if (!studentList.SelectedItems.Contains(entity))
                        items.Add(entity);
                    else
                    {
                        foreach (var item in studentlesson.Where(sl => sl.IdLesson == lesson.Where(l => l.Name.Equals(lessonList.SelectedValue)).Select(l => l.id).FirstOrDefault() && sl.IdStudent == students.Where(s => s.Name == entity.ToString().Split(' ').FirstOrDefault()).Select(s => s.id).FirstOrDefault()).Select(sl => sl))
                            DBConnect.db.StudentLesson.Remove(item);
                    }
                }
                studentList.ItemsSource = items;
                DBConnect.db.SaveChangesAsync();
                return;
            }


            foreach (var entity in studentList.Items)
            {
                if (studentList.SelectedItems.Contains(entity))
                {
                    foreach (var item in studentlesson.Where(sl => sl.IdLesson == lesson.Where(l => l.Name.Equals(lessonList.SelectedValue)).Select(l => l.id).FirstOrDefault() && sl.IdStudent == students.Where(s => s.Name == entity.ToString().Split(' ').FirstOrDefault()).Select(s => s.id).FirstOrDefault()).Select(sl => sl))
                        DBConnect.db.StudentLesson.Remove(item);
                    infoMessage.Text = "Данные сохранены";
                }
            }
            DBConnect.db.SaveChangesAsync();
            studentList.ItemsSource = null;
        }

        private void lessonList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            missingStudentList.Clear();
            studentList.ItemsSource = null;
            infoMessage.Text = "";

            ComboBox cb = (ComboBox)sender;

            foreach (var entity in studentlesson.Where(sl => sl.IdLesson == lesson.Where(l => l.Name == lessonList.SelectedValue.ToString()).Select(l => l.id).FirstOrDefault()).Select(sl => sl.Student.Name + " " + sl.Student.Surname + " " + sl.Student.Lastname).Distinct())
                missingStudentList.Add(entity);

            studentList.ItemsSource = missingStudentList;

        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            deleteStudentsLoad = true;
        }
    }
}
