/*
  Add the required JavaScript to handle form submit and add a new todo item to 
  the page (in the div.todo-list element).  You will need to use a counter to 
  uniquely identify each todo item and use only DOM API functions to interact
  with the document (i.e. create each todo item), DO NOT use innerHTML for this
  exercise.
*/

// required vars
var todos = document.querySelector('.todo-list');
var todoCount = 0;
var dn = '\u21e9'; // Unicode value of down arrow
var up = '\u21e7'; // Unicode value of up arrow

// todo form submit handler, adds a new todo item to the 'list'
document.querySelector('.todo-frm').addEventListener('submit', function (evt) {
	
	var div,
		checkbox,
		label,
		labelText,
		todoText,
		spanUp,
		spanDown;

	todoText = evt.target.elements['todo-item'].value;

	// adding a todo regardless, so might as well increment now...
	todoCount += 1;
	
	if (todoText === '') {
		todoText = 'Todo ' + (todoCount);
	}

	// create required elements
	div = document.createElement('div');
	checkbox = document.createElement('input');
	label = document.createElement('label');
	labelText = document.createTextNode(todoText);
	spanUp = document.createElement('span');
	var upText = document.createTextNode(up);
	spanDown = document.createElement('span');
	var downText = document.createTextNode(dn);

	// set appropriate attributes
	spanUp.classList.add('arrow', 'up');
	spanDown.classList.add('arrow', 'dn');
	checkbox.setAttribute('type', 'checkbox');
	checkbox.setAttribute('id', 'todo-' + todoCount);
	label.setAttribute('for', 'todo-' + todoCount);
	label.setAttribute('contenteditable', '');

	// build document fragment
	label.appendChild(labelText);
	spanDown.appendChild(downText);
	spanUp.appendChild(upText);
	div.appendChild(checkbox);
	div.appendChild(label);
	div.appendChild(spanDown);
	div.appendChild(spanUp);

	// add the document fragment to the document for rendering
	todos.appendChild(div);

	// clear the form
	evt.target.reset();

	evt.preventDefault();
});


todos.addEventListener('click', function(evt) {
	// Get references to parents and siblings
	var targetTodo = evt.target.parentNode;
	var todoList = targetTodo.parentNode;
	var siblingTodo;

	// check for click on an arrow
	if(evt.target.classList.contains('arrow')) {
		// identify which arrow (up or down)
		if(evt.target.classList.contains('dn')) {
			console.log(evt.target.parentNode +  'down...');
			// find the next element
			siblingTodo = targetTodo.nextElementSibling;
			// move the target below that element
			todoList.insertBefore(siblingTodo, targetTodo);
		} else if (evt.target.classList.contains('up')) {
			console.log('up...');
			siblingTodo = targetTodo.previousElementSibling;
			todoList.insertBefore(targetTodo, siblingTodo);
		}
	}
});