// When the 'Add Tag' submit button is clicked, the p.feature.tags element should be 
// updated with the tag that was entered by the user.  Do not overwrite any existing tags,
// simply add each additional tag onto the already existing list.  A tag cannot be empty 
// (i.e. cannot be whitespace). If the user tries to add an empty tag, remove the hidden 
// class from the p.feature.error element.  If the form is submitted correctly, then ensure
// that the p.feature.error element is hidden.

document.querySelector('.feature.frm') // get the <form> tag with these classes
  .addEventListener('submit',          // forms respond to submit events
                    // Send in an anonymous function (a function without a name)
                    function(evt) { 
                        console.log('Form submitted...');

                        var frm = evt.target;  // <form> object/element
                        var tag = frm.elements.tag; // gets the element with a name of "tag", which will be the <input name="tag"> element
                        var error = document.querySelector('p.feature.error');

                        if(tag.value.trim() != '') {
                            // insert a '#' before the tag and show in the paragraph
                            document.querySelector('p.feature.tags').innerHTML += '#' + tag.value.trim();
                            // BTW, the <input> has a .value attribute that holds the
                            // text that was input by the user

                            // clear the input element's value....
                            tag.value = '';

                            // Show the user an error message
                            error.classList.add('hidden');
                        } else {
                            error.classList.remove('hidden');
                        }

                        // Good way to prevent the form from being submitted.
                        evt.preventDefault();
                    });