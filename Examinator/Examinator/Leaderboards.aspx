<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="Leaderboards.aspx.cs" Inherits="Examinator.Leaderboards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Leaderboards</h1>
        <asp:GridView ID="gvLeaderBoards" CssClass="gvskin" runat="server"></asp:GridView>
</asp:Content>
