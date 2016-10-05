include "counterInterface.iol"

execution{ concurrent }

inputPort LocalIn{
	Location: "local"
	Interfaces: CounterInterface
}

init {
	counter -> global.counter
}

main
{
	inc()( counter ){
		++counter
	}
}
