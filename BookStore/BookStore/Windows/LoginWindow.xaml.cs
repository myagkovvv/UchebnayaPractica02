using BookStore.Helpers;
using BookStore.Model;
using Microsoft.EntityFrameworkCore;
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

namespace BookStore.Windows
{
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LogoImage.Source = ImageHelper.LoadResourceImage("logo.png");
            var icon = ImageHelper.LoadResourceImage("app.ico");
            if (icon != null)
            {
                Icon = icon;
            }
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            string login = LoginTextBox.Text.Trim();
            string password = PasswordBox.Password;

            if (string.IsNullOrWhiteSpace(login) || string.IsNullOrWhiteSpace(password))
            {
                MessageBox.Show(
                    "Не заполнены обязательные поля.\n\nПричина: логин или пароль не введены.\nРекомендация: введите логин и пароль, затем повторите попытку.",
                    "Ошибка авторизации",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            try
            {
                using AppDbContext db = new AppDbContext();
                var user = db.Users
                    .Include(u => u.Role)
                    .FirstOrDefault(u => u.Login == login && u.Password == password);

                if (user == null)
                {
                    MessageBox.Show(
                        "Неверный логин или пароль.\n\nПричина: пользователь с указанными учетными данными не найден в базе данных.\nРекомендация: проверьте раскладку клавиатуры, регистр символов и повторите ввод.",
                        "Ошибка авторизации",
                        MessageBoxButton.OK,
                        MessageBoxImage.Error);
                    return;
                }

                SessionContext.LoginAsUser(user);
                OpenProductsWindow();
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Ошибка подключения к базе данных.\n\nПричина: {ex.Message}\nРекомендация: убедитесь, что служба PostgreSQL запущена и база данных BookStore доступна.",
                    "Ошибка подключения к БД",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }

        private void GuestButton_Click(object sender, RoutedEventArgs e)
        {
            SessionContext.LoginAsGuest();
            OpenProductsWindow();
        }

        private void OpenProductsWindow()
        {
            ProductsWindow productsWindow = new ProductsWindow();
            productsWindow.Show();
            Close();
        }
    }
}
