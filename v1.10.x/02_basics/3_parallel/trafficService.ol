from interfaces.trafficInterface import TrafficInterface

service TrafficServce () {

  execution: concurrent

  inputPort Traffic {
    location: "socket://localhost:8001"
    protocol: sodep
    interfaces: TrafficInterface
  }


  main {
    getData( request )( response ) {
      if ( request.city == "Rome" ) {
        response = "High"
      } else if ( request.city == "Cesena" ) {
        response = "Low"
      } else {
        response = "Undefined"
      }
    }
  }
}
