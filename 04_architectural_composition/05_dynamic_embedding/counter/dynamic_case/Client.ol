// Client.ol works with only one instance because of the hardcoded callback port (4002)

include "console.iol"
include "embedderInterface.iol"
include "clientInterface.iol"

interface CounterEmbedderInterface{
	OneWay: startNewCounter( string )
}

interface CounterClientInterface{
	OneWay: receiveCount( int )
}

inputPort CounterClient{
	Location: "socket://localhost:4002"
	Protocol: sodep
	Interfaces: CounterClientInterface
}

outputPort CounterEmbedder{
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: CounterEmbedderInterface
}

main
{
	location = global.inputPorts.CounterClient.location;
	startNewCounter@CounterEmbedder( location );
	while ( true ){
		receiveCount( count );
		println@Console( count )()
	}
}
