

function twice( request )
{
  /* the subnode number is automatically used as a subnode of the object request */
	return parseInt( request.number + request.number )
}
