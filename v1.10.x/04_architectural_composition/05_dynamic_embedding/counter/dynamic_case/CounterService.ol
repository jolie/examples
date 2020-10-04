include "counterInterface.iol"

inputPort LocalIn{
	Location: "local"
	Interfaces: CounterInterface
}

main
{
	start();
	while( true ){
		inc()( counter ){
			++counter
		}
	}
}