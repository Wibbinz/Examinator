<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="Editor.aspx.cs" Inherits="Examinator.Editor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:DropDownList ID="ddCategories" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddCategories_SelectedIndexChanged"></asp:DropDownList>
    <asp:GridView ID="gvEditor" runat="server" CssClass="gvskin" AutoGenerateColumns="False">
        <Columns>          
            <asp:CheckBoxField DataField="QuestionApprovalBit" HeaderText="Approved" />
            <asp:CheckBoxField DataField="QuestionBit" HeaderText="Active" />
            <asp:BoundField DataField="CatName" HeaderText="Category" />
            <asp:BoundField DataField="CatDesc" HeaderText="Category Description" />
            <asp:BoundField DataField="QuestionTxt" HeaderText="Question Text" />            
            <asp:BoundField DataField="AnswerCorrect" HeaderText="Correct Answer" />
            <asp:BoundField DataField="Answer1" HeaderText="Answer 1" />
            <asp:BoundField DataField="Answer2" HeaderText="Answer 2" />
            <asp:BoundField DataField="Answer3" HeaderText="Answer 3" />
            <asp:BoundField DataField="Answer4" HeaderText="Answer 4" />
            <asp:BoundField DataField="Answer5" HeaderText="Answer 5" />
            <asp:BoundField DataField="ExplnText" HeaderText="Explanation" />  
        </Columns>
    </asp:GridView>      
    
    <script>
        $(document).ready(function () {

        });
    </script>
</asp:Content>
