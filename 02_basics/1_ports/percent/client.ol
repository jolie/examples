include "console.iol"
include "percentInterface.iol"

/* the outputPort deefines an invoking endpoint connected with the inputPort of the receiving service */
outputPort PercService {
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: PercentInterface
}

/* the define statement allows for the definition of macros */
define valid_request {
	request.total = 10;
	request.part = 3
}

define typeMismatch_request {
	request.total = 10.0;
	request.part = 3
}

main{
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
		);
	//valid_request;
	typeMismatch_request;
	/* here we are calling the server by using the outputPort PercService defined above */
	percent@PercService( request )( response );
	/* the call is blocked until the response message is received */
	println@Console( "\n"+"Percentage value: "+response.percent_value )()
}
