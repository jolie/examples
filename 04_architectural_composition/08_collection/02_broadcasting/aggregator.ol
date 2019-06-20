include "locations.iol"
include "printer.iol"
include "console.iol"
include "logger.iol"

execution { concurrent }

outputPort Printer1 {
Location: Location_Printer1
Protocol: sodep
Interfaces: PrinterInterface
}

outputPort Printer2 {
Location: Location_Printer2
Protocol: sodep
Interfaces: PrinterInterface
}

outputPort Logger {
Location: Location_Logger
Protocol: sodep
Interfaces: LoggerInterface
}

inputPort AggregatorInput {
Location: Location_Aggregator
Protocol: sodep
/* here the aggregation exploits collection for grouping Priter1 and Printer2 */
Aggregates: { Printer1, Printer2 }
RequestResponse:
	dummy
}

courier AggregatorInput {
	[ interface PrinterInterface( request ) ] {
				forward Printer1( request ) | forward Printer2( request )
	}

}

init
{
	println@Console( "Aggregator started" )()
}

main
{
	dummy()() {
		nullProcess
	}
}
