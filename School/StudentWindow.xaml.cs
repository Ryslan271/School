using System;
using System.Collections;
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
using static System.Net.Mime.MediaTypeNames;
using School;
using System.Data.Entity;

namespace School
{
    /// <summary>
    /// Логика взаимодействия для StudentWindow.xaml
    /// </summary>
    public partial class StudentWindow : Window
    {

        public StudentWindow()
        {
            InitializeComponent();
            //Вывод ФИО ученика
            foreach (var entity in DBConnect.db.Student.Where(student => student.id == IdUSer.Id))
                NameStudent.Text = entity.Name + " " + entity.Surname + " " + entity.Lastname;
            //Вывод класса ученика
            foreach (var entity in DBConnect.db.Student.Where(s => s.id == IdUSer.Id).Select(c => c.Class))
                ClassStudent.Text += entity.Name + "\nПреподают:";
            //Вывод преподователей ученика
            foreach (var entity in DBConnect.db.StudentLesson.Where(c => c.IdStudent == IdUSer.Id).SelectMany(c => c.Lesson.LessonEmployee.Select(e => e.Employee)).Distinct())
                ListEmployee.Items.Add(entity.Name + " " + entity.Surname + " " + entity.Lastname);
            //Вывод предметов ученика
            foreach (var entity in DBConnect.db.Student.Where(s => s.id == IdUSer.Id).SelectMany(c => c.StudentLesson.Select(l => l.Lesson)))
                ListLesson.Items.Add(entity.Name);
            ThemeChange.ShowTheme();
        }
        //Отображение посещения ученика
        private void ListLesson_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ListVisit.Items.Clear();
            InitializeComponent();

            string lessons = "";

            foreach (var item in e.AddedItems)
                lessons += item.ToString();

            foreach (var entity in (DBConnect.db.Student.SelectMany(c => c.VisitLeson).Where(c => c.Lesson.Name == lessons && c.Student.id == IdUSer.Id)))
                if (entity.Presence)
                    ListVisit.Items.Add("Посетил занятия " + entity.DateVisitLessons.ToString().Substring(0,10) + " c " + entity.TimeStart + " до " + entity.TimeFinish);
                else
                    ListVisit.Items.Add("Пропустил занятия " + entity.DateVisitLessons.ToString().Substring(0, 10) + " c " + entity.TimeStart + " до " + entity.TimeFinish);
        }
        //Отображение информации об учителе
        private void ListEmployee_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            string name = "";
            string lastname = "";
            string fullname = "";
            foreach (var item in e.AddedItems)
            {
                name = item.ToString().Split(' ').First();
                lastname = item.ToString().Split(' ').Last();
                fullname = item.ToString();
            }
            ArrayList nameP = new ArrayList();
            nameP.Add("Преподаватель " + fullname + " ведет предметы: \n");
            foreach (var entity in DBConnect.db.Employee.Where(employee => employee.Name == name && employee.Lastname == lastname).SelectMany(l => l.LessonEmployee.Select(less => less.Lesson)))
                nameP.Add("● " + entity.Name);
            InfoMessageBox infoMessageBox = new InfoMessageBox(nameP);
            if (!InfoMessageBox.condition)
                infoMessageBox.Show();
            else
                infoMessageBox.Close();
        }
        //Открытие окна авторизации
        private void Window_Closed(object sender, EventArgs e) => new MainWindow().Show();

        private void Image_MouseUp(object sender, MouseButtonEventArgs e) => ThemeChange.Change();
    }
}
