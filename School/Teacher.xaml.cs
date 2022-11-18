using School.ListWindow;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data.Entity;
using System.Linq;
using System.Runtime.CompilerServices;
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

namespace School
{
    /// <summary>
    /// Логика взаимодействия для Teacher.xaml
    /// </summary>

    public partial class Teacher : Window
    {

        //Ссылки на объекты бд
        IEnumerable<Student> students = DBConnect.db.Student;
        IEnumerable<Lesson> lesson = DBConnect.db.Lesson;
        IEnumerable<VisitLeson> visit = DBConnect.db.VisitLeson;
        IEnumerable<StudentLesson> studentLesson = DBConnect.db.StudentLesson;
        IEnumerable<LessonEmployee> lessonEmployees = DBConnect.db.LessonEmployee;

        //Словарик для сохранения объектов listbox'a
        public static Dictionary<string, bool> presenceList = new Dictionary<string, bool>();

        //Лист со списком предметов, по которым сегодня не отметили студентов
        List<string> missingLessonList = new List<string>();

        //Переменная checkBox'a
        private bool _Presence;
        public bool Presence
        {
            get
            {
                return _Presence;
            }
            set
            {
                if (_Presence == value) return;

                _Presence = value;
            }
        }
        public Teacher()
        {
            IdUSer.Id = 1;
            InitializeComponent();
            //Добавление предметов в ComboBox
            foreach (var entity in DBConnect.db.Employee.Where(employee => employee.id == IdUSer.Id).SelectMany(l => l.LessonEmployee.Select(less => less.Lesson)).Distinct())
                selectLessen.Items.Add(entity.Name.ToString());

            //Добавление сегоднящней даты
            titleList.Text += DateTime.Today.ToString("d");

            //Вывод фамилии преподавателя
            foreach (var entity in DBConnect.db.Employee.Where(emp => emp.id == IdUSer.Id))
                NameTeacher.Text = entity.Surname + " " + entity.Name + " " + entity.Lastname;

            //Запись в таблицу
            scheduleTable.ItemsSource = (from lessEmp in lessonEmployees
                                        from schedule in lessEmp.Schedule
                                         where lessEmp.IdEmployees == IdUSer.Id
                                        select new
                                        {
                                            NumberCabinet = schedule.NumberCabinet,
                                            idLessonEmployee = lessonEmployees.Where(l => l.id == schedule.idLessonEmloyee).Select(l => l.Lesson).Select(l => l.Name).FirstOrDefault().ToString(),
                                            DataTimeStart = schedule.DataTimeStart.ToString().Substring(0,5),
                                            DataTimeFinich = schedule.DataTimeFinich.ToString().Substring(0, 5)
                                        }).ToList();
            UpdateInfoMessage();
        }

        //Загрузка данных в БД
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (selectLessen.Text == "")
            {
                MessageBox.Show("Не заполнены поля");
                return;
            }

            //Удаление записей бд
            if (visit.Where(v => (v.DateVisitLessons == DateTime.Today) && (v.IdTeacher == IdUSer.Id) && (v.IdLesson == lesson.Where(l => l.Name == selectLessen.Text).First().id)).Select(v => v).Count() > 0)
            {
                foreach (var entity in visit.Where(v => (v.DateVisitLessons == DateTime.Today) && (v.IdTeacher == IdUSer.Id) && (v.IdLesson == lesson.Where(l => l.Name == selectLessen.Text).First().id)).Select(v => v))
                {
                    DBConnect.db.VisitLeson.Remove(entity);
                }
            }

