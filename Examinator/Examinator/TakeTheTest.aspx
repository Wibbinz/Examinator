<%@ Page Title="TakeTheTest" Language="C#" MasterPageFile="~/ExamMaster.Master" AutoEventWireup="true" CodeBehind="TakeTheTest.aspx.cs" Inherits="Examinator.TakeTheTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="initialScreen">        
        <h1>Categories</h1>       
        <div class="catOuterBox">    
            <input type="button" class="catPrev" />       
            <ul id="catStrip"></ul>
            <input type="button" class="catNext" />
        </div>    
    </div>
    <div id="testPrep">
         <h1>Take the test!</h1>  
        <p class="guideline">
            Guidelines:<br />
            If you would like to add a question to the skip or review lists to the right, just click and drag them to the panel.<br />
            To revisit a question, click on the question number in the panel. 
            Questions that you do not specifically put in a panel will automatically go into the 'Completed' box, but can be revisited as well.
        </p>
        <h2><a id="testID" href="#">START TEST</a></h2>
    </div>
    <div id="test">        
        <div class="testWrapper">
            <div class="questionAnswerWrapper">
                <div class="questionBox">
                    <p>
                        The Pythagorean Theorm states that the square of the hypotenuse of a right triangle is equal to the:
                    </p>            
                </div>
                <div class="answerBox">
                    <div class="answer1"><p>The sum of the square of the other two sides.</p></div>
                    <div class="answer2"><p>The square of the sum of the other two sides.</p></div>
                    <div class="answer3"><p>The square root of the product of the other two sides.</p></div>
                    <div class="answer4"><p>The product of the square root of the other two sides.</p></div>
                </div> 
                 <div class="buttonBox">
                   <asp:Button ID="btnPrev" CssClass="prevButton" runat="server" Text="Previous" />
                   <asp:Button ID="btnNext" CssClass="nextButton" runat="server" Text="   Next   " />
                </div>             
            </div>
            <div class="panelWrapper">
                <div class="skipBox"><h1>Skip</h1></div>
                <div class="reviewBox"><h1>Review</h1></div>
                <div class="completeBox"><h1>Complete</h1></div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            //populating category strip
            var returnStr = '<%=GetArrayStream() %>';
            var category = returnStr.split('|');
            var currentindex = 0;
            populateDivs(category, currentindex);

            $(".catPrev").click(function () {
                if (currentindex > 0) {
                    currentindex -= 1;
                }
                else {
                    currentindex = category.length-1;
                }
                populateDivs(category, currentindex);
            });

            $(".catNext").click(function () {
                if (currentindex < category.length-1) {
                    currentindex += 1;
                }
                else {
                    currentindex = 0
                }
                populateDivs(category, currentindex);
            });

            //fading out and in phases of the overall page
            $("#testID").click(function () {
                $('#testPrep').fadeOut(1000, function () {
                    $('#test').fadeIn(1000);
                });
                return false;
            });

        });
    </script>
</asp:Content>

