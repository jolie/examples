from .FaxInterface import FaxRequest
from .PrinterInterface import PrintRequest

type FaxAndPrintRequest: void {
	.fax: FaxRequest
	.print: PrintRequest
}

interface AggregatorInterface {
	RequestResponse:
		faxAndPrint( FaxAndPrintRequest )( void ) throws Aborted
}
