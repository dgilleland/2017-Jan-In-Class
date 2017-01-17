/* Practice with Functions and HTML Content */
// To test these functions in the browser, open the DevTools
// and call the function from the console.

// 1) Create a function that will prompt the user for some text and then place that text inside the <pre> tag of the figure with the ID of "sample".
//    (Be sure to select the target element in a way that identifies all aspects of the query: figure, ID, and pre)
function displayText() {
  var text = prompt('Enter some text:');
  var target = document.querySelector('figure#sample pre');
  target.innerHTML = text;
}

// 2) Create a function that will change the background color of the pre tag to "aqua".
//    (You will need to use the .setAttribute() method to set the style.)
function aquaBackground() {
  // This target variable is not the same one as the one inside of displayText()
  var target = document.querySelector('pre');
  target.setAttribute('style', 'background-color: aqua;');
}

// 3) Create a function that will clear the background color of the pre tag (remove the style attribute).
function clearBackground() {
  var target = document.querySelector('pre');
  target.setAttribute('style', ''); // Clear the background color by removing the style
}

// 4) Create a function that can be used to add the class 'col-reverse' to the body
//    (You will need to research which element method you will have to use to set the class.)
//    Call the function in the following way: changeMainClass('col-reverse')
function changeMainClass(className) {
  var docBodies = document.getElementsByTagName('body'); // return an ARRAY of elements
  var theBody = docBodies[0]; // Assume that there is only one body, and take the first one
  theBody.className = className;
  // /\      /\          /\
  // ||      ||           |- is the parameter variable
  // ||       |- the property of theBody element object
  //  |- the instance of the body element in the DOM (Document Object Model)
}

// 5) Create a function that will select all the paragraphs of the main element and return a count of the number of paragraphs.
function countParagraphs() {
  // Notice how with an element we can use the selection functions to search the children
  // of any element
  var mainElement = document.querySelector('main');
  var allParas = mainElement.getElementsByTagName('p');
  return allParas.length; // the .length property of any array/collection returns a count  
}

// 6) Create a function that will select the first paragraph of the main element and return the number of words in that paragraph.
function countWords() {
  var first = document.querySelector('main p');
  var words = first.innerText.split(' '); // Break the paragraph into text
  return words.length;
}
