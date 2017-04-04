using NorthwindEntities;
using NorthwindSystem.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Purchasing_SearchProducts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LookupByName_Click(object sender, EventArgs e)
    {
        // TODO: Place inside a Try/Catch
        var controller = new InventoryPurchasingController();
        string name = PartialName.Text;
        List<Product> data = controller.GetProductsByPartialName(name);

        // Hook up the data to the GridView
        SearchResultsGridView.DataSource = data;
        SearchResultsGridView.DataBind();
    }
}