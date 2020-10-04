include "locations.iol"
include "console.iol"

include "SumInterface.iol"
include "SubInterface.iol"

outputPort SubService {
Location: Location_Sub
Protocol: sodep
}

outputPort SumService {
Location: Location_Sum
Protocol: sodep
}

inputPort Redirector {
Location: Location_Redirector
Protocol: sodep
/* here we define the redirection mapping resource names (Sub and Sum) with existing outputPorts
(SumService and SubService) */
Redirects:
	Sub => SubService,
	Sum => SumService
}

main
{
  /* internal link just used for keeping the redirector running */
	linkIn( dummy )
}
