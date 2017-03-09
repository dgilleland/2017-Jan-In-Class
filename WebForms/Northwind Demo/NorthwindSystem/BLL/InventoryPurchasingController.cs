using NorthwindEntities;
using NorthwindSystem.DAL;
using System;
using System.Collections.Generic;
using System.Linq;

namespace NorthwindSystem.BLL
{
    // This class is the public access into our system/application
    // that will be used by the website to provide CRUD maintenance
    // for inventory related data.
    public class InventoryPurchasingController
    {
        #region Product CRUD
        public List<Product> ListAllProducts()
        {
            using (var context = new NorthwindContext())
            {
                return context.Products.ToList();
            }
        }

        public Product LookupProduct(int productId)
        {
            using (var context = new NorthwindContext())
            {
                return context.Products.Find(productId);
            }
        }
        #endregion

        #region Category CRUD
        public List<Category> ListAllCategories()
        {
            // This "using" statement is different than the "using" at the top of this file.
            // This "using" statement is to ensure that the connection to the database is properly closed after we are done.
            // The variable context is a NorthwindContext object
            // The NorthwindContext class represents a "virtual" database
            using (var context = new NorthwindContext())
            {
                return context.Categories.ToList();
            }
        }

        public Category LookupCategory(int categoryId)
        {
            using (var context = new NorthwindContext())
            {
                return context.Categories.Find(categoryId);
            }
        }
        #endregion

        #region Supplier CRUD
        public List<Supplier> ListAllSupplier()
        {
            using (var context = new NorthwindContext())
            {
                return context.Suppliers.ToList();
            }
        }

        public Supplier LookupSupplier(int supplierId)
        {
            using (var context = new NorthwindContext())
            {
                return context.Suppliers.Find(supplierId);
            }
        }
        #endregion
    }
}
