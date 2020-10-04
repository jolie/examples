include "console.iol"
include "time.iol"
include "counterInterface.iol"
include "embedderInterface.iol"
include "clientInterface.iol"

outputPort CounterService{
	Interfaces: CounterInterface
}

inputPort CounterEmbedder{
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: CounterEmbedderInterface
}

outputPort CounterClient{
	Protocol: sodep
	Interfaces: CounterClientInterface
}

/* only one instance of the counter will be embedded and it will be equally available from all the
service sessions */
embedded {
	Jolie: "CounterService.ol" in CounterService
}

execution{ concurrent }

main
{
	startNewCounter( location );
	CounterClient.location = location;
	println@Console( "New counter session started" )();
	while( true ){
		/* always the same instance of the CounterService will reply to this request
		   as a result the counter will be share among all the active sessions
		*/
		inc@CounterService()( counterState );
		receiveCount@CounterClient( counterState );
		sleep@Time( 1000 )()
	}
}
