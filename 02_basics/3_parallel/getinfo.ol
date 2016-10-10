include "getinfoInterface.iol"
include "forecastInterface.iol"
include "trafficInterface.iol"
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

/* here getInfo realizes the orchestration running in parallel the three calls
   Only when the three parallel activities are finished the parallel can end */
main {
  getInfo(request)(response) {
    getTemperature@Forecast( request )( response.temperature )
    |
    getWind@Forecast( request )( response.wind )
    |
    getData@Traffic( request )( response.traffic )
  };
  println@Console("Request served!")()
}
