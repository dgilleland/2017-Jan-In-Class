// TODO: Extend the functionality of this page by adding an event listener to the countDown
// button that will count down in the timer by 1 second per second and stop when the time
// is zero.

function addSecond() {
    var seconds = parseInt(document.getElementById('secOnes').innerHTML)
                + parseInt(document.getElementById('secTens').innerHTML) * 10;
    var minutes = parseInt(document.getElementById('minOnes').innerHTML)
                + parseInt(document.getElementById('minTens').innerHTML) * 10;
    // Update the "time"
    seconds++;
    if(seconds >= 60) {
        seconds = 00;
        minutes ++;
    }

    // Split the values to update the divs.
    document.getElementById('secOnes').innerHTML = seconds % 10;
    document.getElementById('secTens').innerHTML = Math.floor(seconds / 10) % 10;
    document.getElementById('minOnes').innerHTML = minutes % 10;
    document.getElementById('minTens').innerHTML = Math.floor(minutes / 10) % 10;
}

// global timer variable
var clockTimer;

// event handlers to start/stop the timer
document.getElementById('start').addEventListener('click', function(evt) {
    if(!clockTimer)
        clockTimer = setInterval(addSecond, 1000);
    //                            function,  milliseconds
});

document.getElementById('stop').addEventListener('click', function(evt) {
    clearInterval(clockTimer);
    clockTimer = null;
});