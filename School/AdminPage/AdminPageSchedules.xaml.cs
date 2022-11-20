using System;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace School.AdminPage
{
    /// <summary>
    /// Логика взаимодействия для AdminPageSchedules.xaml
    /// </summary>
    public partial class AdminPageSchedules : Page
    {
        private ObservableCollection<Employee> _employees;
        private ObservableCollection<Lesson> _lesson;
        private ObservableCollection<LessonEmployee> _lessonEmployee;
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

        public ObservableCollection<Week> WeekDays
        {
            get { return (ObservableCollection<Week>)GetValue(WeekDaysProperty); }
            set { SetValue(WeekDaysProperty, value); }
        }

        // Using a DependencyProperty as the backing store for WeekDays.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty WeekDaysProperty =
            DependencyProperty.Register("WeekDays", typeof(ObservableCollection<Week>), typeof(AdminPageSchedules));

        public ObservableCollection<Schedule> Schedules
        {
            get { return (ObservableCollection<Schedule>)GetValue(SchedulesProperty); }
            set { SetValue(SchedulesProperty, value); }
        }

        // Using a DependencyProperty as the backing store for Schedules.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty SchedulesProperty =
            DependencyProperty.Register("Schedules", typeof(ObservableCollection<Schedule>), typeof(AdminPageSchedules));

        public AdminPageSchedules()
        {
            DBConnect.db.Schedule.Load();
            Schedules = DBConnect.db.Schedule.Local;

            DBConnect.db.LessonEmployee.Load();
            _lessonEmployee = DBConnect.db.LessonEmployee.Local;

            DBConnect.db.Employee.Load();
            _employees = DBConnect.db.Employee.Local;

            DBConnect.db.Week.Load();
            WeekDays = DBConnect.db.Week.Local;

            DBConnect.db.Lesson.Load();
            _lesson = DBConnect.db.Lesson.Local;

            InitializeComponent();

            DBConnect.db.Configuration.AutoDetectChangesEnabled = true;
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (entry.Entity is Schedule schedule == false)
                    return true;

                if (EntityValidator(schedule) == false)
                {
                    Administrator.MessageInfoStart(false);
                    Administrator.TimerMessageInfo();
                    return false;
                }

                schedule.DataTimeFinich = schedule.DataTimeStart + new TimeSpan(0, 40 , 0);

                return true;
            });

            if (validationResult == false)
                return;

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion

        private bool EntityValidator(Schedule schedule) => Schedules.Count(
                                                            x => x.DataTimeStart == schedule.DataTimeStart &&
                                                            x.id == schedule.id &&
                                                            x.NumberCabinet == schedule.NumberCabinet &&
                                                            schedule.idLessonEmloyee == x.idLessonEmloyee) == 1 &&
                                                            Schedules.Any(x => x.id == schedule.id &&
                                                            x.idWeek == x.idWeek &&
                                                            x.DataTimeStart != x.DataTimeStart) &&
                                                            schedule.DataTimeStart != null;

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            var schedule = new Schedule() { DataTimeStart = new TimeSpan(9, 45, 0), Activ = true};
            Schedules.Add(schedule);
            DataGridSchedule.SelectedIndex = DataGridSchedule.Items.Count - 1;
            DataGridSchedule.ScrollIntoView(schedule);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            ObservableCollection<Schedule> Schedule = new ObservableCollection<Schedule>();

            foreach (Schedule item in DataGridSchedule.SelectedItems) 
                Schedule.Add(item);

            foreach (Schedule item in Schedule)
            {
                if (item.NumberCabinet.ToString() != null && item.idWeek.ToString() != null)
                {
                    if (DBConnect.db.Schedule.Any(x => x.DataTimeFinich == item.DataTimeFinich &&
                                                        x.DataTimeStart == item.DataTimeStart &&
                                                        x.id == item.id &&
                                                        x.NumberCabinet == item.NumberCabinet &&
                                                        item.idLessonEmloyee == x.idLessonEmloyee))
                    {
                        Schedules.Where(x => x.id == item.id).FirstOrDefault().Activ = false;
                        continue;
                    }
                }
                Schedules.Remove(item);
            }

            DataGridSchedule.Items.Refresh();

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion

        private void DataGridSchedule_CellEditEnding(object sender, DataGridCellEditEndingEventArgs e)
        {
            if (e.EditingElement is ComboBox editingCombox && editingCombox.SelectedItem is Employee selectedEmployee)
            {
                _lesson = new ObservableCollection<Lesson>(_lessonEmployee.Where(x => x.IdEmployees == selectedEmployee.id).Select(i => i.Lesson));
            }
        }
    }
}
