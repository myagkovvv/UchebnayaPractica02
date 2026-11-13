using System;
using System.IO;
using System.Linq;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using BookStore.Model;

namespace BookStore.Helpers
{
    public static class ImageHelper
    {
        public static readonly string ImagesFolderPath =
            Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images");

        public static ImageSource? LoadProductImage(string? photoFileName)
        {
            try
            {
                if (!string.IsNullOrWhiteSpace(photoFileName))
                {
                    string fullPath = Path.Combine(ImagesFolderPath, photoFileName);
                    if (File.Exists(fullPath))
                    {
                        return LoadBitmapFromFile(fullPath);
                    }
                }

                string fallbackDiskPath = Path.Combine(ImagesFolderPath, "picture.png");
                if (File.Exists(fallbackDiskPath))
                {
                    return LoadBitmapFromFile(fallbackDiskPath);
                }

                var resourceUri = new Uri("pack://application:,,,/Resources/picture.png", UriKind.Absolute);
                var bitmap = new BitmapImage();
                bitmap.BeginInit();
                bitmap.UriSource = resourceUri;
                bitmap.CacheOption = BitmapCacheOption.OnLoad;
                bitmap.EndInit();
                bitmap.Freeze();
                return bitmap;
            }
            catch
            {
                return null;
            }
        }

        public static ImageSource? LoadResourceImage(string fileName)
        {
            try
            {
                var uri = new Uri($"pack://application:,,,/Resources/{fileName}", UriKind.Absolute);
                var bitmap = new BitmapImage();
                bitmap.BeginInit();
                bitmap.UriSource = uri;
                bitmap.CacheOption = BitmapCacheOption.OnLoad;
                bitmap.EndInit();
                bitmap.Freeze();
                return bitmap;
            }
            catch
            {
                return null;
            }
        }

        public static string SaveResizedProductImage(string sourceFilePath)
        {
            Directory.CreateDirectory(ImagesFolderPath);

            var sourceBitmap = LoadBitmapFromFile(sourceFilePath);

            double scaleX = 300.0 / sourceBitmap.PixelWidth;
            double scaleY = 200.0 / sourceBitmap.PixelHeight;
            double scale = Math.Min(1.0, Math.Min(scaleX, scaleY));

            BitmapSource finalBitmap = sourceBitmap;
            if (scale < 1.0)
            {
                var transformed = new TransformedBitmap(sourceBitmap, new ScaleTransform(scale, scale));
                transformed.Freeze();
                finalBitmap = transformed;
            }

            string newFileName = $"{Guid.NewGuid():N}.jpg";
            string destinationPath = Path.Combine(ImagesFolderPath, newFileName);

            var encoder = new JpegBitmapEncoder { QualityLevel = 90 };
            encoder.Frames.Add(BitmapFrame.Create(finalBitmap));

            using (var fileStream = new FileStream(destinationPath, FileMode.Create, FileAccess.Write))
            {
                encoder.Save(fileStream);
            }

            return newFileName;
        }

        public static void DeleteUnusedProductImage(string? oldFileName, int currentProductId)
        {
            if (string.IsNullOrWhiteSpace(oldFileName) || oldFileName == "picture.png")
            {
                return;
            }

            try
            {
                using AppDbContext db = new AppDbContext();
                bool isUsedElsewhere = db.Products.Any(p => p.Id != currentProductId && p.Photo == oldFileName);
                if (isUsedElsewhere)
                {
                    return;
                }

                string fullPath = Path.Combine(ImagesFolderPath, oldFileName);
                if (File.Exists(fullPath))
                {
                    File.Delete(fullPath);
                }
            }
            catch
            {
                // Игнорируем ошибку блокировки файла ОС, чтобы не прерывать работу пользователя
            }
        }

        private static BitmapImage LoadBitmapFromFile(string fullPath)
        {
            var bitmap = new BitmapImage();
            bitmap.BeginInit();
            bitmap.UriSource = new Uri(fullPath, UriKind.Absolute);
            bitmap.CacheOption = BitmapCacheOption.OnLoad;
            bitmap.EndInit();
            bitmap.Freeze();
            return bitmap;
        }
    }
}
