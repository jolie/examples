include "printer.iol"
include "fax.iol"

type FaxAndPrintRequest: void {
	.fax: FaxRequest
	.print: PrintRequest
}

interface AggregatorInterface {
	RequestResponse:
		faxAndPrint( FaxAndPrintRequest )( void ) throws Aborted
}
