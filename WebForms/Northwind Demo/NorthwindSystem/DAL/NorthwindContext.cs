using NorthwindEntities;
using System.Data.Entity;

namespace NorthwindSystem.DAL
{
    // Act like a "virtual representation" of my database & its tables
    internal class NorthwindContext : DbContext
    {
        // The name "NW" identifies which connection string settings to use in the web.config file.
        public NorthwindContext() : base("name=NW")
        {

        }

        // Properties that map Entitites to the DB tables
        public DbSet<Product> Products { get; set; }
        public DbSet<Supplier> Suppliers { get; set; }
        public DbSet<Category> Categories { get; set; }
    }
}
