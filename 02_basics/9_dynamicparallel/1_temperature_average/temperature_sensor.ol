include "TemperatureSensorInterface.iol"
include "TemperatureCollectorInterface.iol"
include "math.iol"
include "console.iol"

execution{ concurrent }

outputPort TemperatureCollector {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: TemperatureCollectorInterface
}

inputPort TemperatureSensor {
  Location: TemperatureSensorLocation       /* the location comes from a constant defined in the command line */
  Protocol: sodep
  Interfaces: TemperatureSensorInterface
}

init {
    /* generate a random id */
    scope( initiate ) {
        install( IOException => println@Console("ERROR: Temperature collector not found!")() );
        id = new;
        with( register_req ) {
          .id = id;
          .location = TemperatureSensorLocation
        };
        registerSensor@TemperatureCollector( register_req )()
    }
}

main {
    [ getTemperature( request )( response ) {
        random@Math()( r );
        response = r*40;
        println@Console("Sensor " + id + " returns " + response )()
    }]
}
