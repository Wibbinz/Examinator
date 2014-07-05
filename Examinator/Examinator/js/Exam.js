
function populateDivs(category) {
    var newCategory = document.createElement('div');
    newCategory.setAttribute('class', 'catDiv');
    var catName = document.createTextNode(category);
    newCategory.appendChild(catName);
    var catStrip = document.getElementById("catStrip");
    catStrip.appendChild(newCategory);
}
