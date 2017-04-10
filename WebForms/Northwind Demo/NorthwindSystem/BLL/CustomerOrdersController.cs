using NorthwindEntities;
using NorthwindSystem.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel; // DataObject & DataObjectMethod attributes
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NorthwindSystem.BLL
{
    [DataObject] // This class can be used to supply CRUD functionality
    public class CustomerOrdersController
    {
        // This method can be used to SELECT data 
        [DataObjectMethod(DataObjectMethodType.Select)]
        public List<Order> ListAllUnshippedOrders()
        {
            using (var context = new NorthwindContext())
            {
                var results = context.Database.SqlQuery<Order>("EXEC [dbo].[Orders_List_NotShipped]");
                return results.ToList();
            }
        }
    }
}
