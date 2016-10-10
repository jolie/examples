include "console.iol"
include "GuessInterface.iol"

outputPort Guess {
	Protocol: sodep
	Location: "socket://localhost:2000"
	Interfaces: GuessInterface
}

main
{
	install( NumberException=>
		println@Console( main.NumberException.exceptionMessage )()
	);
	guess@Guess( args[0] )( response );
	println@Console( response )()
}
