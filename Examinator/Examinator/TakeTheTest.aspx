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
            Instructions:<br /><br />
            You will be given one minute per question. <br /><br />
            The timer bar to the far right of the page will tell you how much time you have left.<br />
            The progress bar to the right of the answers will give you easy access to questions.<br /><br />
            Click the answer to select. Questions that have been answered will appear <b style="color:green">green</b> in the progress bar.<br /><br />
            Click the Question to bookmark. Bookmarked questions will appear <b style="color:blue">blue</b> in the progress bar.<br /> <br />
            Click the Next button without selecting an answer to skip a question.<br /><br /> 
            Skipped or unanswered questions will appear <b style="color:grey">grey</b> in the progress bar.<br />            
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
                    <h2 id="testQuestion"></h2><br />            
                    <h3>Click to bookmark this question!</h3>
                </div>
                <div id="answerBox" class="answerBox">
                    <div class="answer1"><p id="Answer1"></p></div>
                    <div class="answer2"><p id="Answer2"></p></div>
                    <div class="answer3"><p id="Answer3"></p></div>
                    <div class="answer4"><p id="Answer4"></p></div>
                </div> 
                 <div class="buttonBox">
                   <input type ="button" id="btnPrev" class="prevButton" onclick="getPrevious()" value="Previous" />
                   <input type ="button" id="btnNext" class="nextButton" onclick="getNext()" value="   Next   " />
                </div>             
            </div>
            <div class="panelWrapper">
                   <div id="legend" class="legend">
                       <p>
                           <b style="color:#4AA85D">Green</b> - Question Completed<br />
                           <b style="color:#39A2B3">Blue</b> - Question Bookmarked<br />
                           <b style="color:grey">Grey</b> - Question Unanswered
                        </p>
                   </div>
                   <div id="progBar" class="progressbar"></div>
                   <div id="timerWrapper">
                       <div class="timerbar">
                           <span id="timer" style="height: 100%;"></span>
                       </div>
                   </div>
                   <input type="button" id="btnFinished" class="completeTest" value="Finish Test" />
            </div>
        </div>
    </div>
    <div id="testResults">
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
                $(document).bind("keydown", disableF5);
                $(document).on("keydown", disableF5);
                getQuiz(chosenCategory, chosenMode, chosenDifficulty);
                fadeToNext('#testPrep', '#test');
                return false;
            });

            $('#answerBox div').click(function(){
                var chosenIndex = $('#answerBox div').index(this);
                answerChosen(chosenIndex);
            });

            $(".questionBox").click(function () {
                bookmarkQuestion();
            });

            $('#progBar').on('click', 'div', function () {
                var getNumber = this.id.split('quest');
                var questionNo = parseInt(getNumber[1]) - 1;
                quickJump(questionNo);
            });

            $("#btnFinished").click(function () {
                testResults();
                fadeToNext('#test', '#testResults');
            });
        });
    </script>
</asp:Content>

