include "console.iol"
include "time.iol"
include "counterInterface.iol"
include "embedderInterface.iol"
include "clientInterface.iol"

include "runtime.iol"

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

execution{ concurrent }

main
{
	startNewCounter( location );
	CounterClient.location = location;
	println@Console( "New counter session started" )();

	embedInfo.type = "Jolie";
	embedInfo.filepath = "CounterService.ol";
	loadEmbeddedService@Runtime( embedInfo )( CounterService.location );
	start@CounterService();
	while( true ){
		inc@CounterService()( counterState );
		receiveCount@CounterClient( counterState );
		sleep@Time( 1000 )()
	}
}