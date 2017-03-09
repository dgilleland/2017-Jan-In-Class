using System.ComponentModel.DataAnnotations;

namespace NorthwindEntities
{
    // It's a "best practice" to name your classes in the singular form
    public class Category
    {
        // A property for each column in the DB table
        [Key] // "Annotation" - Primary Key
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public string Description { get; set; }
        public byte[] Picture { get; set; }
        public string PictureMimeType { get; set; }
    }
}
