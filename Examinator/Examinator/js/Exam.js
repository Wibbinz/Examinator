
//Global Variables
var quiz; //will hold the entire quiz - questions, answers, times, explanations etc.
var wrongAnswers; //will hold the incorrect answers for a given question, which will be used to populate the answer divs
var correctAnswer; //will hold the correct answer for a given question.
var correctAnsweri; //will hold the index of the correct answer for checking against the chosen answer
var currentQuestionNumber; //will hold the current Question number
var start; //will hold the start timer for each question
var maxTime; //will hold the max time, calculated using the number of questions in a quiz
var timeoutVal;//sets when the timer bar should time out depending on the number of quetsions.
var indivTimer;//will hold the time taken for the current question.
var results = [];//will hold the number, answertext, right or wrong, time taken and score for each question.

//This function is called when the 'TakeTheTest' page is visited.
//The category parameter holds an array of strings with all the category information
//necessary to populate the clickable divs as well as the captions, which appear when
//the divs are hovered over.
function populateDivs(category, index) {
    var catStrip = document.getElementById("catStrip");
    while (catStrip.firstChild) {
        catStrip.removeChild(catStrip.firstChild);
    }    
    for (var i = index; i < index + 12; i +=3) {
        var newCategory = document.createElement('li');
        newCategory.setAttribute('class', 'catDiv');
        newCategory.setAttribute('id', 'number' + i);
        var color = getRandomColor();
        newCategory.setAttribute('style', 'background-color:' + color);

        var newDescription = document.createElement('figcaption');
        newDescription.setAttribute('id', 'desc' + i);
        var desc = document.createElement('p');
        var mode = document.createElement('p');

        if (i < category.length-1) {
            var catName = document.createTextNode(category[i]);
            var catDesc = document.createTextNode(category[i + 1]);
            var catMode = document.createTextNode(category[i + 2]);
        }
        else {
            var catName = document.createTextNode(category[i - category.length]);
            var catDesc = document.createTextNode(category[i - category.length+1]);
            var catMode = document.createTextNode("Mode: " + category[i - category.length+2]);
        }
        newCategory.appendChild(catName);
        desc.appendChild(catDesc);
        newDescription.appendChild(desc);
        mode.appendChild(catMode);
        newDescription.appendChild(mode);
        newCategory.appendChild(newDescription);
        catStrip.appendChild(newCategory);
    };   
}

//This function is called on by the above function to generate random colors for the
//clickable category divs.
function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

//This function is called from the 'TakeTheTest' page when a selection is made
//and the next 'phase' of the test needs to be faded in after fading the current
//'phase' out.
function fadeToNext(eToFade, eNext) {
    $(eToFade).fadeOut(250, function () {
        $(eNext).fadeIn(250);
    });
}

//This function passes the chosen category, mode, difficulty and preference of whether unapproved questions
//are to be displayed or not to the 'getTest' web method. The questions and answers retrieved from the webmethod
//are then passed to the 'popQuiz' function to populate the appropriate divs.
function getQuiz(chosenCategory, chosenMode, chosenDifficulty, showUnapproved) {
    $.ajax({
        type: "POST",
        url: "/QuizService.asmx/getTest",
        contentType: "application/json",
        data: JSON.stringify({ "category": chosenCategory, "mode": chosenMode, "difficulty": chosenDifficulty, "showUnapproved": showUnapproved }),
        success: function (data) {
            var result = JSON.parse(data.d);
            popQuiz(result);
            return false;
        },
        error: function (error) {            
            alert(error.responseText);
            return false;
        }
    });
}


//This function receives the quiz questions from the above function, then populates the respective divs with 
//questions and answers by calling the function 'popQuestionAnswerParas.'
//The 'RandomAnswerGenerator' function is invoked to determine which 4 of the 6 available
//answers will be chosen. The 'popProgBar' function is invoked to populate the progress bar with the correct
//number of clickable divs. The 'animateUpdate' function is called to animate the timerbar.
function popQuiz(quizQuestions) {   
    RandomAnswerGenerator();
    quiz = quizQuestions;
    currentQuestionNumber = 0;
    for (var i = 0; i < quiz.length; i++) {
        var tempEntry = {
            question: (i + 1),
            answertext: '',
            rightOrWrong: 0,
            time: 0,
            score: 0
        };
        results[i] = tempEntry;
    }    
    var prevButton = document.getElementById("btnPrev");
    prevButton.style.display = "none";
    popProgBar(quiz.length);
    popQuestionAnswerParas(currentQuestionNumber);
    start = new Date();
    maxTime = quiz.length*60000;
    timeoutVal = Math.floor(maxTime / 100);
    animateUpdate();
}

