<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SearchProductAlt.aspx.cs" Inherits="Purchasing_SearchProductAlt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <h1 class="page-header">Search Products Page</h1>
    </div>
    
    <div class="row">
        <div class="col-md-4">
            <h3>Find by Category</h3>
            <asp:DropDownList ID="CategoryDropDown" runat="server"
                AppendDataBoundItems="true" DataSourceID="CategoryDataSource" DataTextField="CategoryName" DataValueField="CategoryID">
                <asp:ListItem Value="0">[Select a category]</asp:ListItem>
            </asp:DropDownList>
            <asp:LinkButton ID="LookupByCategory" runat="server"
                 CssClass="btn btn-default">Lookup Products</asp:LinkButton>
            <asp:ObjectDataSource runat="server" ID="CategoryDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListAllCategories" TypeName="NorthwindSystem.BLL.InventoryPurchasingController"></asp:ObjectDataSource>
        </div>
        <div class="col-md-4">
            <h3>Find by Supplier</h3>
        </div>
        <div class="col-md-4">
            <h3>Find by Product Name</h3>
            <asp:TextBox ID="PartialName" runat="server" CssClass="form-control" />
            <asp:LinkButton ID="LookupByName" runat="server"
                 CssClass="btn btn-default">Lookup Products</asp:LinkButton>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <!-- GridView gets its data from the ProductsDataSource control -->
            <asp:GridView ID="SearchResultsGridView" runat="server"
                 AutoGenerateColumns="false" DataSourceID="ProductsDataSource"
                 CssClass="table table-hover table-condensed">
                <EmptyDataTemplate>No products for this category</EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="ProductName"
                         HeaderText="Product Name" />
                    <asp:BoundField DataField="QuantityPerUnit"
                         HeaderText="Qty/Unit" />
                    <asp:BoundField DataField="UnitPrice"
                         DataFormatString="{0:c}"
                         HeaderText="Price" />
                    <asp:BoundField DataField="UnitsInStock"
                         HeaderText="In Stock" />
                     <asp:BoundField DataField="UnitsOnOrder"
                         HeaderText="On Order" />
                    <asp:BoundField DataField="ReorderLevel" 
                        HeaderText="Reorder Level" />
                    <asp:CheckBoxField DataField="Discontinued"
                        HeaderText="OLD" />
                </Columns>
            </asp:GridView>
            <!-- ObjectDataSource controls are used to "talk" with BLL class -->
            <asp:ObjectDataSource ID="ProductsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetProductsByCategory" TypeName="NorthwindSystem.BLL.InventoryPurchasingController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="CategoryDropDown" PropertyName="SelectedValue" Name="searchId" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
    </div>
</asp:Content>

