<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="UploadQuestions.aspx.cs" Inherits="Examinator.UploadQuestions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FileUpload ID="fuQuestions" runat="server" />
    <asp:Button ID="btnUpload" runat="server" CssClass="button" Text="Upload Selected File" OnClick="btnUpload_Click" />
    <asp:Label ID="lblStatus" class="lblMessage" runat="server" Visible="false" Text="Label"></asp:Label>
    <asp:GridView ID="GridView1" runat="server"></asp:GridView>
</asp:Content>
