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
			println@Console("Please, specify the name of the city for which you need info")()
		} else {
			request.city = args[0];
			getInfo@GetInfo( request )( response );
			println@Console("Temperature:" + response.temperature )();
			println@Console("Traffic:" + response.traffic )()
		}
	}
}
