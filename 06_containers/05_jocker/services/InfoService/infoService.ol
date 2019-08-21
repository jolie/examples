include "interfaces/infoInterface.iol"
include "interfaces/forecastInterface.iol"
include "interfaces/trafficInterface.iol"
include "console.iol"

execution{ concurrent }

outputPort Forecast {
Location: "socket://forecastservice:8000"
Protocol: sodep
Interfaces: ForecastInterface
}

outputPort Traffic {
Location: "socket://trafficservice:8000"
Protocol: sodep
Interfaces: TrafficInterface
}

inputPort MySelf {
Location: "socket://localhost:8000"
Protocol: sodep
Interfaces: InfoInterface
}

main {
  getInfo(request)(response) {
    getTemperature@Forecast( request )( response.temperature )
    |
    getData@Traffic( request )( response.traffic )
  };
  println@Console("Request served!")()
}
