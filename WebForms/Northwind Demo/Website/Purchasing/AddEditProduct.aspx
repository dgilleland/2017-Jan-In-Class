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
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 text-center"></div>
            </div>
        </div>
    </div>
</asp:Content>