            //Запись в бд
            foreach (var entity in presenceList)
            {
                VisitLeson visitLesson = new VisitLeson
                {
                    IdTeacher = IdUSer.Id,
                    IdLesson = lesson.Where(l => l.Name == selectLessen.Text).First().id,
                    IdStudent = students.Where(s => s.Name == entity.Key.Split(' ').FirstOrDefault() && s.Lastname == entity.Key.Split(' ').LastOrDefault()).Select(s => s.id).First(),
                    DateVisitLessons = DateTime.Today,
                    Presence = entity.Value
                };

                DBConnect.db.VisitLeson.Add(visitLesson);
            }
            DBConnect.db.SaveChanges();
            infoMessage.Foreground = Brushes.Green;
            infoMessage.Text = "Данные сохранены для предмета: " + (lesson.Where(l => l.Name == selectLessen.Text).First().Name);
        }
        //Отображение учеников в ListBox
        private void selectLessen_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateInfoMessage();
            presenceList.Clear();
            StudentLesson.ItemsSource = null;
            infoMessageStudent.Text = "";
            Presence = false;

            var queryStudent = (
                                from student in students
                                from lessonStudent in student.StudentLesson
                                where lessonStudent.IdLesson == (from less in lesson
                                                                 where less.Name == selectLessen.SelectedItem.ToString()
                                                                 select less).First().id
                                select new
                                {
                                    id = student.id,
                                    fullName = student.Name + " " + student.Surname + " " + student.Lastname,
                                    Presence = Presence
                                }).Distinct();
            if(queryStudent.Select(q => q).FirstOrDefault() == null)
            {
                infoMessageStudent.Text = "У вас нет учеников по этому предмету";
                return;
            }

            foreach (var entity in queryStudent)
            {
                presenceList.Add(entity.fullName, entity.Presence);
            }

            if (presenceList.Count > 0)
                StudentLesson.ItemsSource = queryStudent.ToList();
        }

        //метод для обновления текстового поля с информацией о не отмеченых студентов за сегодня
        public void UpdateInfoMessage()
        {
            missingLessonList.Clear();

            if (visit.Where(v => v.DateVisitLessons == DateTime.Today && v.IdTeacher == IdUSer.Id).Select(v => v.IdLesson).Count() > 0)
            {
                foreach (var entity in lesson.SelectMany(l => l.LessonEmployee).Where(emp => emp.IdEmployees == IdUSer.Id).Select(les => les.IdLesson).Distinct().ToList().Except(visit.Where(v => v.DateVisitLessons == DateTime.Today && v.IdTeacher == IdUSer.Id).Select(v => v.IdLesson).Distinct().ToList()))
                    missingLessonList.Add("" + lesson.Where(l => l.id == entity).Select(l => l.Name).FirstOrDefault().ToString());
            }
            else
            {
                foreach (var entity in lesson.SelectMany(l => l.LessonEmployee).Where(emp => emp.IdEmployees == IdUSer.Id).Select(les => les.IdLesson).Distinct().ToList())
                    missingLessonList.Add("" + lesson.Where(l => l.id == entity).Select(l => l.Name).FirstOrDefault().ToString());
            }

            if (missingLessonList.Count < 1)
            {
                infoMessage.Text = "Все ученики отмечены";
                infoMessage.Foreground = Brushes.Green;
            }
            else
            {
                infoMessage.Text = "За " + DateTime.Today.ToString("d") + " не отмечены ученики по предметам: \n";
                foreach (var entity in selectLessen.Items)
                    if(missingLessonList.Exists(m => m == entity.ToString()))
                        infoMessage.Text += entity + ", ";
                infoMessage.Foreground = Brushes.Red;
            }
        }

        //Открытие окна авторизации
        private void Window_Closed(object sender, EventArgs e) => new MainWindow().Show();

        private void addStudent_Click(object sender, RoutedEventArgs e)
        {
            if(!AddStudents.AddStudentLoad)
                new AddStudents().Show();
        }

        
        private void deleteStudent_Click(object sender, RoutedEventArgs e)
        {
            if(!DeleteStudents.deleteStudentsLoad)
                new DeleteStudents().Show();
        }

        private void CheckBox_Click(object sender, RoutedEventArgs e)
        {
            var checkBox = sender as CheckBox;
            presenceList.Remove(checkBox.Content.ToString());
            presenceList.Add(checkBox.Content.ToString(), (bool)checkBox.IsChecked);
        }

        private void Image_MouseUp_1(object sender, MouseButtonEventArgs e) => ThemeChange.Change();
    }
}