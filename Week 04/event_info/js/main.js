// This function is a generic function to just output the event information and
// information about the object that is "holding" the function (this keyword).
function about(evt) {
  console.log(evt);
  // TODO: Learn about the event object (type, target, srcElement, etc.)

  // TODO: Learn about the this keyword
  console.log(this);
}

function pageReady() {
  // All images in the <header> will call the about() function for the click event
  var images = document.getElementsByTagName('img');
  for (var i = 0; i < images.length; i++) {
    if (images[i].parentElement.parentElement.tagName === 'HEADER') {
      images[i].addEventListener('click', about);
    }
  }

  var hdr = document.querySelector('header');
  hdr.addEventListener('click', about);
}

// document.onreadystatechange = function () {
//   if (document.readyState === 'complete') {
//     // DOM is ready!
//     pageReady();
//   }
// };

window.onload = pageReady;
