
include "services/ForecastService/forecastInterface.iol"
include "services/InfoService/interfaces/infoInterface.iol"

include "console.iol"

outputPort Forecast {
	Location: "socket://localhost:8000"
	Protocol: sodep
	Interfaces: ForecastInterface
}

outputPort GetInfo {
	Location: "socket://localhost:8002"
	Protocol: sodep
	Interfaces: InfoInterface
}

main {
  if ( #args == 0 ) {
	  println@Console("Please, specify the name of the city for which you need info")()
  } else {
	  request.city = args[0];
	  getTemperature@Forecast( request )( temperature );
	  getInfo@GetInfo( request )( response );
	  println@Console("Temperature:" + response.temperature )();
	  println@Console("Traffic:" + response.traffic )()
  }
}
