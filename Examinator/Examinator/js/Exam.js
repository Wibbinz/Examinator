var quiz;
var wrongAnswers;
var correctAnswer;
var correctAnsweri;
var currentQuestionNumber;
var start;
var maxTime;
var timeoutVal;
var indivTimer;
var results = [];

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


function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}


function fadeToNext(eToFade, eNext) {
    $(eToFade).fadeOut(250, function () {
        $(eNext).fadeIn(250);
    });
}

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
    sendResults(user, totScore, totTime, scoreBit);
    setNewTimes();
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


//disabling f5
function disableF5(e) {
    if ((e.which || e.keyCode) == 116) e.preventDefault();
};


//timer
function updateProgress(percentage) {
    var timer = document.getElementById("timer");
    timer.style.height = percentage + "%";
}

function getIndivTimer() {
    var now = new Date();
    var timeTaken = Math.round((now.getTime() - indivTimer.getTime())/1000);
    results[currentQuestionNumber].time += timeTaken;
}


function animateUpdate() {
    var now = new Date();
    var timeDiff = now.getTime() - start.getTime();
    var perc = Math.round((timeDiff / maxTime) * 100);
    console.log(perc);
    if (perc <= 100) {
        updateProgress(perc);
        setTimeout(animateUpdate, timeoutVal);
    }
}

function alertBox(message, alertd, messaged) {
    var alertDiv = document.getElementById(alertd);
    var messageDiv = document.getElementById(messaged);
    messageDiv.appendChild(document.createTextNode(message));
    alertDiv.appendChild(messageDiv);
    document.location.hash = "#" + alertd;
}

function pandaGo() {
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


function sendResults(user, score, totTime, scoreBit) {
    var category = quiz[1].CatName;
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
