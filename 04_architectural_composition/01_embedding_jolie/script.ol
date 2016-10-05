include "console.iol"
include "twiceInterface.iol"

/* this is the outputPort we will use for comminicationg with the embedded service */
outputPort TwiceService {
	Interfaces: TwiceInterface
}

/* here we embed the service in the file twice_service.ol and we bind it to the outputPort TwiceService */
embedded {
	Jolie: "twice_service.ol" in TwiceService
}

main
{
	/* here we are calling the embedded service */
	twice@TwiceService( 5 )( response );
	println@Console( response )()
}
