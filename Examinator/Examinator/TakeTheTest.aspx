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
    <div id="modeScreen">
        <h2 id="chosenCategory"></h2>        
        <select class="ddSelects" id="ddModes"></select>
        <select class="ddSelects" id="ddDifficulty">
            <option value="0">Easy</option>
            <option value="1">Medium</option>
            <option value="2">Hard</option>
        </select>
        <input type="button" class="button" id="modeButton" value="Continue"/>
    </div>
    <div id="testPrep">
         <h1>Take the test!</h1>  
        <p class="guideline">
            Guidelines:<br />
            If you would like to add a question to the skip or review lists to the right, just click and drag them to the panel.<br />
            To revisit a question, click on the question number in the panel. 
            Questions that you do not specifically put in a panel will automatically go into the 'Completed' box, but can be revisited as well.
        </p>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="updatePanelTest" runat="server" ChildrenAsTriggers="true">
        <ContentTemplate>
            <h2><a id="testID" href="#">START TEST</a></h2>
            <table id="questions"></table>
        </ContentTemplate>
        </asp:UpdatePanel>  
    </div>
    <div id="test">        
        <div class="testWrapper">
            <div class="questionAnswerWrapper">
                <div class="questionBox">
                    <p id="testQuestion">
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
                   <input type ="button" id="btnPrev" class="prevButton" onclick="getPrevious()" value="Previous" />
                   <input type ="button" id="btnNext" class="nextButton" value="   Next   " />
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
            var chosenCategory = '';
            var chosenMode = '';
            var chosenDifficulty = '';
            var catInfo = '<%=GetCategories() %>';
            var category = catInfo.split('|');
            var currentindex = 0;
            $("select#ddModes").val(1);
            $("select#ddDifficulty").val(1);
            populateDivs(category, currentindex);

            $(".catPrev").click(function () {
                if (currentindex > 0) {
                    currentindex -= 3;
                }
                else {
                    currentindex = category.length-3;
                }
                populateDivs(category, currentindex);                
            });

            $(".catNext").click(function () {
                if (currentindex < category.length-4) {
                    currentindex += 3;
                }
                else {
                    currentindex = 0
                }
                populateDivs(category, currentindex);
            });

            //fading out and in phases of the overall page
            $('#catStrip').on('click', 'li', function () {
                var getNumber = this.id.split('number');
                if (getNumber[1] == category.length) {
                    chosenCategory = category[0];
                }
                else {
                    chosenCategory = category[getNumber[1]];
                }
                fadeToNext('#initialScreen', '#modeScreen');
                $("#chosenCategory").text(chosenCategory);
                var options = $("#ddModes");
                if (category[parseInt(getNumber[1]) + 2] == "Modes Available: Freestyle") {
                    options.append(new Option("Freestyle", "Freestyle"));
                }
                else if (category[parseInt(getNumber[1]) + 2] == "Modes Available: Exam, Practice, Freestyle") {
                    options.append(new Option("Freestyle", "Freestyle"));
                    options.append(new Option("Practice", "Practice"));
                    options.append(new Option("Exam", "Exam"));
                }
                else {
                    options.append(new Option("Freestyle", "Freestyle"));
                    options.append(new Option("Practice", "Practice"));
                }
            });

            $("#modeButton").click(function () {
                chosenMode = $("#ddModes option:selected").text().toLowerCase();
                chosenDifficulty = $("#ddDifficulty option:selected").text().toLowerCase();
                fadeToNext('#modeScreen', '#testPrep');
            });

            $("#testID").click(function () {
                getQuiz(chosenCategory, chosenMode, chosenDifficulty);
                fadeToNext('#testPrep', '#test');
                return false;
            });
        });
    </script>
</asp:Content>

