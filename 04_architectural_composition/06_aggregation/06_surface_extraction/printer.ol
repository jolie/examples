include "locations.iol"
include "printer.iol"
include "console.iol"

execution { concurrent }

inputPort PrinterInput {
Location: Location_Printer
Protocol: sodep
Interfaces: PrinterInterface
}

main
{
	[ print( request )( response ) {
		jobId = new;
		println@Console( "Printing job id: " + jobId + ". Content: " + request.content )();
		response.jobId = jobId
	}]

	[ del( request ) ] {
		println@Console( "Deleting job id: " + request.jobId )()
	}
}
