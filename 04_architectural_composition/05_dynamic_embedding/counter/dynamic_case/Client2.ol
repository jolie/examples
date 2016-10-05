// Client2.ol works with multiple instances because of the dynamic callback port
// which needs to be specified on invocation time:
// jolie -C ClientLocationConstant=\"socket://localhost:4003\" Client2.ol 

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
	Location: ClientLocationConstant
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
