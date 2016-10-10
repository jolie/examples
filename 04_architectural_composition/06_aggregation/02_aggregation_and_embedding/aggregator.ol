/* Aggregator */
include "printer.iol"
include "fax.iol"
include "aggregator.iol"

include "console.iol"

execution { concurrent }

/* this outputPort points to service Printer */
outputPort Printer {
Location: "socket://localhost:9000"
Protocol: sodep
Interfaces: PrinterInterface
}

/* this outputPort points to the service Fax */
outputPort Fax {
Location: "socket://localhost:9001"
Protocol: sodep
Interfaces: FaxInterface
}

/* here both the printer and the fax services are embedded into the aggregator */
embedded {
	Jolie:
		"printer.ol" in Printer,
		"fax.ol" in Fax
}

/* this is the inputPort of the Aggregation service */
inputPort Aggregator {
Location: "socket://localhost:9002"
Protocol: sodep
/* the service Aggregator does not only aggregates other services, but it also provides its own operations */
Interfaces: AggregatorInterface
/* Printer and Fax outputPorts are aggregated here. All the messages for their operations
   will be forwarded to them */
Aggregates: Printer, Fax
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
