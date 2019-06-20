include "locations.iol"
include "printer.iol"
include "console.iol"

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
		/* depending on the key the message will be forwared to Printer1 or Printer2 */
		println@Console( ">>" + global.printer_counter )();
		if ( (global.printer_counter % 2) == 0 ) {
				forward Printer1( request )
		} else {
				forward Printer2( request )
		}
		;
		synchronized( printer_count_write ) {
				global.printer_counter++
		}
	}

}

init
{
	global.printer_counter = 0;
	println@Console( "Aggregator started" )()
}

main
{
	dummy()() {
		nullProcess
	}
}
