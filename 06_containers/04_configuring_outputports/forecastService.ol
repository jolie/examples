include "interfaces/forecastInterface.iol"
include "console.iol"

execution{ concurrent }

inputPort Forecast {
Location: "socket://localhost:8000"
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
