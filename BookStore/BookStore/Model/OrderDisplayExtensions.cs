using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookStore.Model
{
    public partial class Order
    {
        [NotMapped]
        public string FullPickupAddress
        {
            get
            {
                if (PickupPoint == null) return "Не указан";
                string city = PickupPoint.City?.Name ?? "";
                string street = PickupPoint.Street?.Name ?? "";
                string house = string.IsNullOrWhiteSpace(PickupPoint.HouseNumber)
                    ? ""
                    : $", д. {PickupPoint.HouseNumber}";
                return $"{PickupPoint.PostalCode}, {city}, {street}{house}";
            }
        }

        [NotMapped]
        public string ArticlesSummary
        {
            get
            {
                if (OrderItems == null || OrderItems.Count == 0)
                {
                    return "Нет позиций";
                }

                return string.Join(", ", OrderItems.Select(oi =>
                    $"{oi.Product?.Article ?? "—"} ({oi.Quantity} шт.)"));
            }
        }
    }

    public partial class PickupPoint
    {
        [NotMapped]
        public string DisplayAddress
        {
            get
            {
                string city = City?.Name ?? "";
                string street = Street?.Name ?? "";
                string house = string.IsNullOrWhiteSpace(HouseNumber)
                    ? ""
                    : $", д. {HouseNumber}";
                return $"{PostalCode}, {city}, {street}{house}";
            }
        }
    }

}
