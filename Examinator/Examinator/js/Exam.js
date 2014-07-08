
function populateDivs(category, index) {
    var newCategory = document.createElement('li');
    newCategory.setAttribute('class', 'catDiv');
    newCategory.setAttribute('id', 'number' + index);    
    var color = getRandomColor();
    newCategory.setAttribute('style', 'background-color:'+color);
    var catName = document.createTextNode(category);
    newCategory.appendChild(catName);
    var catStrip = document.getElementById("catStrip");
    catStrip.appendChild(newCategory);
}


function getRandomColor() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}