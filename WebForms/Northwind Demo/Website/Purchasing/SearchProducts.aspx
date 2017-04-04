<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SearchProducts.aspx.cs" Inherits="Purchasing_SearchProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <h1 class="page-header">Search Products Page</h1>
    </div>
    
    <div class="row">
        <div class="col-md-4">
            <h3>Find by Category</h3>
        </div>
        <div class="col-md-4">
            <h3>Find by Supplier</h3>
        </div>
        <div class="col-md-4">
            <h3>Find by Product Name</h3>
            <asp:TextBox ID="PartialName" runat="server" CssClass="form-control" />
            <asp:LinkButton ID="LookupByName" runat="server"
                 OnClick="LookupByName_Click" CssClass="btn btn-default">Lookup Products</asp:LinkButton>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="SearchResultsGridView" runat="server"
                 AutoGenerateColumns="false"
                 CssClass="table table-hover table-condensed">
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
        </div>
    </div>
</asp:Content>

