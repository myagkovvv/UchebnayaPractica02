using System;
using System.Collections.Generic;

namespace BookStore.Model;

public partial class Product
{
    public int Id { get; set; }

    public string Article { get; set; } = null!;

    public string Name { get; set; } = null!;

    public int UnitId { get; set; }

    public decimal Price { get; set; }

    public int AuthorId { get; set; }

    public int PublisherId { get; set; }

    public int CategoryId { get; set; }

    public decimal Discount { get; set; }

    public int StockQuantity { get; set; }

    public string? Description { get; set; }

    public string? Photo { get; set; }

    public virtual Author Author { get; set; } = null!;

    public virtual Category Category { get; set; } = null!;

    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public virtual Publisher Publisher { get; set; } = null!;

    public virtual Unit Unit { get; set; } = null!;
}
