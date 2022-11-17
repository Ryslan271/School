using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
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
    /// Логика взаимодействия для AdminPageSchedules.xaml
    /// </summary>
    public partial class AdminPageSchedules : Page
    {
        private ObservableCollection<Employee> _employees;
        private ObservableCollection<Lesson> _lesson;
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

        // Using a DependencyProperty as the backing store for Schedules.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty SchedulesProperty =
            DependencyProperty.Register("Schedules", typeof(ObservableCollection<Schedule>), typeof(AdminPageSchedules));


        public AdminPageSchedules()
        {
            DBConnect.db.Schedule.Load();
            Schedules = DBConnect.db.Schedule.Local;

            DBConnect.db.Employee.Load();
            _employees = DBConnect.db.Employee.Local;

            DBConnect.db.Lesson.Load();
            _lesson = DBConnect.db.Lesson.Local;

            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            try
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
                    return true;
                });

                if (validationResult == false)
                    return;

                DBConnect.db.SaveChanges();

                Administrator.MessageInfoStart(true);
                Administrator.TimerMessageInfo();
            }
            catch (Exception)
            {
                Administrator.MessageInfoStart(false);
                Administrator.TimerMessageInfo();
            }
        }
        private bool EntityValidator(Schedule schedule) => Schedules.Count(x => x.DataTimeFinich == schedule.DataTimeFinich &&
                                                                           x.DataTimeStart == schedule.DataTimeStart &&
                                                                           x.id == schedule.id &&
                                                                           x.NumberCabinet == schedule.NumberCabinet &&
                                                                           schedule.idLessonEmloyee == x.idLessonEmloyee) == 1;
        #endregion

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            var schedule = new Schedule();
            Schedules.Add(schedule);
            DataGridSchedule.SelectedIndex = DataGridSchedule.Items.Count - 1;
            DataGridSchedule.ScrollIntoView(schedule);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            try
            {
                ObservableCollection<Schedule> Schedule = new ObservableCollection<Schedule>();

                foreach (Schedule item in DataGridSchedule.SelectedItems)
                    Schedule.Add(item);

                foreach (Schedule item in Schedule)
                {
                    if (item.NumberCabinet != null && item.DataTimeStart != null && item.idLessonEmloyee != null)
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
                }
                DataGridSchedule.Items.Refresh();
                DBConnect.db.SaveChanges();

                Administrator.MessageInfoStart(true);
                Administrator.TimerMessageInfo();
            }
            catch (Exception)
            {
                Administrator.MessageInfoStart(false);
                Administrator.TimerMessageInfo();
            }
        }
        #endregion
    }
}
