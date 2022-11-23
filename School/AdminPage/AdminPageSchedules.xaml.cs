using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.Entity;
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
    /// Логика взаимодействия для AdminPageSchedules.xaml
    /// </summary>
    public partial class AdminPageSchedules : Page
    {
        private ObservableCollection<Employee> _employees;
        private ObservableCollection<Lesson> _lesson;

        #region Связка с окном
        public ObservableCollection<Employee> Employees
        {
            get { return _employees; }
            set { _employees = value; }
        }
        public ObservableCollection<Lesson> Lessons
        {
            get { return _lesson; }
            set { _lesson = value; }
        }
        public ObservableCollection<Schedule> Schedules
        {
            get { return (ObservableCollection<Schedule>)GetValue(SchedulesProperty); }
            set { SetValue(SchedulesProperty, value); }
        }

        public static readonly DependencyProperty SchedulesProperty =
            DependencyProperty.Register("Schedules", typeof(ObservableCollection<Schedule>), typeof(AdminPageSchedules));
        #endregion

        public AdminPageSchedules()
        {
            Schedules = new ObservableCollection<Schedule> 
                (DBConnect.db.Schedule.Local.Where(x => x.LessonEmployee.Employee.Activ == true && x.LessonEmployee.Lesson.Active == true));

            _employees = new ObservableCollection<Employee> (DBConnect.db.Employee.Local.Where(x => x.Activ == true));

            _lesson = new ObservableCollection<Lesson> (DBConnect.db.Lesson.Local.Where(x => x.Active == true));

            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DataGridSchedule.SelectedItem != null && Administrator.Ask(true) == false)
                return;

            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (!(entry.Entity is Schedule schedule))
                    return true;

                if (schedule.LessonEmployee.Employee.Activ == false || schedule.LessonEmployee.Lesson.Active == false)
                    schedule.Activ = false;

                else if (schedule.LessonEmployee.Employee.Activ == true && schedule.LessonEmployee.Lesson.Active == true)
                    schedule.Activ = true;

                if (EntityValidator(schedule) == false)
                {
                    Administrator.MessageInfoStart(false);
                    Administrator.TimerMessageInfo();
                    return false;
                }

                schedule.DataTimeFinich = schedule.DataTimeStart + new TimeSpan(0, 45, 0);

                return true;
            });

            if (validationResult == false)
                return;

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion

        private bool EntityValidator(Schedule schedule) =>  Schedules.Count(x => x.NumberCabinet == schedule.NumberCabinet && 
                                                            x.idLessonEmloyee == schedule.idLessonEmloyee) == 1 &&
                                                            schedule.NumberCabinet != null &&
                                                            schedule.DataTimeStart != null;

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            var schedule = new Schedule() { Activ = true };
            Schedules.Add(schedule);
            DataGridSchedule.SelectedIndex = DataGridSchedule.Items.Count - 1;
            DataGridSchedule.ScrollIntoView(schedule);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            if (DataGridSchedule.SelectedItem == null)
                return;

            if (Administrator.Ask(false) == false)
                return;

            ObservableCollection<Schedule> Schedule = new ObservableCollection<Schedule>();

            foreach (Schedule item in DataGridSchedule.SelectedItems)
                Schedule.Add(item);

            foreach (Schedule item in Schedule)
            {
                if (item.NumberCabinet != null && item.idLessonEmloyee != null)
                {
                    if (!(DBConnect.db.Schedule.Any(x => x.DataTimeFinich == item.DataTimeFinich &&
                                                            x.DataTimeStart == item.DataTimeStart &&
                                                            x.id == item.id &&
                                                            x.NumberCabinet == item.NumberCabinet &&
                                                            item.idLessonEmloyee == x.idLessonEmloyee)))
                        continue;

                    Schedules.Where(x => x.id == item.id).FirstOrDefault().Activ = false;
                    continue;
                }
                Schedules.Remove(item);
            }
            DataGridSchedule.Items.Refresh();

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion

        #region Работа с TimeSpam колонки времени
        private void DataGridSchedule_CellEditEnding(object sender, DataGridCellEditEndingEventArgs e)
        {
            if (!(e.Column.Header.ToString() == "Начало урока") || !(e.EditingElement is TextBox editingElement))
                return;

            Match match = Regex.Match(editingElement.Text.Trim(), @"^(?:(?<Datetime>\d{1,2}:(?:\d{1,2}))|(?<Hours>\d{1,2}))");

            string dateTime = match.Groups["Datetime"].Value;
            if (match.Success)
                editingElement.Text = dateTime == string.Empty ? $"{match.Groups["Hours"].Value}:00" : dateTime;
            else
                editingElement.Text = null;
        }
        #endregion

        private void DataGridSchedule_LoadingRow(object sender, DataGridRowEventArgs e) => e.Row.Header = (e.Row.GetIndex() + 1).ToString();
    }
}
