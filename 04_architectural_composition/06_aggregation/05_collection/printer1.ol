include "locations.iol"
include "printer.iol"
include "console.iol"

execution { concurrent }

inputPort PrinterInput {
Location: Location_Printer1
Protocol: sodep
Interfaces: PrinterInterface
}

main
{
	[ print( request ) ] {
		println@Console( "Printing job id: " + request.job + ". Content: " + request.content )()
	}
	[ del( request ) ] {
		println@Console( "Deleting job id: " + request.job )()
	}
}