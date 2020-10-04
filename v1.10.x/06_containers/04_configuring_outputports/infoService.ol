include "interfaces/infoInterface.iol"
include "interfaces/forecastInterface.iol"
include "interfaces/trafficInterface.iol"
include "console.iol"

execution{ concurrent }

outputPort Forecast {
Location: "auto:ini:/Location/Forecast:file:/var/temp/config.ini"
Protocol: sodep
Interfaces: ForecastInterface
}

outputPort Traffic {
Location: "auto:ini:/Location/Traffic:file:/var/temp/config.ini"
Protocol: sodep
Interfaces: TrafficInterface
}

inputPort MySelf {
Location: "socket://localhost:8000"
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
