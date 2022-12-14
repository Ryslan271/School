using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.ExceptionServices;
using System.Runtime.InteropServices;
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
    /// Логика взаимодействия для AddStudents.xaml
    /// </summary>
    public partial class AddStudents : Window
    {
        IEnumerable<Student> students = DBConnect.db.Student;
        IEnumerable<StudentLesson> studentlesson = DBConnect.db.StudentLesson;
        IEnumerable<Lesson> lesson = DBConnect.db.Lesson;
        IEnumerable<Schedule> schedules = DBConnect.db.Schedule;
        IEnumerable<Employee> employees = DBConnect.db.Employee;
        public static bool AddStudentLoad = false;

        List<string> missingStudentList = new List<string>();
        public AddStudents()
        {
            InitializeComponent();

            foreach (var entity in employees.Where(e => e.id == IdUSer.Id).SelectMany(s => s.LessonEmployee).Select(l => l.Lesson))
            {
                lessonList.Items.Add(entity.Name);
            }
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
                        StudentLesson student = new StudentLesson
                        {
                            IdLesson = lesson.Where(l => l.Name.Equals(lessonList.SelectedValue)).Select(l => l.id).FirstOrDefault(),
                            IdStudent = students.Where(s => s.Name == entity.ToString().Split(' ').FirstOrDefault()).Select(s => s.id).FirstOrDefault()
                        };
                        DBConnect.db.StudentLesson.Add(student);
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
                    StudentLesson student = new StudentLesson
                    {
                        IdLesson = lesson.Where(l => l.Name.Equals(lessonList.SelectedValue)).Select(l => l.id).FirstOrDefault(),
                        IdStudent = students.Where(s => s.Name == entity.ToString().Split(' ').FirstOrDefault()).Select(s => s.id).FirstOrDefault()
                    };
                    DBConnect.db.StudentLesson.Add(student);
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

            foreach (var entity in students.Select(s => s.id).Except(lesson.Where(l => l.Name.Equals(lessonList.SelectedItem.ToString())).SelectMany(l => l.StudentLesson).Select(l => l.IdStudent)))
            {
                missingStudentList.Add((from st in students
                                       where st.id == entity
                                       select st.Name + " " + st.Surname + " " + st.Lastname).FirstOrDefault());
            }
            
            if (missingStudentList.Count > 0)
                studentList.ItemsSource = missingStudentList;
            else
                infoMessage.Text = "Все ученики добавлены на этот предмет";

        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            AddStudentLoad = true;
        }

        private void Window_Closed(object sender, EventArgs e)
        {
            AddStudentLoad = false;
        }
    }
}