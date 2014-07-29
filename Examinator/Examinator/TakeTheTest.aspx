<%@ Page Title="TakeTheTest" Language="C#" MasterPageFile="~/ExamMaster.Master" AutoEventWireup="true" CodeBehind="TakeTheTest.aspx.cs" Inherits="Examinator.TakeTheTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--Initial Screen with Categories--%>
    <div id="initialScreen">        
        <h1>Categories</h1>  
        <p>
            Please NOTE: If you have not set your preferences to display unapproved questions and categories, these will not be available to you.
        </p>     
        <div class="catOuterBox">    
            <input type="button" class="catPrev" />       
            <ul id="catStrip"></ul>
            <input type="button" class="catNext" />
        </div>    
    </div>

    <%--Mode Screen with Difficulty and Mode dropdown menus--%>
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

    <%--Guidelines and Get ready screen for the Test--%>
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

        <%--'Easter Egg' Alert and Panda Screen--%>
        <div id="pandaDiv"></div>
        <div id="alertWindow" class="alertWindow">            
            <div id="message">
                <a id="messageClose" href="#close" title="Close" class="close">X</a>  
            </div>                                                          
        </div>  


        <%--Test Screen Starts here--%>
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

                <%--Alert Window when the last question has been reached--%>
                <div id="endOfTest" class="alertWindow">
                    <div id="endMessage">
                        <a href="#close" title="Close" class="close">X</a>  
                    </div>                                                          
                </div> 

                <%--Question Div--%>
                <div class="questionBox">                    
                    <h2 id="testQuestion"></h2><br />            
                    <h3>Click to bookmark this question!</h3>
                </div>

                <%--Answer Divs--%>
                <div id="answerBox" class="answerBox">
                    <div class="answer1"><p id="Answer1"></p></div>
                    <div class="answer2"><p id="Answer2"></p></div>
                    <div class="answer3"><p id="Answer3"></p></div>
                    <div class="answer4"><p id="Answer4"></p></div>
                </div> 
                    
                    <%--Previous and Next Buttons--%>
                    <div class="buttonBox">
                    <input type ="button" id="btnPrev" class="prevButton" onclick="getPrevious()" value="Previous" />
                    <input type ="button" id="btnNext" class="nextButton" onclick="getNext()" value="   Next   " />
                </div>             
            </div>

            <%--Timer and Progress bars--%>
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
                    
                    <%--Finish Test button--%>
                    <input type="button" id="btnFinished" class="completeTest" value="Finish Test" />
            </div>
        </div>
    </div>


    <%--Result Screen populated in Exam.js--%>
    <div id="testResults"></div>
    
      
    <script>
        $(document).ready(function () {
            
            //Initializing user input variables and getting categories from the
            //GetCategories method in the code behind of this page.
            var chosenCategory = '';
            var chosenMode = '';
            var chosenDifficulty = '';
            var catInfo = '<%=GetCategories() %>';

            //Redirecting home if error encountered or setting the category to the array returned
            //by 'GetCategories' in the code behind of this page and setting the 'initial' currentindex to 0.
            if (catInfo.split(0, 5) == 'Error') {
                alert('ERROR');
                window.location.href = "/Home.aspx";
            }
            else {
                var category = catInfo.split('|');
                var currentindex = 0;
            }

            //If the user entered the page via the secret logo button, the panda animation and alert box are displayed.
            if (location.hash == '#testPrep') {
                $("#initialScreen").fadeOut(100, function () {
                    pandaGo();
                    alertBox("CONGRATULATIONS! You have unearthed the secret easter egg! Category: Potpourri", "alertWindow", "message");
                    chosenCategory = "Potpourri";
                    chosenMode = "Exam";
                    chosenDifficulty = "Potpourri";
                    $("#testPrep").fadeIn(250);
                });
            }

            //Panda animation is stopped if the close button is clicked.
            $("#messageClose").click(function () {
                $("#panda").stop(true,true,true);
            });


            //The dropdown values are defaulted to '1'
            $("select#ddModes").val(1);
            $("select#ddDifficulty").val(1);

            //Category divs are populated by sending the category and current index to the populateDivs
            //method in Exam.js.
            populateDivs(category, currentindex);
            

            //If the left arrow is clicked in the category bar, the index is reevaluated
            //and sent through the populateDivs method in Exam.js.
            $(".catPrev").click(function () {
                if (currentindex > 0) {
                    currentindex -= 3;
                }
                else {
                    currentindex = category.length-3;
                }
                populateDivs(category, currentindex);                
            });

            //If the right arrow is clicked in the category bar, the index is reevaluated
            //and sent through the populateDivs method in Exam.js.
            $(".catNext").click(function () {
                if (currentindex < category.length-4) {
                    currentindex += 3;
                }
                else {
                    currentindex = 0
                }
                populateDivs(category, currentindex);
            });

            //Getting the index of the category chosen by the user and fading to the next phase or div
            //of the page.
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

            //Getting the text of the option selected from the mode and difficulty
            //dropdown menus and fading to the next phase or div of the page.
            $("#modeButton").click(function () {
                chosenMode = $("#ddModes option:selected").text().toLowerCase();
                chosenDifficulty = $("#ddDifficulty option:selected").text().toLowerCase();
                fadeToNext('#modeScreen', '#testPrep');
            });

            //Disabling f5 in case users accidentally press the wrong button
            //then generating the quiz based on the chosen category, mode, difficulty
            //and whether the user wishes to display questions that have not been approved
            //by an administrator and fading to the quiz div.
            $("#testID").click(function () {
                $(document).bind("keydown", disableF5);
                $(document).on("keydown", disableF5);
                var prefunapproved = '<%=Session["PrefUnapproved"]%>';
                if (prefunapproved) {
                    getQuiz(chosenCategory, chosenMode, chosenDifficulty, "yes");
                }
                else {
                    getQuiz(chosenCategory, chosenMode, chosenDifficulty, "no");
                }
                fadeToNext('#testPrep', '#test');
                return false;
            });

            //Invoking the answerChosen method in Exam.js if an answerDiv is clicked.
            $('#answerBox div').click(function(){
                var chosenIndex = $('#answerBox div').index(this);
                answerChosen(chosenIndex);
            });

            //Bookmarking a question using the bookmarkQuestion method of Exam.js if a
            //question div is clicked.
            $(".questionBox").click(function () {
                bookmarkQuestion();
            });

            //Jumping to a question if the question number is clicked on the progress bar
            //using quickJump method of Exam.js.
            $('#progBar').on('click', 'div', function () {
                var getNumber = this.id.split('quest');
                var questionNo = parseInt(getNumber[1]) - 1;
                quickJump(questionNo);
            });

            //Invoking the testResults method of Exam.js once the Finish button is clicked
            //and fading to the test results div of the page.
            $("#btnFinished").click(function () {
                var scoreBit = '<%=Session["PrefShowLeader"]%>';
                var user = '<%=Session["UserName"]%>';
                testResults(user.toString(), scoreBit);
                fadeToNext('#test', '#testResults');
            });            
        });
    </script>
</asp:Content>

