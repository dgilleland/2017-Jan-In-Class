// Function to log out the name of the element that is handling the event
// along with the name of the event that is being handled
function logThis(evt) {
    console.log('A "' + evt.type + 
                '" event happened in the ' + evt.target.nodeName + 
                ' and is handled by the ' + this.nodeName);
    if(this.nodeName === 'FORM' && evt.type === 'submit') {
        evt.preventDefault();
    }
}

document.querySelector('body').addEventListener('click', logThis);
// To see event bubbling (propegation), we'll add the same function to listen to other elements in the page.
document.querySelector('form').addEventListener('click', logThis);
document.querySelector('form').addEventListener('submit', logThis);
document.querySelector('input[type=button]').addEventListener('click', logThis);
document.querySelector('input[type=reset]').addEventListener('click', logThis);
document.querySelector('input[type=submit]').addEventListener('click', logThis);
document.querySelector('form').addEventListener('click', logThis);

