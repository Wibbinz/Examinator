<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="Leaderboards.aspx.cs" Inherits="Examinator.Leaderboards" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Leaderboards</h1><br />
    <asp:Label ID="lblDisplay" runat="server" Forecolor="Yellow" Text="Please change your preferences if you wish to display personal scores on the public leaderboard." Visible="false"></asp:Label>
    <br /><br /><br />
    <table>
        <tr>
            <td> 
                <asp:GridView ID="gvLeaderBoards" Caption="Top Scores" CssClass="gvskin" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="CatName" HeaderText="Category" />
                        <asp:BoundField DataField="UserName" HeaderText="User" />
                        <asp:BoundField DataField="ScoreTotalScore" HeaderText="Score" />
                        <asp:BoundField DataField="ScoreDateTaken" DataFormatString="{0:d}" HeaderText="Date" />
                    </Columns>
                </asp:GridView>
            </td>
            <td style="width:200px;"></td>
            <td>
                <asp:GridView ID="gvPersonal" Caption="Your Personal Bests" CssClass="gvskin" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="CatName" HeaderText="Category" />
                        <asp:BoundField DataField="ScoreTotalScore" HeaderText="Score" />
                        <asp:BoundField DataField="ScoreTotalTime" HeaderText="Time" />
                        <asp:BoundField DataField="ScoreDateTaken" DataFormatString="{0:d}" HeaderText="Date" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>       
</asp:Content>
