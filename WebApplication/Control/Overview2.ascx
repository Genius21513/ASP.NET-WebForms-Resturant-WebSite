<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebApplication.Control.Overview2" CodeBehind="Overview2.ascx.cs" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register TagPrefix="WebApp" Namespace="WebApplication.Control" Assembly="WebApplication" %>
<div>
    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1">
        <Series>
            <asp:Series ChartType="Candlestick" Name="Series1" XValueMember="At" YValueMembers="Open, High, Low, Close" YValuesPerPoint="4">
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:default %>" SelectCommand="SELECT [In] [Open], 0 as [High], 0 as [Low], [In] - [Out] [Close], [At] FROM [Transaction] WITH (NOLOCK)"></asp:SqlDataSource>
</div>