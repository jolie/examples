include "interfaces/trafficInterface.iol"
include "console.iol"

execution{ concurrent }

inputPort Traffic {
Location: "socket://localhost:8000"
Protocol: sodep
Interfaces: TrafficInterface
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
