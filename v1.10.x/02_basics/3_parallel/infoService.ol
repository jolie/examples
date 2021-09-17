from interfaces.infoInterface import InfoInterface
from interfaces.forecastInterface import ForecastInterface
from interfaces.trafficInterface import TrafficInterface
from console import Console


service InfoService {
    execution: concurrent

    embed Console as Console

    outputPort Forecast {
      location: "socket://localhost:8000"
      protocol: sodep
      interfaces: ForecastInterface
    }

    outputPort Traffic {
      location: "socket://localhost:8001"
      protocol: sodep
      interfaces: TrafficInterface
    }

    inputPort MySelf {
      location: "socket://localhost:8002"
      protocol: sodep
      interfaces: InfoInterface
    }

    main {
      getInfo(request)(response) {
        getTemperature@Forecast( request )( response.temperature )
        |
        getData@Traffic( request )( response.traffic )
      }
      println@Console("Request served!")()
    }
}