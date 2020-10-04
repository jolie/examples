include "interfaces/infoInterface.iol"
include "config.iol"
include "console.iol"



outputPort GetInfo {
Location: GetInfo_location
Protocol: sodep
Interfaces: GetInfoInterface
}

main {
  if ( #args == 0 ) {
	  println@Console("Please, specify the name of the city for which you need info")()
  } else {
	  request.city = args[0];
	  getInfo@GetInfo( request )( response );
	  println@Console("Temperature:" + response.temperature )();
	  println@Console("Traffic:" + response.traffic )()
  }
}
