using BookStore.Helpers;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;


namespace BookStore.Model
{
    public partial class Product
    {
        [NotMapped]
        public bool HasDiscount => Discount > 0;

        [NotMapped]
        public bool IsOutOfStock => StockQuantity <= 0;

        [NotMapped]
        public decimal FinalPrice =>
            HasDiscount ? Price * (100m - Discount) / 100m : Price;

        [NotMapped]
        public Visibility DiscountPriceVisibility =>
            HasDiscount ? Visibility.Visible : Visibility.Collapsed;

        [NotMapped]
        public TextDecorationCollection? OldPriceDecorations =>
            HasDiscount ? TextDecorations.Strikethrough : null;

        [NotMapped]
        public Brush OldPriceForeground =>
            HasDiscount ? Brushes.Red : Brushes.Black;

        [NotMapped]
        public Brush CardBackground
        {
            get
            {
                if (IsOutOfStock)
                {
                    return new SolidColorBrush((Color)ColorConverter.ConvertFromString("#E0E0E0"));
                }

                if (Discount > 25m)
                {
                    return new SolidColorBrush((Color)ColorConverter.ConvertFromString("#23E1EF"));
                }

                return new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FFFFFF"));
            }
        }

        [NotMapped]
        public ImageSource? ProductImage => ImageHelper.LoadProductImage(Photo);
    }
}
