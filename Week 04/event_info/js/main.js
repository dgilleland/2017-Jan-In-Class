function about(evt) {
  console.log(evt);
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
