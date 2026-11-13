using System;
using System.Collections.Generic;

namespace BookStore.Model;

public partial class Street
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<PickupPoint> PickupPoints { get; set; } = new List<PickupPoint>();
}
