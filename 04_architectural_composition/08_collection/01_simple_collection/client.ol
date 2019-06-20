include "locations.iol"
include "printer.iol"

outputPort Aggregator {
Location: Location_Aggregator
Protocol: sodep
Interfaces: PrinterInterface
}

main
{
	request.content = "Hello, Printer!";
	for( i = 0, i < 10, i++ ) {
			request.job = i;
			print@Aggregator( request )
	}
}
