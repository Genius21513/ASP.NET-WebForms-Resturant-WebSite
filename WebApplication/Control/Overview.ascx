<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebApplication.Control.Overview" CodeBehind="Overview.ascx.cs" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register TagPrefix="WebApp" Namespace="WebApplication.Control" Assembly="WebApplication" %>
<div>
    <asp:Chart ID="RevenueVsCost" runat="server" DataSourceID="SqlDataSource1">        
        <Series>
            <asp:Series Name="Revenue" ChartArea="RevenueVsCost" XValueMember="At" YValueMembers="Value" YValuesPerPoint="6" BorderWidth="5"></asp:Series>
            <asp:Series ChartArea="RevenueVsCost" ChartType="Spline" Name="Cost" XValueMember="At" YValueMembers="Custo" YValuesPerPoint="6" BorderWidth="10" MarkerBorderWidth="10" MarkerSize="10">
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="RevenueVsCost"></asp:ChartArea>
        </ChartAreas>
        <Titles>
            <asp:Title Name="Revenue Vs Cost">
            </asp:Title>
        </Titles>
    </asp:Chart>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:default %>" SelectCommand="SELECT SUM(T.[In]) AS Value, MAX(FORMAT(T.[At], 'MMM')) AS At, SUM(T.[In]) - 10 AS Custo FROM [Transaction] T WITH (NOLOCK) GROUP BY FORMAT(T.[At], 'MMM')"></asp:SqlDataSource>
</div>