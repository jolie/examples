include "fax.iol"
include "locations.iol"
include "console.iol"

execution { concurrent }

inputPort FaxInput {
Location: "local"
Protocol: sodep
Interfaces: FaxInterface
}

main
{
	fax( request )() {
			println@Console( "Faxing to " + request.destination + ". Content: " + request.content )()
	}
}
