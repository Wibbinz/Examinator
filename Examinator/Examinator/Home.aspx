<%@ Page Title="Home" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Examinator.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="menucontainer">
        <div class="column">
             <a href="AboutUs.aspx"><div class="menudiv"><h3>About Us</h3></div></a><br />
             <img class="vertImg" src="images/Simpson.png" />
        </div>
        <div class="column">
             <img class="vertImg" src="images/fire music.jpg" /><br />
             <a class="conditionalLink" href="TakeTheTest.aspx" ><div class="menudiv"><h3>Take a Test</h3></div></a>
        </div>
        <div class="column">
             <a href="Leaderboards.aspx"><div class="menudiv"><h3>Leaderboards</h3></div></a><br />             
             <img class="vertImg" src="images/DaVinci.png" />
        </div>
        <div class="column">
             <a class="conditionalLink" href="TakeTheTest.aspx#testPrep" onclick="blockRedirect();"><img class="horizImg" src="images/Terminator Panda.jpg" /></a>
             <a class="conditionalLink" href="UploadQuestions.aspx" onclick="blockRedirect();"><div class="menudiv"><h3>Upload Questions</h3></div></a><br />
             <img class="horizImg" src="images/Spocks.png" />
        </div>
    </div>
    <script>
        $(document).ready(function () {

            //Users who have not logged in are restricted to only the About Us and Leaderboards pages.
            $(".conditionalLink").click(function (event) {
                var user = '<%= Session["User"] %>';
                if (user.toString() == '') {
                    alert("Please Log in first.");
                    event.preventDefault();
                }
            });
        });
    </script>
</asp:Content>