//This function uses the index passed to it on the global array 'quiz'
//to populate the question and answer divs in the right positions.
//It calls function 'textDeco' below to decorate the answer text based on
//whether the answer was chosen previously.
function popQuestionAnswerParas(index) {
    indivTimer = new Date();    
    var chosentext = results[currentQuestionNumber].answertext;
    var question = document.getElementById("testQuestion");
    var qt = quiz[index].QuestionTxt;
    question.innerHTML = "Question #" + (index + 1) + ":<br><br>";
    question.appendChild(document.createTextNode(qt));
    var answerPosition = ['Answer1', 'Answer2', 'Answer3', 'Answer4'];
    correctAnsweri = Math.floor(Math.random() * 5);    
    while (correctAnsweri > 4 || correctAnsweri < 1){
        correctAnsweri = Math.floor(Math.random() * 5);
    }
    correctAnswerIndex = 'Answer' + correctAnsweri;
    var currentIndex = answerPosition.length;
    var wrongAnswerIndex = 0;
    while ((0 != currentIndex)) {
        currentIndex -= 1;        
        if (currentIndex != (correctAnsweri - 1)) {
            var answer = document.getElementById(answerPosition[currentIndex]);
            var waI = wrongAnswers[wrongAnswerIndex];
            if (waI == 'Answer1') {
                answer.textContent = quiz[index].Answer1;
                textDeco(answer, chosentext, answer.textContent);
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer2') {
                answer.textContent = quiz[index].Answer2;
                textDeco(answer, chosentext, answer.textContent);
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer3') {
                answer.textContent = quiz[index].Answer3;
                textDeco(answer, chosentext, answer.textContent);
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer4') {
                answer.textContent = quiz[index].Answer4;
                textDeco(answer, chosentext, answer.textContent);
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer5') {
                answer.textContent = quiz[index].Answer5;
                textDeco(answer, chosentext, answer.textContent);
                wrongAnswerIndex += 1;
            }
        }
        else {       
            var answer = document.getElementById(correctAnswerIndex);
            answer.textContent = quiz[index].AnswerCorrect;
            textDeco(answer, chosentext, answer.textContent);
        }
    }
}

//This function decorates the answer or removes decoration
//based on whether the answer was chosen by the user previously.
function textDeco(answer, text1, text2) {
    if (text1 == text2) {
        answer.style.fontWeight = "bold";
        answer.style.fontStyle = "italic";
        answer.style.background = "#B0AFC9";
    }
    else {
        answer.style.fontWeight = "normal";
        answer.style.fontStyle = "normal";
        answer.style.background = "none";
    }
}

//This function populates the protress bar with the correct
//number of clickable divs depending on the index
function popProgBar(index) {
    var progress = document.getElementById("progBar");
    for (var i = 0; i < index; i += 1) {        
        var newProgressDiv = document.createElement('div');
        newProgressDiv.setAttribute('class', 'progQuestion');
        newProgressDiv.setAttribute('id', 'quest' + (i + 1));
        var questionNo = document.createElement('p');
        var qNo = document.createTextNode(i + 1);
        questionNo.appendChild(qNo);
        newProgressDiv.appendChild(questionNo);
        progress.appendChild(newProgressDiv);
    }
}

//This function changes the index of the current question and calls the popQuestionAnswerParas function
//to populate the divs with the appropriate questions and answers. It checks the current question against
//the length of the quiz to display or hide the previous and next buttons when the limits are reached.
function getPrevious() {
    getIndivTimer();
    currentQuestionNumber -= 1;
    popQuestionAnswerParas(currentQuestionNumber);
    if (currentQuestionNumber == quiz.length-2) {
        var nextButton = document.getElementById("btnNext");
        nextButton.style.display = "initial";
    }
    if (currentQuestionNumber == 0) {
        var prevButton = document.getElementById("btnPrev");
        prevButton.style.display = "none";
    }   
}

