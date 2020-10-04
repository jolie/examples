include "locations.iol"
include "console.iol"

include "SumInterface.iol"
include "SubInterface.iol"

outputPort SubService {
Location: Location_Sub
Protocol: http
Interfaces: SubInterface
}

outputPort SumService {
Location: Location_Sum
Protocol: http
Interfaces: SumInterface
}

inputPort Redirector {
Location: "socket://localhost:2002/"
Protocol: sodep
/* here we define the redirection mapping resource names (Sub and Sum) with existing outputPorts
(SumService and SubService) */
Redirects:
	Sub => SubService,
	Sum => SumService
}

main
{
  /* internal link just ised for keeping the redirector running */
	linkIn( dummy )
}
