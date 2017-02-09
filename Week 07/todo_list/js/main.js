// Enter JavaScript for the exercise here...

// Add an event listener for the checkbox beside *Subject* so that we can toggle
// the other checkboxes in the table
// var   - declare a variable
// const - declare a variable whose value I don't expect to change
// let   - declare a variable whose value I DO expect to change
const subject = document.querySelector('[name=toggle]'); // Square brackets are for attributes
const checks = document.querySelectorAll('[name=message]'); // gets an Array

subject.addEventListener('change', // change event - contents of input have changed
  function(evt) { // Anonymous function - no name, and it's just "inlined"
    // Get all of the checkboxes that have the name "message" and toggle them
    var index = 0; // first position of the Array
    // loop through the array with a while statement
    while(index < checks.length) {
      // Version 1) - Set all checkboxes to match the checked state of the Subject
/*    if (evt.target.checked) { // evt.target is the Subject's checkbox; this.checked
        checks[index].checked = true;
      } else {
        checks[index].checked = false;
      }
*/
      checks[index].checked = this.checked;      

      // Increment my index
      index = index + 1;
    }
});


// Here's some extra code to handle the new button on the form for inverting
// the checkbox states.
const invert = document.querySelector('[name=invert]');

invert
  .addEventListener('click',
                    evt => 
                      checks.forEach(element => 
                                       element.checked = !element.checked));
/*
=> is called an "Arrow Function" (aka "fat arrow" functions)
              function(evt){
                checks.forEach(function(element) {
                  element.checked = !element.checked;
              })}
*/