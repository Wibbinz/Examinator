<%@ Page Title="TakeTheTest" Language="C#" MasterPageFile="~/ExamMaster.Master" AutoEventWireup="true" CodeBehind="TakeTheTest.aspx.cs" Inherits="Examinator.TakeTheTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="testWrapper">
        <div class="questionAnswerWrapper">
            <div class="questionBox">
                <p>
                    The Pythagorean Theorm states that the square of the hypotenuse of a right triangle is equal to the:
                </p>
            </div>
            <div class="answerBox">
                <div class="answer1">The sum of the square of the other two sides.</div>
                <div class="answer2">The square of the sum of the other two sides.</div>
                <div class="answer3">The square root of the product of the other two sides.</div>
                <div class="answer4">The product of the square root of the other two sides.</div>
            </div>        
        </div>
        <div class="panelWrapper">
            <div class="skipBox"><h1>Skip</h1></div>
            <div class="reviewBox"><h1>Review</h1></div>
            <div class="completeBox"><h1>Complete</h1></div>
        </div>
    </div>
</asp:Content>
