from interfaces.forecastInterface import ForecastInterface

service ForecastService {

    execution: concurrent 

    inputPort Forecast {
      location: "socket://localhost:8000"
      protocol: sodep
      interfaces: ForecastInterface
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
}