//This function changes the index of the current question and calls the popQuestionAnswerParas function
//to populate the divs with the appropriate questions and answers. It checks the current question against
//the length of the quiz to display or hide the previous and next buttons when the limits are reached.
function getNext() {
    getIndivTimer();
    currentQuestionNumber += 1;
    popQuestionAnswerParas(currentQuestionNumber);
    if (currentQuestionNumber == quiz.length-1) {
        var nextButton = document.getElementById("btnNext");
        nextButton.style.display = "none";
    }
    if (currentQuestionNumber == 1) {        
        var prevButton = document.getElementById("btnPrev");
        prevButton.style.display = "initial";
    }
}

//This function is called when a div from the progress bar is clicked. It uses
//the index of the div to determine what the current question number is, hides or
//unhides the next or previous buttons as needed, and calls on popQuestionAnswerParas
//to populate the question and answer divs.
function quickJump(qNumber) {
    getIndivTimer();
    currentQuestionNumber = qNumber;
    if (currentQuestionNumber <= quiz.length - 2) {
        var nextButton = document.getElementById("btnNext");
        nextButton.style.display = "initial";
    }
    if (currentQuestionNumber == 0) {
        var prevButton = document.getElementById("btnPrev");
        prevButton.style.display = "none";
    }
    if (currentQuestionNumber == quiz.length - 1) {
        var nextButton = document.getElementById("btnNext");
        nextButton.style.display = "none";
    }
    if (currentQuestionNumber >= 1) {
        var prevButton = document.getElementById("btnPrev");
        prevButton.style.display = "initial";
    }    
    popQuestionAnswerParas(qNumber);
}

//This function is called when an answer div is clicked by the user to choose an answer.
//It records the index of the div clicked, compares it against the global variable 'correctAnsweri'
//to determine whether it is write or wrong, then writes it to the global array 'result' at the 
//correct index. Once an answer is recorded, the 'getNext' function is clicked if there are questions
//remaining, otherwise the alertBox is displayed to tell the user to finish the test.
function answerChosen(chosenIndex) {
    var pd = 'quest' + (currentQuestionNumber+1);
    var progDiv = document.getElementById(pd);
    progDiv.style.background = '#4AA85D';
    var chosenDiv = document.getElementById('Answer' + (chosenIndex + 1));
    if (correctAnsweri == (chosenIndex + 1)) {
        results[currentQuestionNumber].rightOrWrong = 1;
        results[currentQuestionNumber].answertext = quiz[currentQuestionNumber].AnswerCorrect;
        results[currentQuestionNumber].score = 10;
    }
    else {
        results[currentQuestionNumber].answertext = chosenDiv.textContent;
    }
    chosenDiv.style.border = '#39A2B3';
    if (currentQuestionNumber < quiz.length - 1) {
        getNext();
    }
    else {
        alertBox("You have reached the end of the world! (Please hit finish test)", "endOfTest", "endMessage");
    }
}

//This function is called when a question div is clicked in order to bookmark a function. 
function bookmarkQuestion() {
    var pd = 'quest' + (currentQuestionNumber + 1);
    var progDiv = document.getElementById(pd);
    progDiv.style.background = '#39A2B3';
    if (currentQuestionNumber < quiz.length - 1) {
        getNext();
    }
    else {
        alert("You have reached the end of the world!");
    }
}

//This function is called by the popQuiz function to populate the global variable 'wrongAnswers'
//with a random selection of 4 answers from the 5 given incorrect answers.
function RandomAnswerGenerator() {
    var answerSet = ['Answer1', 'Answer2', 'Answer3', 'Answer4', 'Answer5'];
    var currentIndex = answerSet.length, temporaryValue, randomIndex;
    while (0 !== currentIndex) {
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;
        temporaryValue = answerSet[currentIndex];
        answerSet[currentIndex] = answerSet[randomIndex];
        answerSet[randomIndex] = temporaryValue;
    }
    wrongAnswers = answerSet.slice(0, 3);
}

