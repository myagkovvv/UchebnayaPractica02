using System;
using System.Linq;
using System.Windows;
using BookStore.Helpers;
using BookStore.Model;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Windows
{
    public partial class OrderEditWindow : Window
    {
        private readonly int? _editingOrderId;
        public bool IsSaved { get; private set; }

        public OrderEditWindow(int? orderId = null)
        {
            InitializeComponent();
            _editingOrderId = orderId;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageOrders)
            {
                MessageBox.Show("Доступ запрещен.", "Ошибка прав доступа", MessageBoxButton.OK, MessageBoxImage.Error);
                Close();
                return;
            }

            var icon = ImageHelper.LoadResourceImage("icon.ico");
            if (icon != null)
            {
                Icon = icon;
            }

            LoadReferenceData();

            if (_editingOrderId.HasValue)
            {
                Title = "ООО «ЧитайГород» — Редактирование заказа";
                HeaderTextBlock.Text = $"Редактирование заказа № {_editingOrderId.Value}";
                LoadOrderData(_editingOrderId.Value);
            }
            else
            {
                Title = "ООО «ЧитайГород» — Добавление заказа";
                HeaderTextBlock.Text = "Добавление нового заказа";
                OrderDatePicker.SelectedDate = DateTime.Today;
                DeliveryDatePicker.SelectedDate = DateTime.Today.AddDays(5);
                GenerateNextPickupCode();
            }
        }

        private void LoadReferenceData()
        {
            try
            {
                using AppDbContext db = new AppDbContext();
                ProductComboBox.ItemsSource = db.Products.OrderBy(p => p.Article).ToList();
                StatusComboBox.ItemsSource = db.OrderStatuses.OrderBy(s => s.Id).ToList();
                PickupPointComboBox.ItemsSource = db.PickupPoints
                    .Include(pp => pp.City)
                    .Include(pp => pp.Street)
                    .OrderBy(pp => pp.Id)
                    .ToList();
                ClientComboBox.ItemsSource = db.Users
                    .Where(u => u.RoleId == 3)
                    .OrderBy(u => u.FullName)
                    .ToList();

                if (StatusComboBox.Items.Count > 0) StatusComboBox.SelectedIndex = 0;
                if (ClientComboBox.Items.Count > 0) ClientComboBox.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки справочников.\n\nПричина: {ex.Message}", "Ошибка БД", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void GenerateNextPickupCode()
        {
            try
            {
                using AppDbContext db = new AppDbContext();
                int maxCode = db.Orders.Any() ? db.Orders.Max(o => o.PickupCode) : 900;
                PickupCodeTextBox.Text = (maxCode + 1).ToString();
            }
            catch
            {
                PickupCodeTextBox.Text = "101";
            }
        }

        private void LoadOrderData(int orderId)
        {
            try
            {
                using AppDbContext db = new AppDbContext();
                var order = db.Orders
                    .Include(o => o.OrderItems)
                    .FirstOrDefault(o => o.Id == orderId);

                if (order == null)
                {
                    MessageBox.Show("Заказ не найден.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    Close();
                    return;
                }

                StatusComboBox.SelectedValue = order.StatusId;
                PickupPointComboBox.SelectedValue = order.PickupPointId;
                ClientComboBox.SelectedValue = order.ClientId;
                PickupCodeTextBox.Text = order.PickupCode.ToString();

                OrderDatePicker.SelectedDate = order.OrderDate.ToDateTime(TimeOnly.MinValue);
                DeliveryDatePicker.SelectedDate = order.DeliveryDate.ToDateTime(TimeOnly.MinValue);

                var firstItem = order.OrderItems.FirstOrDefault();
                if (firstItem != null)
                {
                    ProductComboBox.SelectedValue = firstItem.ProductId;
                    QuantityTextBox.Text = firstItem.Quantity.ToString();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки заказа.\n\nПричина: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (ProductComboBox.SelectedValue == null ||
                StatusComboBox.SelectedValue == null ||
                PickupPointComboBox.SelectedValue == null ||
                ClientComboBox.SelectedValue == null ||
                OrderDatePicker.SelectedDate == null ||
                DeliveryDatePicker.SelectedDate == null)
            {
                MessageBox.Show(
                    "Не заполнены обязательные поля.\n\nПричина: не выбран товар, статус, пункт выдачи, клиент или дата.\nРекомендация: заполните все поля, отмеченные звёздочкой (*).",
                    "Ошибка ввода данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            if (!int.TryParse(QuantityTextBox.Text.Trim(), out int quantity) || quantity <= 0)
            {
                MessageBox.Show(
                    "Некорректное количество товара.\n\nПричина: количество в заказе должно быть больше нуля.\nРекомендация: введите целое число от 1 и выше.",
                    "Ошибка ввода данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            if (!int.TryParse(PickupCodeTextBox.Text.Trim(), out int pickupCode) || pickupCode <= 0)
            {
                MessageBox.Show(
                    "Некорректный код получения.\n\nПричина: код получения должен быть положительным целым числом.\nРекомендация: введите числовой код (например, 915).",
                    "Ошибка ввода данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            if (DeliveryDatePicker.SelectedDate.Value < OrderDatePicker.SelectedDate.Value)
            {
                MessageBox.Show(
                    "Некорректная дата выдачи.\n\nПричина: дата выдачи не может быть раньше даты оформления заказа.\nРекомендация: выберите корректную дату выдачи.",
                    "Ошибка ввода данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            try
            {
                using AppDbContext db = new AppDbContext();
                Order order;

                if (_editingOrderId.HasValue)
                {
                    order = db.Orders
                        .Include(o => o.OrderItems)
                        .First(o => o.Id == _editingOrderId.Value);
                }
                else
                {
                    order = new Order();
                    db.Orders.Add(order);
                }

                order.StatusId = (int)StatusComboBox.SelectedValue;
                order.PickupPointId = (int)PickupPointComboBox.SelectedValue;
                order.ClientId = (int)ClientComboBox.SelectedValue;
                order.PickupCode = pickupCode;
                order.OrderDate = DateOnly.FromDateTime(OrderDatePicker.SelectedDate.Value);
                order.DeliveryDate = DateOnly.FromDateTime(DeliveryDatePicker.SelectedDate.Value);

                int selectedProductId = (int)ProductComboBox.SelectedValue;
                var existingItem = order.OrderItems.FirstOrDefault();
                if (existingItem != null)
                {
                    existingItem.ProductId = selectedProductId;
                    existingItem.Quantity = quantity;
                }
                else
                {
                    order.OrderItems.Add(new OrderItem
                    {
                        ProductId = selectedProductId,
                        Quantity = quantity
                    });
                }

                db.SaveChanges();
                IsSaved = true;
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Ошибка сохранения заказа.\n\nПричина: {ex.InnerException?.Message ?? ex.Message}\nРекомендация: проверьте корректность данных и соединение с PostgreSQL.",
                    "Ошибка сохранения данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
