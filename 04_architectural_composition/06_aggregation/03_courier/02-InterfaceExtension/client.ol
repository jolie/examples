include "locations.iol"
include "console.iol"
include "AggregatorSurface.iol"
include "authenticator.iol"

outputPort Authenticator {
	Location: Location_Authenticator
	Protocol: sodep
	Interfaces: AuthenticatorInterface
}

outputPort Aggregator {
	Location: Location_Aggregator
	Protocol: sodep
	Interfaces: AggregatorSurface
}

main
{
	/* get a valid key */
	with( auth_req.credentials ) {
		.username="client";
		.password="client_password"
	};
	getKey@Authenticator( auth_req )( auth_response );

	/* here we call the operation of the service Printer */
	println@Console("single call to print...")();
	printRequest.content = "Hello, Printer!";
	printRequest.key = auth_response.key;
	print@Aggregator( printRequest )( jobid );
	println@Console("Printed jobid " + jobid )();

	/* here we call the operation of the service Fax */
	scope( fax ) {
		faxRequest.destination = "123456789";
		faxRequest.content = "Hello, Fax!";
		faxRequest.key = auth_response.key;
		println@Console("Faxing document...")();
		fax@Aggregator( faxRequest )();
		println@Console("Done!")()
	};

	/* here we call the operation of the service aggregator.ol */
	scope( print_and_fax ) {
		install( Aborted => println@Console("Aborted")() );
		agg_req.print.content = "Hello, Printer!";
		agg_req.fax.destination = "123456789";
		agg_req.fax.content = "Hello, Fax!";
		println@Console("Faxing and Printing...")();
		faxAndPrint@Aggregator( agg_req )();
		println@Console("OK! ...now retry by deactivating the fax service")()
	}
}
