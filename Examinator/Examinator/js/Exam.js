
function populateDivs(category, index) {
    var catStrip = document.getElementById("catStrip");

    while (catStrip.firstChild) {
        catStrip.removeChild(catStrip.firstChild);
    }
    
    for (var i = index; i < index + 4; i++) {
        var newCategory = document.createElement('li');
        newCategory.setAttribute('class', 'catDiv');
        newCategory.setAttribute('id', 'number' + i);
        var color = getRandomColor();
        newCategory.setAttribute('style', 'background-color:' + color);

        if (i < category.length) {
            var catName = document.createTextNode(category[i]);
        }
        else {
            var catName = document.createTextNode(category[i - category.length]);
        }

        newCategory.appendChild(catName);       
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