var quiz;
var wrongAnswers;
var correctAnswer;
var correctAnsweri;
var currentQuestionNumber;
var start;
var maxTime;
var timeoutVal;

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

function getQuiz(chosenCategory, chosenMode, chosenDifficulty) {    
    $.ajax({
        type: "POST",
        url: "/QuizService.asmx/getTest",
        contentType: "application/json",
        data: JSON.stringify({ "category": chosenCategory, "mode": chosenMode, "difficulty": chosenDifficulty }),
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
    var question = document.getElementById("testQuestion");
    question.innerHTML = "Question #" + (index + 1) + ":<br><br>" + quiz[index].QuestionTxt;
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
            //alert('currentindex:' + currentIndex + ', waI: ' + waI);
            if (waI == 'Answer1') {
                answer.textContent = quiz[index].Answer1;
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer2') {
                answer.textContent = quiz[index].Answer2;
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer3') {
                answer.textContent = quiz[index].Answer3;
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer4') {
                answer.textContent = quiz[index].Answer4;
                wrongAnswerIndex += 1;
            }
            else if (waI == 'Answer5') {
                answer.textContent = quiz[index].Answer5;
                wrongAnswerIndex += 1;
            }
            //alert('currentindex:' + currentIndex + ', waI: ' + waI);
        }
        else {
            //alert("i am a beaw" + currentIndex + correctAnsweri);            
            var answer = document.getElementById(correctAnswerIndex);
            answer.textContent = quiz[index].AnswerCorrect;
        }
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


function answerChosen(chosenIndex) {
    var pd = 'quest' + (currentQuestionNumber+1);
    var progDiv = document.getElementById(pd);
    progDiv.style.background = '#4AA85D';
    getNext();
    //alert("CorrectAnswerIndex: "+correctAnsweri+" ChosenIndex: "+ ci);
}


function bookmarkQuestion() {
    var pd = 'quest' + (currentQuestionNumber + 1);
    var progDiv = document.getElementById(pd);
    progDiv.style.background = '#39A2B3';
    getNext();
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


//disabling f5
function disableF5(e) {
    if ((e.which || e.keyCode) == 116) e.preventDefault();
};


//timer
function updateProgress(percentage) {
    var timer = document.getElementById("timer");
    timer.style.height = percentage + "%";
    //$('#timer').css("height", percentage + "%");
    //            $('#pbar_innertext').text(percentage + "%");
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
