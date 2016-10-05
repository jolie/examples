include "twiceInterface.iol"

/* this inputPort is bound to "local" because the service will be embedded and the
communication will be resolved in memory */
inputPort TwiceService {
	Location: "local"
	Interfaces: TwiceInterface
}

main
{
	twice( number )( result )
	{
		result = number * 2
	}
}
