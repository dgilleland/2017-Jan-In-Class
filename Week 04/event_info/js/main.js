function about(evt) {
  console.log(evt);
  // TODO: Learn about the event object (type, target, srcElement, etc.)

  // TODO: Learn about the this keyword
  console.log(this);
}

function pageReady() {

  var images = document.getElementsByTagName('img');
  for (var i = 0; i < images.length; i++) {
    if (images[i].parentElement.parentElement.tagName === 'HEADER') {
      images[i].addEventListener('click', about);
    }
  }
}

document.onreadystatechange = function () {
  if (document.readyState === 'complete') {
    // DOM is ready!
    pageReady();
  }
};
