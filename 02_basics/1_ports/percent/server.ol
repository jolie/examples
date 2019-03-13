include "console.iol"
include "percentInterface.iol"

/*
	this the inputPot where the server is listening for messages.
	The inputPort is listening on port 2000 of the localhost and it uses socket as a medium for communication
	The protocol is sodep which is an efficient Jolie custom protocol, see documentations for other protocols
	The PercentInterface is declared in file percentInterface.iol included above. All its operations are available
	   the inputPort PercService
*/
inputPort PercService {
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: PercentInterface
}

main{
	/* installing of the fault handler, see the related section in the documentation */
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	);

	/* here we implement the operation percent declared in the interface */
	percent( request )( response ){
		/* the variable request contains the request message */
		response.percent_value = double( request.part )/request.total
		/* the variable response contains the response message to send */
	}
}
