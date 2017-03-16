<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddEditProduct.aspx.cs" Inherits="Purchasing_AddEditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <h1 class="page-header">Add/Edit Products</h1>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-inline">
                        <div class="form-group">
                            <asp:Label ID="Label1" runat="server"
                                 CssClass="control-label"
                                 Text="Products"
                                 AssociatedControlID="CurrentProducts"
                                 />
                            <asp:DropDownList ID="CurrentProducts"
                                 runat="server"
                                 CssClass="form-control">
                            </asp:DropDownList>
                            <asp:LinkButton ID="ShowProductDetails" runat="server"
                                 CssClass="btn btn-primary"
                                 OnClick="ShowProductDetails_Click">
                                Show Product Details
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 text-center">
                    <asp:Label ID="MessageLabel" runat="server" />
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <fieldset>
                <legend>Product Details</legend>

                <asp:Label ID="Label3" runat="server" Text="Product ID" AssociatedControlID="ProductID" />
                <asp:TextBox ID="ProductID" runat="server" Enabled="false" />

                <asp:Label ID="Label2" runat="server" Text="Product Name" AssociatedControlID="ProductName" />
                <asp:TextBox ID="ProductName" runat="server" />
            </fieldset>
        </div>
    </div>
</asp:Content>