//This function is called when the finish test button is clicked. It calculates the total score,
//total time, and whether the user would like their scores to be displayed publicly (scoreBit)
//and sends the information through the function 'sendResults' (below) to be recorded.
//It also calls the function 'setNewTimes' to record the individual times taken for each question (also below).
//Then it creates a table and a summary div with the results of the test for display.
function testResults(user, scoreBit) {    
    getIndivTimer();
    var totScore = 0;
    var totTime = 0;
    var numberCorrect = 0;
    var underTwo = 0;
    for (var i = 0; i < results.length; i++) {
        totScore = totScore + parseInt(results[i].score);
        totTime = totTime + parseInt(results[i].time);
        if (results[i].score == 10) {
            numberCorrect++;
        }
        if (results[i].time <= 2) {
            underTwo++;
        }
    }

    //Sending the results of the test to the database
    sendResults(user, totScore, totTime, scoreBit);
    //Sending the new times of each question to the database
    setNewTimes();

    //Creating and populating the table
    var myDiv = document.getElementById('testResults');
    var tbl = document.createElement('table');
    tbl.setAttribute('id', 'tableResults');
    tbl.setAttribute('class', 'tableskin');
    var tbdy = document.createElement('tbody');
    for (var i = 0; i < results.length+1; i++) {
        var tr = document.createElement('tr');
        if (i > 0) {
            tr.title = quiz[i-1].ExplnText;
        }
        for (var j = 0; j < 7; j++) {
            var td = document.createElement('td');
            if (i == 0 && j == 0) {
                td.style.fontWeight = "bold"; td.style.fontSize = "14px";
                td.appendChild(document.createTextNode('#'))
            }
            else if (i == 0 && j == 1) {
                td.style.fontWeight = "bold"; td.style.fontSize = "14px";
                td.appendChild(document.createTextNode('Question'))
            }
            else if (i == 0 && j == 2) {
                td.style.fontWeight = "bold"; td.style.fontSize = "14px";
                td.appendChild(document.createTextNode('Your Answer'))
            }
            else if (i == 0 && j == 3) {
                td.style.fontWeight = "bold"; td.style.fontSize = "14px";
                td.appendChild(document.createTextNode('Correct Answer'))
            }
            else if (i == 0 && j == 4) {
                td.style.fontWeight = "bold"; td.style.fontSize = "14px";
                td.appendChild(document.createTextNode('Status'))
            }
            else if (i == 0 && j == 5) {
                td.style.fontWeight = "bold"; td.style.fontSize = "14px";
                td.appendChild(document.createTextNode('Time (seconds)'))
            }
            else if (i == 0 && j == 6) {
                td.style.fontWeight = "bold"; td.style.fontSize = "14px";
                td.appendChild(document.createTextNode('Your Score'));
            }
            else if (j == 0){
                td.appendChild(document.createTextNode(results[i - 1].question));
            }
            else if (j == 1) {
                td.appendChild(document.createTextNode(quiz[i - 1].QuestionTxt));
            }
            else if (j == 2) {
                td.appendChild(document.createTextNode(results[i - 1].answertext));
            }
            else if (j == 3) {
                td.appendChild(document.createTextNode(quiz[i - 1].AnswerCorrect));
            }
            else if (j == 4) {
                if (results[i - 1].rightOrWrong == 0) {
                    td.appendChild(document.createTextNode('Incorrect'));
                }
                else {
                    td.appendChild(document.createTextNode('Correct'));
                }
            }
            else if (j == 5) {
                td.appendChild(document.createTextNode(results[i-1].time));
            }
            else if (j == 6) {
                td.style.fontWeight = "bold"; td.style.color = "green";
                td.style.fontSize = "12px";
                td.appendChild(document.createTextNode(results[i - 1].score));
            }
            tr.appendChild(td)
        }
        tbdy.appendChild(tr);
    }
    tbl.appendChild(tbdy);
    myDiv.appendChild(tbl);

    //Creating and Populating the Summary div.
    var finalScoreTab = document.createElement('div');
    finalScoreTab.setAttribute('id', 'finalScoreTab');
    finalScoreTab.setAttribute('class', 'finalScore');    
    finalScoreTab.appendChild(document.createTextNode('You got: '));
    finalScoreTab.appendChild(document.createElement("br"));
    finalScoreTab.appendChild(document.createTextNode(numberCorrect + '/' + (results.length) + ' Answers Correct.'));
    finalScoreTab.appendChild(document.createElement('br'));
    finalScoreTab.appendChild(document.createTextNode(underTwo + '/' + (results.length) + ' Answer Under 2 Seconds.'));
    finalScoreTab.appendChild(document.createElement("br"));
    finalScoreTab.appendChild(document.createTextNode('Your Final Score is:'));
    finalScoreTab.appendChild(document.createElement("br"));
    var totalScore = document.createElement("h2");
    totalScore.style.color = "green"; totalScore.style.fontWeight = "bold";
    totalScore.innerHTML = totScore;
    finalScoreTab.appendChild(totalScore);
    finalScoreTab.appendChild(document.createElement("br"));    
    myDiv.appendChild(finalScoreTab);
}


