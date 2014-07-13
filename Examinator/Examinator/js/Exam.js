var quiz;


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
    var question = document.getElementById("testQuestion");    
    question.textContent = quizQuestions[1].QuestionTxt;
    var wrongAnswer = getRandomAnswer();
    quiz = quizQuestions;
}

function getPrevious() {
    alert(quiz[8].QuestionTxt);
}


function getRandomAnswer() {
    var answerSet = ['Answer1', 'Answer2', 'Answer3', 'Answer4', 'Answer5'];
    var currentIndex = answerSet.length, temporaryValue, randomIndex;
    while (0 !== currentIndex) {
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;
        temporaryValue = answerSet[currentIndex];
        answerSet[currentIndex] = answerSet[randomIndex];
        answerSet[randomIndex] = temporaryValue;
    }
    var wrongAnswer = answerSet.slice(0, 2);
    return wrongAnswer;
}