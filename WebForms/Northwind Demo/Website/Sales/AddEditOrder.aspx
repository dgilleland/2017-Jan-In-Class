<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddEditOrder.aspx.cs" Inherits="Sales_AddEditOrder" %>

<%@ Register TagPrefix="ajaxToolkit" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <h2>Orders</h2>
            <asp:DropDownList ID="OpenOrders" runat="server" AppendDataBoundItems="true" DataSourceID="OrdersDataSource" DataTextField="OrderNumber" DataValueField="OrderID">
                <asp:ListItem Value="-1">[Select an order]</asp:ListItem>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="OrdersDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="ListAllUnshippedOrders" TypeName="NorthwindSystem.BLL.CustomerOrdersController"></asp:ObjectDataSource>
            <asp:LinkButton ID="LookupOrder" runat="server">View Order</asp:LinkButton>
            <ajaxToolkit:ConfirmButtonExtender runat="server" ConfirmText="Are you sure you want to view the order?" BehaviorID="LookupOrder_ConfirmButtonExtender" TargetControlID="LookupOrder" ID="LookupOrder_ConfirmButtonExtender"></ajaxToolkit:ConfirmButtonExtender>
            <hr />
            <h3>AJAX Control Toolkits</h3>
            <p>
                <ajaxToolkit:Gravatar ID="Gravatar1" runat="server" Email="dgilleland@nait.ca" />
                When using the Calendar Extender along with a Validator control, the preferred format is <code>mm/dd/yyyy</code>.</p>
            <h3>Stored Procedure</h3>
            <pre><code>CREATE PROCEDURE [dbo].[Orders_List_NotShipped]
AS

SELECT
	[OrderID],
	[CustomerID],
	[EmployeeID],
	[OrderDate],
	[RequiredDate],
	[ShippedDate],
	[ShipVia],
	[Freight],
	[ShipName],
	[ShipAddress],
	[ShipCity],
	[ShipRegion],
	[ShipPostalCode],
	[ShipCountry]
FROM Orders
WHERE [ShippedDate] IS NULL
GO</code></pre>
        </div>
        <div class="col-md-6">
            <h2>Order Info</h2>
            <fieldset>
                <asp:Label ID="Label1" runat="server" AssociatedControlID="OrderID" Text="Order ID" />
                <asp:TextBox ID="OrderID" runat="server" Enabled="false" />

                <asp:Label ID="Label2" runat="server" AssociatedControlID="OrderDate" Text="Ordered On" />
                <asp:TextBox ID="OrderDate" runat="server" />
                <ajaxToolkit:CalendarExtender runat="server" BehaviorID="OrderDate_CalendarExtender" TargetControlID="OrderDate" ID="OrderDate_CalendarExtender"></ajaxToolkit:CalendarExtender>

                <asp:Label ID="Label3" runat="server" AssociatedControlID="RequiredDate" Text="Required By" />
                <asp:TextBox ID="RequiredDate" runat="server" />

                <asp:Label ID="Label4" runat="server" AssociatedControlID="ShippedDate" Text="Shipped On" />
                <asp:TextBox ID="ShippedDate" runat="server" />

                <asp:Label ID="Label5" runat="server" AssociatedControlID="Freight" Text="Freight Charge" />
                <asp:TextBox ID="Freight" runat="server" />

                <ajaxToolkit:MaskedEditExtender runat="server" CultureDatePlaceholder="" CultureTimePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureDateFormat="" CultureCurrencySymbolPlaceholder="" CultureAMPMPlaceholder="" Century="2000" BehaviorID="Freight_MaskedEditExtender" TargetControlID="Freight" ID="Freight_MaskedEditExtender" Mask="\$ 99,999.99" ClearMaskOnLostFocus="False"></ajaxToolkit:MaskedEditExtender>
            </fieldset>
        </div>
    </div>
    <script src="../Scripts/bootwrap-freecode.js"></script>
</asp:Content>

