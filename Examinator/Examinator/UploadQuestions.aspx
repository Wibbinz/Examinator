<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="UploadQuestions.aspx.cs" Inherits="Examinator.UploadQuestions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="menucontainer">
        <div id="instructions">
            <h2>Instructions for uploading Questions and Answers to the Examinator website</h2>
            <p>There are ten (10) columns in this template.  Complete the column data as described in the template. 
                If the Category in UploadCatName exists, it will be used; if it does not exist, a new Category will be created.
                Images for questions and/or answers are not supported at this time.
                Data that exceeds the column width specified in the Width column will be truncated.
                Once the template has been completed, save as a .CSV file, giving it a unique filename.
                The header row of the .CSV file may optionally be removed.
            </p>
        </div>
        <a class="templateDownloadLink" href="UploadTemplates/ExaminatorUploadTemplate.xlsx">Download Template</a><br /><br />
        <div class="fileUpload">
            <asp:FileUpload ID="fuQuestions" runat="server" /><br /><br />
            <asp:Button ID="btnUpload" runat="server" CssClass="button" Text="Upload Selected File" OnClick="btnUpload_Click" />       
        </div>             
        <asp:GridView ID="GridView1" CssClass="gvskin" runat="server"></asp:GridView>
    </div>    
</asp:Content>
