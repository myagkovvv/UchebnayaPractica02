using BookStore.Helpers;
using BookStore.Model;
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
using Microsoft.EntityFrameworkCore;

namespace BookStore.Windows
{
    public partial class ProductsWindow : Window
    {
        private List<Product> _allProducts = new();
        private Product? _selectedProduct;
        private bool _isEditWindowOpen;


        public ProductsWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LogoImage.Source = ImageHelper.LoadResourceImage("icon.png");
            var icon = ImageHelper.LoadResourceImage("icon.ico");
            if (icon != null)
            {
                Icon = icon;
            }

            UserFullNameTextBlock.Text = SessionContext.DisplayUserName;
            UserRoleTextBlock.Text = $"Роль: {SessionContext.DisplayRoleName}";

            ApplyRolePermissions();
            LoadProductsFromDatabase();
        }

        private void ApplyRolePermissions()
        {
            FilterPanelBorder.Visibility = SessionContext.CanSearchSortFilterProducts
                ? Visibility.Visible
                : Visibility.Collapsed;

            OrdersButton.Visibility = SessionContext.CanViewOrders
                ? Visibility.Visible
                : Visibility.Collapsed;

            Visibility adminVisibility = SessionContext.CanManageProducts
                ? Visibility.Visible
                : Visibility.Collapsed;

            AddProductButton.Visibility = adminVisibility;
            EditProductButton.Visibility = adminVisibility;
            DeleteProductButton.Visibility = adminVisibility;

            BottomActionsBorder.Visibility =
                (SessionContext.CanViewOrders || SessionContext.CanManageProducts)
                    ? Visibility.Visible
                    : Visibility.Collapsed;
        }

        public void LoadProductsFromDatabase()
        {
            try
            {
                using AppDbContext db = new AppDbContext();
                _allProducts = db.Products
                    .Include(p => p.Category)
                    .Include(p => p.Author)
                    .Include(p => p.Publisher)
                    .Include(p => p.Unit)
                    .OrderBy(p => p.Id)
                    .ToList();

                ApplyFiltersAndSort();
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Ошибка загрузки списка товаров из базы данных.\n\nПричина: {ex.Message}\nРекомендация: проверьте подключение к PostgreSQL.",
                    "Ошибка подключения к БД",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }

        private void ApplyFiltersAndSort()
        {
            if (ProductsListBox == null) return;

            IEnumerable<Product> query = _allProducts;

            if (SessionContext.CanSearchSortFilterProducts)
            {
                string search = SearchTextBox?.Text?.Trim().ToLower() ?? string.Empty;
                if (!string.IsNullOrEmpty(search))
                {
                    query = query.Where(p =>
                        p.Name.ToLower().Contains(search) ||
                        p.Article.ToLower().Contains(search) ||
                        p.Category.Name.ToLower().Contains(search) ||
                        p.Author.Name.ToLower().Contains(search) ||
                        p.Publisher.Name.ToLower().Contains(search) ||
                        (p.Description != null && p.Description.ToLower().Contains(search)));
                }

                int filterIndex = DiscountFilterComboBox?.SelectedIndex ?? 0;
                query = filterIndex switch
                {
                    1 => query.Where(p => p.Discount >= 0m && p.Discount <= 12.99m),
                    2 => query.Where(p => p.Discount >= 13m && p.Discount <= 16.99m),
                    3 => query.Where(p => p.Discount >= 17m),
                    _ => query
                };

                int sortIndex = SortComboBox?.SelectedIndex ?? 0;
                query = sortIndex switch
                {
                    1 => query.OrderBy(p => p.FinalPrice),
                    2 => query.OrderByDescending(p => p.FinalPrice),
                    3 => query.OrderBy(p => p.StockQuantity),
                    4 => query.OrderByDescending(p => p.StockQuantity),
                    _ => query.OrderBy(p => p.Id)
                };
            }

            var resultList = query.ToList();
            ProductsListBox.ItemsSource = resultList;

            if (RecordsCountTextBlock != null)
            {
                RecordsCountTextBlock.Text = $"Показано: {resultList.Count} из {_allProducts.Count}";
            }
        }

        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            ApplyFiltersAndSort();
        }

