include "regInterface.iol"
include "console.iol"

outputPort Register {
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: RegInterface
}

main
{
	{
		register@Register()( response1 );
		println@Console( response1.message )()
	}
	|
	{
		register@Register()( response2 );
		println@Console( response2.message )()
	}
	|
	{
		register@Register()( response3 );
		println@Console( response3.message )()
	}
	|
	{
		register@Register()( response4 );
		println@Console( response4.message )()
	}
	|
	{
		register@Register()( response5 );
		println@Console( response5.message )()
	}
}
