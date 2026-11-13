using System;
using System.Collections.Generic;

namespace BookStore.Model;

public partial class PickupPoint
{
    public int Id { get; set; }

    public string PostalCode { get; set; } = null!;

    public int CityId { get; set; }

    public int StreetId { get; set; }

    public string? HouseNumber { get; set; }

    public virtual City City { get; set; } = null!;

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual Street Street { get; set; } = null!;
}
