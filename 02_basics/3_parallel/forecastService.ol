include "interfaces/forecastInterface.iol"
include "config.iol"
include "console.iol"

execution{ concurrent }

inputPort Forecast {
Location: Forecast_location
Protocol: sodep
Interfaces: ForecastInterface
}


main {
  getTemperature( request )( response ) {
    if ( request.city == "Rome" ) {
      response = 32.4
    } else if ( request.city == "Cesena" ) {
      response = 30.1
    } else {
      response = 0.0
    }
  }
}
