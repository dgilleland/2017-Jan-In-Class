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
        if (!IsPostBack) // on the initial GET of the page
        {
            try
            {
                // We can populate some controls such as DropDownLists with data
                PopulateProductsDropDown();
                PopulateSupplierDropDown();
                PopulateCategoryDropDown();
            }
            catch (Exception ex)
            {
                MessageLabel.Text = ex.Message;
            }
        }
    }

    private void PopulateCategoryDropDown()
    {
        var controller = new InventoryPurchasingController();
        var data = controller.ListAllCategories();
        Category.DataSource = data;
        Category.DataTextField = "CategoryName";
        Category.DataValueField = "CategoryID";
        Category.DataBind();
        // Let's insert a couple of options at the top of the drop-down
        Category.Items.Insert(0, new ListItem("[select a category]"));
        Category.Items.Insert(1, new ListItem("[no category]", ""));
        // The second inserted item is to accommodate a NULL value for the Product.CategoryID
    }

    private void PopulateSupplierDropDown()
    {
        InventoryPurchasingController controller = new InventoryPurchasingController();
        List<Supplier> suppliers = controller.ListAllSupplier();
        Supplier.DataSource = suppliers;
        Supplier.DataTextField = "CompanyName";
        Supplier.DataValueField = "SupplierID";
        Supplier.DataBind();
        // Let's insert a couple of options at the top of the drop-down
        Supplier.Items.Insert(0, new ListItem("[select a supplier]"));
        Supplier.Items.Insert(1, new ListItem("[no supplier]", "")); // because Product.SupplierID is nullable
    }

    private void PopulateProductsDropDown()
    {
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

    protected void ShowProductDetails_Click(object sender, EventArgs e)
    {
        if (CurrentProducts.SelectedIndex == 0) // first item in the drop-down
        {
            MessageLabel.Text = "Please select product before clicking Show Product Details.";
        }
        else
        {
            int productId;
            if (int.TryParse(CurrentProducts.SelectedValue, out productId))
            {
                try
                {
                    // Instantiate my BLL class and call a method to get the specific product
                    var controller = new InventoryPurchasingController();
                    Product item = controller.LookupProduct(productId);

                    // "Unpack" the data into the form's controls
                    ProductID.Text = item.ProductID.ToString(); // ProductID is an int
                    ProductName.Text = item.ProductName;
                    // Select the supplier/category for the found product
                    Supplier.SelectedValue = item.SupplierID.ToString();
                    Category.SelectedValue = item.CategoryID.ToString();
                    // Other values that are displayed in text boxes
                    QtyPerUnit.Text = item.QuantityPerUnit;
                    UnitPrice.Text = item.UnitPrice.ToString();
                    InStock.Text = item.UnitsInStock.ToString();
                    OnOrder.Text = item.UnitsOnOrder.ToString();
                    ReorderLevel.Text = item.ReorderLevel.ToString();
                    // Set the checkbox for the found product's Discontinued flag
                    Discontinued.Checked = item.Discontinued;

                    // Update the message
                    MessageLabel.Text = "Product details found.";

                }
                catch (Exception ex)
                {
                    MessageLabel.Text = ex.Message;
                }
            }
        }
    }
}