// This is a single-line comment for functions_intro.js
// JavaScript is an interpreted language
// var greetUser; 

console.log('Loaded the functions_intro.js'); // Please, please use semicolons!

// make a function call - invokes the function
greetUser();

// This is a function declaration
// The following is also referred to as a
// named function.
// JavaScript will "hoist" named functions
// as though they were created at the top;
function greetUser() {
  // Prompt the user for a name
  var name = prompt('What is your name?');
  var heading = document.querySelector('h2.intro');
  heading.innerHTML = 'Welcome to the ' + heading.innerHTML + ' <small>Hi ' + name + '!</small>';
}

function alertUser() {
  var heading = document.querySelector('h1');
  // The .createElement() method creates a new DOM element
  var scrpt = document.createElement('script');
  scrpt.innerHTML = 'alert("No, really, you are infected!")';

  // The .appendChild() method will add a DOM object to the 
  // end of the child nodes of the heading.
  heading.appendChild(scrpt);
}

alertUser(); // temp