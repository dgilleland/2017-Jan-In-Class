// your js here...
// index position   0                1               2
var images = ['mountain1.jpg', 'mountain2.jpg', 'mountain3.jpg'];
// images.length => 3
var currentImg = 0;

// Get the first element of our array as the "default" image to show
document.querySelector('.carousel>img').src = 'images/' + images[currentImg];

// Click events on the prev and next <span> elements
document.querySelector('.carousel').addEventListener('click', function(evt) {
    var target = evt.target; // i.e. - the thing that was clicked
    if(target.classList.contains('control')) {
        if(target.classList.contains('next')) {
            // move to the next index in the array
            currentImg += 1;
        } else if (target.classList.contains('prev')) {
            // move to the previous index in the array
            currentImg -= 1;
        }
        // Here's a one-liner to ensure we don't go outside the array bounds
        // currentImg = Math.abs(currentImg) % images.length;
        // Here's a better one-liner to ensure we don't go outside the array bounds
        // using a *ternary expression*
        currentImg = currentImg < 0
                     ?  // if (currentImg < 0)
                     images.length + currentImg   // value if true
                     :  // else
                     Math.abs(currentImg) % images.length; // value if false

        // display the new currentImg
        document.querySelector('.carousel>img').src = 
            'images/' + images[currentImg];
        // console.log('control %cclick%ced...', 
        //             'color: green;font-size:larger',
        //             'font-size:inherit');
    }
});