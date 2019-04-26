/* Aggregator */
include "printer.iol"
include "fax.iol"
include "aggregator.iol"
include "logger.iol"

include "console.iol"
include "string_utils.iol"
include "locations.iol"

execution { concurrent }

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

/* this is the inputPort of the Aggregation service */
inputPort Aggregator {
Location: Location_Aggregator
Protocol: sodep
/* the service Aggregator does not only aggregates other services, but it also provides its own operations */
Interfaces: AggregatorInterface
/* Printer and Fax outputPorts are aggregated here. All the messages for their operations
   will be forwarded to them */
Aggregates: Printer, Fax
}

courier Aggregator {
	[ interface PrinterInterface( request )( response ) ] {
		valueToPrettyString@StringUtils( request )( s );
		log@Logger( { .content = s } );
		forward( request )( response )
	}

  [ interface PrinterInterface( request ) ] {
		valueToPrettyString@StringUtils( request )( s );
		log@Logger( { .content = s }  );
		forward( request )
	}
}

courier Aggregator {
	[ interface FaxInterface( request )( response ) ] {
		valueToPrettyString@StringUtils( request )( s );
		log@Logger( { .content = s }  );
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
