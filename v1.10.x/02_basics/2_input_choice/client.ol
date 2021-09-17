from interfaces.infoInterface import InfoInterface
from console import Console

service Client {

	embed Console as Console

	outputPort GetInfo {
		location: "socket://localhost:8002"
		protocol: sodep
		interfaces: InfoInterface
	}

  main {
    if ( #args == 0 ) {
        println@Console("Specify the city for which you are requiring information")()
    } else {
        request.city = args[0];
        getInfo@GetInfo( request )( response );
        println@Console("Temperature:" + response.temperature )();
        println@Console("Wind:" + response.wind )();
        println@Console("Traffic:" + response.traffic )()
    }
  }
}
