// Enter JavaScript for the exercise here...
document.forms[0].addEventListener('submit', formEventHandler);

function formEventHandler(evt) {
  var description, type, number;
  description = document.forms[0].description.value;
  type = document.forms[0].type.value;
  number = document.forms[0].currency.value;


  // TODO: Show error message
  
  // Add a row of data
  /*
<tr class="debit">
					<td>Tim Horton's</td>
					<td>debit</td>
					<td class="amount">$1.89</td>
					<td class="tools">
						<i class="delete fa fa-trash-o"></i>
					</td>
				</tr>
  */
  var el = document.createElement('tr');
  el.classList.add(type);
  // Description
  var td = document.createElement('td');
  td.appendChild(document.createTextNode(description));
  el.appendChild(td);
  // Type
  td = document.createElement('td');
  td.appendChild(document.createTextNode(type));
  el.appendChild(td);
  // Amount
  td = document.createElement('td');
  td.classList.add('amount');
  td.appendChild(document.createTextNode(number));
  el.appendChild(td);
  // Trash icon
  td = document.createElement('td');
  td.classList.add('tools');
  var italic = document.createElement('i');
  italic.classList.add('delete', 'fa', 'fa-trash-o');
  td.appendChild(italic);
  el.appendChild(td);

  // Add to tbody
  document.querySelector('tbody').appendChild(el);

  // Debit/Credit totals
  var span = document.querySelector('.total.' + type + 's');
  var amount = Number.parseFloat(span.childNodes[0].wholeText.replace('$','')) + Number.parseFloat(number);
  // console.log(amount);
  span.replaceChild(document.createTextNode('$' + amount), span.childNodes[0]);

  evt.preventDefault();
}