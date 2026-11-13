using System;
using System.Globalization;
using System.Linq;
using System.Windows;
using BookStore.Helpers;
using BookStore.Model;
using Microsoft.Win32;

namespace BookStore.Windows
{
    public partial class ProductEditWindow : Window
    {
        private readonly int? _editingProductId;
        private string? _currentPhotoFileName;
        private string? _selectedNewImageSourcePath;
        private bool _imageCleared;

        public bool IsSaved { get; private set; }

        public ProductEditWindow(int? productId = null)
        {
            InitializeComponent();
            _editingProductId = productId;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (!SessionContext.CanManageProducts)
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

            LoadComboBoxes();

            if (_editingProductId.HasValue)
            {
                Title = "ООО «ЧитайГород» — Редактирование товара";
                WindowHeaderTextBlock.Text = "Редактирование товара";
                IdPanel.Visibility = Visibility.Visible;
                LoadProductData(_editingProductId.Value);
            }
            else
            {
                Title = "ООО «ЧитайГород» — Добавление товара";
                WindowHeaderTextBlock.Text = "Добавление товара";
                IdPanel.Visibility = Visibility.Collapsed;
                ProductPreviewImage.Source = ImageHelper.LoadProductImage(null);
            }
        }

        private void LoadComboBoxes()
        {
            try
            {
                using AppDbContext db = new AppDbContext();
                CategoryComboBox.ItemsSource = db.Categories.OrderBy(c => c.Name).ToList();
                PublisherComboBox.ItemsSource = db.Publishers.OrderBy(p => p.Name).ToList();
                AuthorComboBox.ItemsSource = db.Authors.OrderBy(a => a.Name).ToList();
                UnitComboBox.ItemsSource = db.Units.OrderBy(u => u.Id).ToList();

                if (UnitComboBox.Items.Count > 0)
                {
                    UnitComboBox.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                    $"Ошибка загрузки справочников.\n\nПричина: {ex.Message}\nРекомендация: проверьте подключение к базе данных.",
                    "Ошибка подключения к БД",
                    MessageBoxButton.OK,
                    MessageBoxImage.Error);
            }
        }

