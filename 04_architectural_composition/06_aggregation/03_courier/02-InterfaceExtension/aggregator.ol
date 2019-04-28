/* Aggregator */
include "printer.iol"
include "fax.iol"
include "aggregator.iol"
include "logger.iol"
include "authenticator.iol"

include "console.iol"
include "string_utils.iol"
include "locations.iol"

execution { concurrent }

type AuthenticationData: void {
    .key:string
}

/* this is an interface extender which extends all the RequestResponse of a given interface with
   type AuthenticationData in case of request message, no types in case of response messages
   and, finally, it adds fault KeyNotValid */
interface extender AuthInterfaceExtender {
	RequestResponse:
	    *( AuthenticationData )( void ) throws KeyNotValid
  OneWay:
      *( AuthenticationData )
}


/* this outputPort points to service Printer */
outputPort Printer {
  Location: Location_Printer
  Protocol: sodep
  Interfaces: PrinterInterface
}

/* this outputPort points to the service Fax */
outputPort Fax {
  Location: Location_Fax
  Protocol: sodep
  Interfaces: FaxInterface
}

outputPort Logger {
	Location: Location_Logger
	Protocol: sodep
	Interfaces: LoggerInterface
}

outputPort Authenticator {
	Location: Location_Authenticator
	Protocol: sodep
	Interfaces: AuthenticatorInterface
}


/* this is the inputPort of the Aggregation service */
inputPort Aggregator {
  Location: Location_Aggregator
  Protocol: sodep
  Interfaces: AggregatorInterface
  Aggregates: Fax with AuthInterfaceExtender, Printer with AuthInterfaceExtender
}

courier Aggregator {
	[ interface PrinterInterface( request )( response ) ] {
		valueToPrettyString@StringUtils( request )( s );
		log@Logger( { .content = s } );
    checkKey@Authenticator( { .key = request.key } )();
		forward( request )( response )
	}

  [ interface PrinterInterface( request ) ] {
		valueToPrettyString@StringUtils( request )( s );
		log@Logger( { .content = s }  );
    checkKey@Authenticator( { .key = request.key } )();
		forward( request )
	}
}

courier Aggregator {
	[ interface FaxInterface( request )( response ) ] {
		valueToPrettyString@StringUtils( request )( s );
		log@Logger( { .content = s }  );
    checkKey@Authenticator( { .key = request.key } )();
		forward( request )( response )
	}
}

init
{
	println@Console( "Aggregator started" )();
	install( Aborted => nullProcess )
}

main
{
	/* this is the implementation of the operation declared in interface AggregatorInterface.
	   the operation implements a composed invocation of the operations of Printer and Fax
	*/
	faxAndPrint( request )( response ) {
		  scope( fax_and_print ) {
					install( IOException => comp( print ); throw( Aborted ) );
					{

							scope( fax ) {
									println@Console("Faxing document to " + request.fax.destination )();
									fax@Fax( request.fax )()
							}
							|
							scope( print ) {
									println@Console("Printing document " + request.print.content )();
									print@Printer( request.print )( del_request )
									[
												/* termination handler installed after the request message is sent */
												this => del@Printer( del_request );
												println@Console("Rolling back printing..." )();
									 			println@Console("Deleted job " + del_request.jobId )()
									]
							}
					}
			}

	}
}
