include "interfaces/infoInterface.iol"
include "interfaces/forecastInterface.iol"
include "interfaces/trafficInterface.iol"
include "config.iol"
include "console.iol"

execution{ concurrent }

outputPort Forecast {
Location: Forecast_location
Protocol: sodep
Interfaces: ForecastInterface
}

outputPort Traffic {
Location: Traffic_location
Protocol: sodep
Interfaces: TrafficInterface
}

inputPort MySelf {
Location: GetInfo_location
Protocol: sodep
Interfaces: GetInfoInterface
}

/* this is the orchestrator which receives the message from the client and call the three child microservices
   for retrieving the requested information */
main {
  getInfo(request)(response) {
    getTemperature@Forecast( request )( response.temperature )
    ;
    getWind@Forecast( request )( response.wind )
    ;
    getData@Traffic( request )( response.traffic )
  };
  println@Console("Request served!")()
}
