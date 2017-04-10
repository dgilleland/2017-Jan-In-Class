using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NorthwindEntities
{
    [Table("Orders", Schema = "dbo")]
    public class Order
    {
        [Key]
        public int OrderID { get; set; }
        public DateTime? OrderDate { get; set; }
        public DateTime? RequiredDate { get; set; }
        public DateTime? ShippedDate { get; set; }
        public decimal? Freight { get; set; }

        [NotMapped]
        public string OrderNumber
        {
            get
            {
                if (OrderDate.HasValue)
                    return $"{OrderID} - {OrderDate.Value.ToShortDateString()}";
                else
                    return OrderID.ToString();
            }
        }
    }
}
