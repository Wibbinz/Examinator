<%@ Page Title="Home" Language="C#" MasterPageFile="~/DefaultMaster.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Examinator.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="menucontainer">
        <div class="column">
             <a href="Junior.aspx"><div class="menudiv"><h3>Examinator Junior</h3></div></a><br />
             <img class="vertImg" src="images/miscbg.jpg" />
        </div>
        <div class="column">
             <img class="vertImg" src="images/fire music.jpg" /><br />
             <a href="TakeTheTest.aspx"><div class="menudiv"><h3>Take a Test</h3></div></a>
        </div>
        <div class="column">
             <a href="Practice.aspx"><div class="menudiv"><h3>Leaderboards</h3></div></a><br />             
             <img class="vertImg" src="images/onelight.jpg" />
        </div>
        <div class="column">
             <img class="horizImg" src="images/eggy3.jpg" />
             <a href="UploadQuestions.aspx"><div class="menudiv"><h3>Upload Questions</h3></div></a>
             <a href="About.aspx"><div class="menudiv"><h3>About Us</h3></div></a>
        </div>
    </div>
</asp:Content>
