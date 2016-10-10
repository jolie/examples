include "locations.iol"
include "fax.iol"
include "printer.iol"

type PrintRequest_Auth:void {
	.job:int
	.content:string
	.key:string
}

type DelRequest_Auth:int {
	.key:string
}

interface ExtendedPrinterInterface {
OneWay:
	print(PrintRequest_Auth),
	del(DelRequest_Auth)
RequestResponse:
	get_key(string)(string)
}


outputPort Aggregator {
Location: Location_Aggregator
Interfaces: ExtendedPrinterInterface, FaxInterface
Protocol: sodep
}

main
{
	request.content = "Hello, Printer!";

	get_key@Aggregator( "username1" )( request.key );
	request.job = 1;
	print@Aggregator( request );

	get_key@Aggregator( "username2" )( request.key );
	request.job = 2;
	print@Aggregator( request );

	request.key = "Invalid";
	request.job = 3;
	print@Aggregator( request );

	faxRequest.destination = "123456789";
	faxRequest.content = "Hello, Fax!";
	fax@Aggregator( faxRequest )
}