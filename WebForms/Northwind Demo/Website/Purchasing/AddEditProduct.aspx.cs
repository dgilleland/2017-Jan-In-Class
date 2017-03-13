using NorthwindEntities;    // for the appropriate Entity classes
using NorthwindSystem.BLL;  // for the InventoryPurchasingController
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Purchasing_AddEditProduct : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack) // on the initial GET of the page
        {
            // We can populate some controls such as DropDownLists with data
            // Populate CurrentProducts with all the products in the database
            InventoryPurchasingController controller = new InventoryPurchasingController();
            // controller is a NorthwindController object
            List<Product> products = controller.ListAllProducts();
            // products is a List<Product> object

            CurrentProducts.DataSource = products;
            // CurrentProducts is a DropDownList

            CurrentProducts.DataTextField = "ProductName";
            // The property of the Product class to display
            CurrentProducts.DataValueField = "ProductID";
            // The property of the Product class to use as the value

            CurrentProducts.DataBind(); // Populate the DropDownList
            CurrentProducts.Items.Insert(0, "[select a product]");
        }
    }
}