﻿using System;
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

namespace School
{
    /// <summary>
    /// Логика взаимодействия для InfoMessageBox.xaml
    /// </summary>
    public partial class InfoMessageBox : Window
    {
        public static bool condition = false;
        public InfoMessageBox(string text)
        {
            InitializeComponent();

            textInfo.Text = text;
        }

        private void Grid_Loaded(object sender, RoutedEventArgs e)
        {
            condition = true;
        }
    }
}