//Disabling f5
function disableF5(e) {
    if ((e.which || e.keyCode) == 116) e.preventDefault();
};


//Timer bar
function updateProgress(percentage) {
    var timer = document.getElementById("timer");
    timer.style.height = percentage + "%";
}

//Calculates the time taken for a question by subtracting the time when it is called
//(when the previous, next, bookmark or quickjump buttons are clicked) from the current time
//and rounding to an integer value. The time taken is appended in the global array 'results.'
function getIndivTimer() {
    var now = new Date();
    var timeTaken = Math.round((now.getTime() - indivTimer.getTime())/1000);
    results[currentQuestionNumber].time += timeTaken;
}

//This function animates the timer bar by percentage. If the end is reached, the finish button click
//is simulated to force an end to the test.
function animateUpdate() {
    var now = new Date();
    var timeDiff = now.getTime() - start.getTime();
    var perc = Math.round((timeDiff / maxTime) * 100);
    console.log(perc);
    if (perc <= 100) {
        updateProgress(perc);
        setTimeout(animateUpdate, timeoutVal);
    }
    else {
        var finishButton = document.getElementById("btnFinished");
        finishButton.click();
    }
}

//This function appends and populates a modal alert box.
function alertBox(message, alertd, messaged) {
    var alertDiv = document.getElementById(alertd);
    var messageDiv = document.getElementById(messaged);
    messageDiv.appendChild(document.createTextNode(message));
    alertDiv.appendChild(messageDiv);
    document.location.hash = "#" + alertd;
}

//This function displays the rotating panda egg when the easter egg is discovered.
function pandaGo() {
    var pandaDiv = document.getElementById("pandaDiv");
    var pandaImg = document.createElement("img");
    pandaImg.setAttribute("id", "panda");
    pandaImg.setAttribute("src", "images/PandaEgg.gif");
    pandaImg.setAttribute("style", "position: relative; left: 265px; border-radius:100px;");
    pandaDiv.appendChild(pandaImg);
    document.location.hash = "#pandaDiv";

    var $roundand = $('#panda'), degree = 0, timer;
    function rotate() {
        $roundand.css({ transform: 'rotate(' + degree + 'deg)' });
        timer = setTimeout(function () {++degree; rotate();});
    }
    rotate();

    $("#panda").animate({ left: "+=500" }, 5000, function () {
        $("#panda").css("display", "none");
    });
    document.location.href = "#close";
}

//This function sends the results of a test to the database via an asynchronous call of the
//'spWriteScores' procedure from the QuizService web service. 
function sendResults(user, score, totTime, scoreBit) {
    var category = quiz[0].CatName;
    $.ajax({
        type: "POST",
        url: "/QuizService.asmx/recordScores",
        contentType: "application/json",
        data: JSON.stringify({ "user": user, "category": category, "score": score, "totalTime": totTime, "scoreBit": scoreBit}),
        success: function (data) {
            return true;
        },
        error: function (error) {
            alert(error.responseText);
            return false;
        }
    });
}

//This function sends the individual times of each question to the database for recalculating the
//'difficulty' of each question via an asychronous call of the procedure 'spUpdateDefaultTimes'
//from the web method 'updateTimes' in the QuizService service.
function setNewTimes() {
    for (var i = 0; i < quiz.length; i++) {
        if (results[i].rightOrWrong == 1) {
            var id = quiz[i].QuestionID;
            var oldTime = quiz[i].QuestionRecTime;
            var newTime = Math.round((parseInt(quiz[i].QuestionRecTime) + parseInt(results[i].time)) / 2);
            $.ajax({
                type: "POST",
                url: "/QuizService.asmx/updateTimes",
                contentType: "application/json",
                data: JSON.stringify({ "questionID": id, "newTime": newTime }),
                success: function (data) {
                    return true;
                },
                error: function (error) {
                    alert(error.responseText);
                    return false;
                }
            });
        }
    }    
}
