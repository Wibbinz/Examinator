<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="Editor.aspx.cs" Inherits="Examinator.Editor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:DropDownList ID="ddCategories" CssClass="dropdown" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddCategories_SelectedIndexChanged"></asp:DropDownList><br />
    <div id="gvDiv">
    <asp:GridView ID="gvEditor" runat="server" DataKeyNames="QuestionID,CategoryID" CssClass="gvskin" Width="95%" AutoGenerateColumns="False" AllowPaging="True" PageSize="4" OnPageIndexChanging="gvEditor_PageIndexChanging" OnRowCancelingEdit="gvEditor_RowCancelingEdit" OnRowEditing="gvEditor_RowEditing" OnRowUpdating="gvEditor_RowUpdating">
        <Columns>          
            <asp:CommandField ShowEditButton="True" />
            <asp:TemplateField HeaderText="Approved">
                <EditItemTemplate>
                    <asp:CheckBox ID="cbQuestionApproval" runat="server" Checked='<%# Bind("QuestionApprovalBit") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("QuestionApprovalBit") %>' Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Active">
                <EditItemTemplate>
                    <asp:CheckBox ID="cbQuestionBit" runat="server" Checked='<%# Bind("QuestionBit") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("QuestionBit") %>' Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="QuestionID" HeaderText="Question ID" ReadOnly="True" />
            <asp:TemplateField HeaderText="Category">
                <EditItemTemplate>
                    <asp:TextBox ID="tbCatName" Font-Size="X-Small" runat="server" Text='<%# Bind("CatName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CatName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category Description">
                <EditItemTemplate>
                    <asp:TextBox ID="tbCatDesc" Font-Size="X-Small" runat="server" Text='<%# Bind("CatDesc") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("CatDesc") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Question Text">
                <EditItemTemplate>
                    <asp:TextBox ID="tbQuestionTxt" Font-Size="X-Small"  runat="server" Text='<%# Bind("QuestionTxt") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("QuestionTxt") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Correct Answer">
                <EditItemTemplate>
                    <asp:TextBox ID="tbAnswerCorrect" Font-Size="X-Small"  runat="server" Text='<%# Bind("AnswerCorrect") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("AnswerCorrect") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Answer 1">
                <EditItemTemplate>
                    <asp:TextBox ID="tbAnswer1" runat="server" Font-Size="X-Small"  Text='<%# Bind("Answer1") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Answer1") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Answer 2">
                <EditItemTemplate>
                    <asp:TextBox ID="tbAnswer2" runat="server" Font-Size="X-Small"  Text='<%# Bind("Answer2") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("Answer2") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Answer 3">
                <EditItemTemplate>
                    <asp:TextBox ID="tbAnswer3" runat="server" Font-Size="X-Small"  Text='<%# Bind("Answer3") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Answer3") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Answer 4">
                <EditItemTemplate>
                    <asp:TextBox ID="tbAnswer4" runat="server" Font-Size="X-Small"  Text='<%# Bind("Answer4") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("Answer4") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Answer 5">
                <EditItemTemplate>
                    <asp:TextBox ID="tbAnswer5" runat="server" Font-Size="X-Small"  Text='<%# Bind("Answer5") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("Answer5") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Explanation">
                <EditItemTemplate>
                    <asp:TextBox ID="tbExplnText" runat="server" Font-Size="X-Small"  Text='<%# Bind("ExplnText") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("ExplnText") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>      
    </div>
</asp:Content>
