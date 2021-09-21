from RegisterInterface import RegisterInterface
from console import Console 

service Client {

	embed Console as Console

	outputPort Register {
		location: "socket://localhost:2000"
		protocol: sodep
		interfaces: RegisterInterface
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
}
