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

    protected void ShowProductDetails_Click(object sender, EventArgs e)
    {
        if(CurrentProducts.SelectedIndex == 0) // first item in the drop-down
        {
            MessageLabel.Text = "Please select product before clicking Show Product Details.";
        }
        else
        {
            int productId;
            if(int.TryParse(CurrentProducts.SelectedValue, out productId))
            {
                // Instantiate my BLL class and call a method to get the specific product
                var controller = new InventoryPurchasingController();
                Product item = controller.LookupProduct(productId);

                // "Unpack" the data into the form's controls
                ProductID.Text = item.ProductID.ToString(); // ProductID is an int
                ProductName.Text = item.ProductName;

                // Update the message
                MessageLabel.Text = "Product details found.";
            }
        }
    }
}