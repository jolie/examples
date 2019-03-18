include "TemperatureCollectorInterface.iol"
include "console.iol"

outputPort TemperatureCollector {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: TemperatureCollectorInterface
}

main {
  getAverageTemperature@TemperatureCollector()( response );
  println@Console( response )()
}