        private void LoadProductData(int productId)
        {
            try
            {
                using AppDbContext db = new AppDbContext();
                var product = db.Products.FirstOrDefault(p => p.Id == productId);
                if (product == null)
                {
                    MessageBox.Show("Товар не найден в базе данных.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    Close();
                    return;
                }

                IdTextBox.Text = product.Id.ToString();
                ArticleTextBox.Text = product.Article;
                NameTextBox.Text = product.Name;
                CategoryComboBox.SelectedValue = product.CategoryId;
                PublisherComboBox.SelectedValue = product.PublisherId;
                AuthorComboBox.SelectedValue = product.AuthorId;
                UnitComboBox.SelectedValue = product.UnitId;
                PriceTextBox.Text = product.Price.ToString("0.00", CultureInfo.InvariantCulture);
                StockTextBox.Text = product.StockQuantity.ToString();
                DiscountTextBox.Text = product.Discount.ToString("0.##", CultureInfo.InvariantCulture);
                DescriptionTextBox.Text = product.Description;

                _currentPhotoFileName = product.Photo;
                ProductPreviewImage.Source = ImageHelper.LoadProductImage(_currentPhotoFileName);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки данных товара.\n\nПричина: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void SelectImageButton_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dialog = new OpenFileDialog
            {
                Title = "Выберите изображение товара",
                Filter = "Изображения (*.png;*.jpg;*.jpeg)|*.png;*.jpg;*.jpeg"
            };

            if (dialog.ShowDialog() == true)
            {
                try
                {
                    _selectedNewImageSourcePath = dialog.FileName;
                    _imageCleared = false;

                    var preview = new System.Windows.Media.Imaging.BitmapImage();
                    preview.BeginInit();
                    preview.UriSource = new Uri(_selectedNewImageSourcePath);
                    preview.CacheOption = System.Windows.Media.Imaging.BitmapCacheOption.OnLoad;
                    preview.EndInit();
                    ProductPreviewImage.Source = preview;
                }
                catch (Exception ex)
                {
                    MessageBox.Show(
                        $"Ошибка загрузки изображения.\n\nПричина: {ex.Message}\nРекомендация: выберите корректный файл формата JPG или PNG.",
                        "Ошибка загрузки изображения",
                        MessageBoxButton.OK,
                        MessageBoxImage.Error);
                }
            }
        }

        private void ClearImageButton_Click(object sender, RoutedEventArgs e)
        {
            _selectedNewImageSourcePath = null;
            _imageCleared = true;
            ProductPreviewImage.Source = ImageHelper.LoadProductImage(null);
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            string article = ArticleTextBox.Text.Trim();
            string name = NameTextBox.Text.Trim();

            if (string.IsNullOrWhiteSpace(article) ||
                string.IsNullOrWhiteSpace(name) ||
                CategoryComboBox.SelectedValue == null ||
                PublisherComboBox.SelectedValue == null ||
                AuthorComboBox.SelectedValue == null ||
                UnitComboBox.SelectedValue == null)
            {
                MessageBox.Show(
                    "Не заполнены обязательные поля.\n\nПричина: артикул, наименование, категория, производитель, поставщик или единица измерения не указаны.\nРекомендация: заполните все поля, отмеченные звёздочкой (*).",
                    "Ошибка ввода данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            string normalizedPrice = PriceTextBox.Text.Trim().Replace(',', '.');
            if (!decimal.TryParse(normalizedPrice, NumberStyles.Any, CultureInfo.InvariantCulture, out decimal price) || price < 0)
            {
                MessageBox.Show(
                    "Некорректная цена.\n\nПричина: цена должна быть числом и не может быть отрицательной.\nРекомендация: введите неотрицательное число (например, 599.90).",
                    "Некорректная цена",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            if (!int.TryParse(StockTextBox.Text.Trim(), out int stock) || stock < 0)
            {
                MessageBox.Show(
                    "Отрицательное или некорректное количество.\n\nПричина: остаток на складе должен быть целым неотрицательным числом.\nРекомендация: введите целое число от 0 и выше.",
                    "Некорректное количество",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            string normalizedDiscount = DiscountTextBox.Text.Trim().Replace(',', '.');
            if (!decimal.TryParse(normalizedDiscount, NumberStyles.Any, CultureInfo.InvariantCulture, out decimal discount) || discount < 0 || discount > 100)
            {
                MessageBox.Show(
                    "Некорректная скидка.\n\nПричина: размер скидки должен быть в диапазоне от 0 до 100%.\nРекомендация: укажите значение от 0 до 100.",
                    "Ошибка ввода данных",
                    MessageBoxButton.OK,
                    MessageBoxImage.Warning);
                return;
            }

            try
            {
                using AppDbContext db = new AppDbContext();

                bool articleExists = db.Products.Any(p =>
                    p.Article == article && (!_editingProductId.HasValue || p.Id != _editingProductId.Value));

                if (articleExists)
                {
                    MessageBox.Show(
                        "Товар с таким артикулом уже существует.\n\nПричина: поле «Артикул» должно быть уникальным.\nРекомендация: укажите другой артикул.",
                        "Ошибка сохранения данных",
                        MessageBoxButton.OK,
                        MessageBoxImage.Warning);
                    return;
                }

                Product product;
                string? oldPhotoToDelete = null;

                if (_editingProductId.HasValue)
                {
                    product = db.Products.First(p => p.Id == _editingProductId.Value);
                }
                else
                {
                    product = new Product();
                    db.Products.Add(product);
                }

                product.Article = article;
                product.Name = name;
                product.CategoryId = (int)CategoryComboBox.SelectedValue;
                product.PublisherId = (int)PublisherComboBox.SelectedValue;
                product.AuthorId = (int)AuthorComboBox.SelectedValue;
                product.UnitId = (int)UnitComboBox.SelectedValue;
                product.Price = Math.Round(price, 2);
                product.StockQuantity = stock;
                product.Discount = Math.Round(discount, 2);
                product.Description = string.IsNullOrWhiteSpace(DescriptionTextBox.Text) ? null : DescriptionTextBox.Text.Trim();
                if (!string.IsNullOrEmpty(_selectedNewImageSourcePath))
                {
                    oldPhotoToDelete = product.Photo;
                    product.Photo = ImageHelper.SaveResizedProductImage(_selectedNewImageSourcePath);
                }
                else if (_imageCleared)
                {
                    oldPhotoToDelete = product.Photo;
                    product.Photo = null;
                }
                db.SaveChanges();
                if (!string.IsNullOrEmpty(oldPhotoToDelete))
                {
                    ImageHelper.DeleteUnusedProductImage(oldPhotoToDelete, product.Id);
                }
                IsSaved = true;
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(
                $"Ошибка сохранения данных товара.\n\nПричина: {ex.InnerException?.Message ?? ex.Message}\nРекомендация: проверьте корректность заполнения полей и связь с базой данных.",
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
