using System;
using System.Collections.Generic;

namespace BookStore.Model;

public partial class Order
{
    public int Id { get; set; }

    public DateOnly OrderDate { get; set; }

    public DateOnly DeliveryDate { get; set; }

    public int ClientId { get; set; }

    public int PickupPointId { get; set; }

    public int PickupCode { get; set; }

    public int StatusId { get; set; }

    public virtual User Client { get; set; } = null!;

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual PickupPoint PickupPoint { get; set; } = null!;

    public virtual OrderStatus Status { get; set; } = null!;
}
