include "console.iol"

type TwiceRequest:void {
	.number: double
}

/* this is the interface which we use for sending messages to the javascsript function */
interface TwiceInterface {
RequestResponse:
	twice( TwiceRequest )( double )
}

outputPort TwiceService {
Interfaces: TwiceInterface
}

/* here we embed the javascript file as it happens for jolie files */
embedded {
JavaScript:
	"twice_service.js" in TwiceService
}

main
{
	request.number = 5;
	twice@TwiceService( request )( response );
	println@Console( "Javascript 'twice' Service response: " + response )()
}
