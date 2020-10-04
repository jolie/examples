
include "GuessInterface.iol"
include "console.iol"

execution{ concurrent }

inputPort Guess {
	Protocol: sodep
	Location: "socket://localhost:2000"
	Interfaces: GuessInterface
}

init {
	secret = int(args[0]);
  install( FaultMain =>
		println@Console( "A wrong number has been sent!" )()
	);
  install( NumberException =>
    println@Console( "Wrong number sent!" )();
    throw( FaultMain )
  )
}

main
{
  	guess( number )( response ){
    		if ( number == secret ) {
    			println@Console( "Number guessed!" )();
    			response = "You won!"
    		} else {
    			with( exceptionMessage ){
      				.number = number;
      				.exceptionMessage = "Wrong number, better luck next time!"
    			};
					/* here the throw also attach the exceptionMessage variable to the fault */
    			throw( NumberException, exceptionMessage )
    		}
  	}
}
