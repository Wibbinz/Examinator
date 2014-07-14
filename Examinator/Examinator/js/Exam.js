var quiz;
var wrongAnswers;
var correctAnswer;
var currentQuestionNumber;

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
    $(eToFade).fadeOut(1000, function () {
        $(eNext).fadeIn(1000);
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
    popQuestionAnswerParas(currentQuestionNumber);
}

function popQuestionAnswerParas(index) {    
    var question = document.getElementById("testQuestion");
    question.textContent = quiz[index].QuestionTxt;
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



function getPrevious() {
    if (currentQuestionNumber != 0) {
        currentQuestionNumber -= 1;
        popQuestionAnswerParas(currentQuestionNumber);
    }
}

function getNext() {
    if (currentQuestionNumber != quiz.length) {
        currentQuestionNumber += 1;
        popQuestionAnswerParas(currentQuestionNumber);
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


