using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using BookStore.Helpers;
using BookStore.Model;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Windows
{
    public partial class OrdersWindow : Window
    {
        private Order? _selectedOrder;

        public OrdersWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanViewOrders)
            {
                MessageBox.Show("Доступ к заказам запрещен.", "Ошибка прав доступа", MessageBoxButton.OK, MessageBoxImage.Error);
                Close();
                return;
            }

            LogoImage.Source = ImageHelper.LoadResourceImage("icon.png");
            var icon = ImageHelper.LoadResourceImage("icon.ico");
            if (icon != null)
            {
                Icon = icon;
            }

            UserFullNameTextBlock.Text = SessionContext.DisplayUserName;
            UserRoleTextBlock.Text = $"Роль: {SessionContext.DisplayRoleName}";

            // Управление заказами доступно только Администратору
            AdminOrdersPanel.Visibility = SessionContext.CanManageOrders
                ? Visibility.Visible
                : Visibility.Collapsed;

            LoadOrdersFromDatabase();
        }

        private void LoadOrdersFromDatabase()
        {
            try
            {
                using AppDbContext db = new AppDbContext();
                var orders = db.Orders
                    .Include(o => o.Status)
                    .Include(o => o.Client)
                    .Include(o => o.PickupPoint)
                        .ThenInclude(pp => pp.City)
                    .Include(o => o.PickupPoint)
                        .ThenInclude(pp => pp.Street)
                    .Include(o => o.OrderItems)
                        .ThenInclude(oi => oi.Product)
                    .OrderByDescending(o => o.Id)
                    .ToList();

                OrdersListBox.ItemsSource = orders;
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Ошибка загрузки заказов из базы данных.\n\nПричина: {ex.Message}\nРекомендация: проверьте подключение к PostgreSQL.",
                    "Ошибка подключения к БД",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }

        private void OrdersListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            _selectedOrder = OrdersListBox.SelectedItem as Order;
        }

        private void OrdersListBox_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (!SessionContext.CanManageOrders || _selectedOrder == null) return;
            OpenOrderEditWindow(_selectedOrder.Id);
        }

        private void AddOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageOrders) return;
            OpenOrderEditWindow(null);
        }

        private void EditOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageOrders) return;

            if (_selectedOrder == null)
            {
                MessageBox.Show(
                    "Заказ не выбран.\n\nПричина: не выбрана карточка заказа в списке.\nРекомендация: выберите заказ и повторите попытку.",
                    "Внимание",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information);
                return;
            }

            OpenOrderEditWindow(_selectedOrder.Id);
        }

        private void OpenOrderEditWindow(int? orderId)
        {
            OrderEditWindow editWindow = new OrderEditWindow(orderId);
            editWindow.ShowDialog();
            if (editWindow.IsSaved)
            {
                LoadOrdersFromDatabase();
            }
        }

        private void DeleteOrderButton_Click(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageOrders) return;

            if (_selectedOrder == null)
            {
                MessageBox.Show(
                    "Заказ не выбран.\n\nПричина: не выбрана карточка заказа для удаления.\nРекомендация: выделите заказ в списке и нажмите «Удалить заказ».",
                    "Внимание",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information);
                return;
            }

            var confirm = MessageBox.Show(
                $"Вы действительно хотите удалить заказ № {_selectedOrder.Id}?",
                "Подтверждение удаления",
                MessageBoxButton.YesNo,
                MessageBoxImage.Warning);

            if (confirm != MessageBoxResult.Yes) return;

            try
            {
                using AppDbContext db = new AppDbContext();
                var orderToDelete = db.Orders
                    .Include(o => o.OrderItems)
                    .FirstOrDefault(o => o.Id == _selectedOrder.Id);

                if (orderToDelete != null)
                {
                    db.OrderItems.RemoveRange(orderToDelete.OrderItems);
                    db.Orders.Remove(orderToDelete);
                    db.SaveChanges();

                    _selectedOrder = null;
                    LoadOrdersFromDatabase();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Ошибка удаления заказа.\n\nПричина: {ex.InnerException?.Message ?? ex.Message}\nРекомендация: проверьте связь с базой данных и повторите попытку.",
                    "Ошибка удаления",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
