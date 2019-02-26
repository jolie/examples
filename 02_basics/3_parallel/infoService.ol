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

main {
  getInfo(request)(response) {
    getTemperature@Forecast( request )( response.temperature )
    |
    getData@Traffic( request )( response.traffic )
  };
  println@Console("Request served!")()
}
