// Here are a few functions to demonstrate aspects of function parameters
// and aspects of manipulating strings

var target = document.getElementById('display'); // to get the <pre> tag

function concatText(first, second) {
    // TODO...
    var result = first + second;
    target.innerHTML = result;
}

function repeatText(text, count) {
    // TODO...
    var message = "";
    while(count > 0){
        message += text;
        count--; // DOH! don't forget this!
    }
    target.innerHTML = message;
}

function breakApart(text) {
    // TODO...
    var result = text.split(' ');
    var output = '';
    for(var index = 0; index < result.length; index++) {
        output = output + result[index] + '\n';
    }
    target.innerHTML = output;
    return output;
}

