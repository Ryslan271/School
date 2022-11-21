using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
using System.Data.Entity.Validation;
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
    /// Логика взаимодействия для AdminPageClass.xaml
    /// </summary>
    public partial class AdminPageClass : Page
    {
        public ObservableCollection<Class> Classes // вместо студента лесон
        {
            get { return (ObservableCollection<Class>)GetValue(ClassesProperty); }
            set { SetValue(ClassesProperty, value); }
        }

        // Using a DependencyProperty as the backing store for MyProperty.  This enables animation, styling, binding, etc...
        public static readonly DependencyProperty ClassesProperty =
            DependencyProperty.Register("Classes", typeof(ObservableCollection<Class>), typeof(AdminPageClass));

        public AdminPageClass()
        {
            Classes = DBConnect.db.Class.Local;

            InitializeComponent();
        }

        #region Сохранение 
        private void ButtonSaveClick(object sender, RoutedEventArgs e)
        {
            if (DataGridClasses.SelectedItem != null && Administrator.Ask(true) == false)
                return;

            if (DBConnect.db.ChangeTracker.HasChanges() == false)
                return;

            var validationResult = DBConnect.db.ChangeTracker.Entries().ToList().All(entry =>
            {
                if (entry.Entity is Class classs == false)
                    return true;

                if (EntityValidator(classs) == false)
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
        private bool EntityValidator(Class classs) =>
            Classes.Count(x => x.id == classs.id) == 1;
        #endregion

        #region Добавление новой строки в DataGrid
        private void ButtomAddClick(object sender, RoutedEventArgs e)
        {
            var classs = new Class() { Activ = true };
            Classes.Add(classs);
            DataGridClasses.SelectedIndex = DataGridClasses.Items.Count - 1;
            DataGridClasses.ScrollIntoView(classs);
        }
        #endregion

        #region Кнопка удаление
        private void ButtonDeleteClick(object sender, RoutedEventArgs e)
        {
            if (DataGridClasses.SelectedItem != null && Administrator.Ask(false) == false)
                return;

            ObservableCollection<Class> _classes = new ObservableCollection<Class>();

            foreach (Class item in DataGridClasses.SelectedItems)
                _classes.Add(item);

            foreach (Class item in _classes)
            {
                if (EntityValidator(item))
                {
                    Classes.Where(x => x.id == item.id).FirstOrDefault().Activ = false;
                }
                else
                {
                    Classes.Remove(item);
                }
            }
            DataGridClasses.Items.Refresh();

            Administrator.SaveChangeDB();

            Administrator.MessageInfoStart(true);
            Administrator.TimerMessageInfo();
        }
        #endregion
    }
}
