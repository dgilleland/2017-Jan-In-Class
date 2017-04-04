// Create a variable to reference the XMLHttpRequest object
var xhr = new XMLHttpRequest();

// This function is the "handler" for when the resource is loaded
function handleResponse() {
	console.log(xhr.responseText);
}

// This function performs a resource request using our xhr object
function sendRequest(url) {
	url = url || 'plaind.txt'; // 404 - not found
	// .open() setup up the information needed to establish the connection to the server
	xhr.open('GET', url, true);
	// .addEventListener hooks up our handler
	xhr.addEventListener('load', handleResponse);
	// .send() actually starts the whole request process
	xhr.send(null);
}

// call sendRequest from the console...