        private void SortComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyFiltersAndSort();
        }

        private void DiscountFilterComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ApplyFiltersAndSort();
        }

        private void ProductsListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            _selectedProduct = ProductsListBox.SelectedItem as Product;
        }

        private void LogoutButton_Click(object sender, RoutedEventArgs e)
        {
            SessionContext.Logout();
            LoginWindow loginWindow = new LoginWindow();
            loginWindow.Show();
            Close();
        }

        private void OrdersButton_Click(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanViewOrders) return;

            OrdersWindow ordersWindow = new OrdersWindow();
            ordersWindow.ShowDialog();
        }


        private void AddProductButton_Click(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageProducts || _isEditWindowOpen) return;

            _isEditWindowOpen = true;
            try
            {
                ProductEditWindow editWindow = new ProductEditWindow();
                editWindow.ShowDialog();
                if (editWindow.IsSaved)
                {
                    LoadProductsFromDatabase();
                }
            }
            finally
            {
                _isEditWindowOpen = false;
            }
        }

        private void EditProductButton_Click(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageProducts || _isEditWindowOpen) return;

            if (_selectedProduct == null)
            {
                MessageBox.Show(
                    "Товар не выбран.\n\nПричина: не выбрана карточка товара в списке.\nРекомендация: нажмите на нужный товар в списке и повторите попытку.",
                    "Внимание",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information);
                return;
            }

            _isEditWindowOpen = true;
            try
            {
                ProductEditWindow editWindow = new ProductEditWindow(_selectedProduct.Id);
                editWindow.ShowDialog();
                if (editWindow.IsSaved)
                {
                    LoadProductsFromDatabase();
                }
            }
            finally
            {
                _isEditWindowOpen = false;
            }
        }

        private void DeleteProductButton_Click(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageProducts) return;

            if (_selectedProduct == null)
            {
                MessageBox.Show(
                    "Товар не выбран.\n\nПричина: не выбрана карточка товара для удаления.\nРекомендация: выделите товар в списке и нажмите «Удалить товар».",
                    "Внимание",
                    MessageBoxButton.OK,
                    MessageBoxImage.Information);
                return;
            }

            try
            {
                using AppDbContext db = new AppDbContext();
                bool isInOrder = db.OrderItems.Any(oi => oi.ProductId == _selectedProduct.Id);
                if (isInOrder)
                {
                    MessageBox.Show(
                        "Невозможно удалить товар, присутствующий в заказе.\n\nПричина: данный товар используется в оформленных заказах покупателей.\nРекомендация: удаление таких товаров запрещено правилами системы.",
                        "Ошибка удаления",
                        MessageBoxButton.OK,
                        MessageBoxImage.Error);
                    return;
                }

                var confirm = MessageBox.Show(
                    $"Вы действительно хотите удалить товар «{_selectedProduct.Name}» (артикул {_selectedProduct.Article})?",
                    "Подтверждение удаления",
                    MessageBoxButton.YesNo,
                    MessageBoxImage.Warning);

                if (confirm != MessageBoxResult.Yes) return;

                var productToDelete = db.Products.FirstOrDefault(p => p.Id == _selectedProduct.Id);
                if (productToDelete != null)
                {
                    string? photoToDelete = productToDelete.Photo;
                    int deletedId = productToDelete.Id;

                    db.Products.Remove(productToDelete);
                    db.SaveChanges();

                    ImageHelper.DeleteUnusedProductImage(photoToDelete, deletedId);
                    _selectedProduct = null;
                    LoadProductsFromDatabase();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Ошибка удаления товара.\n\nПричина: {ex.InnerException?.Message ?? ex.Message}\nРекомендация: проверьте, не связан ли товар с другими записями.",
                    "Ошибка удаления",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }
    }
}
