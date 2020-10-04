include "TemperatureSensorInterface.iol"
include "TemperatureCollectorInterface.iol"
include "math.iol"
include "console.iol"
include "time.iol"

execution{ concurrent }

outputPort TemperatureCollectorEndpoint {
  Location: "socket://localhost:9001"
  Protocol: sodep
  Interfaces: TemperatureCollectorEndpointInterface
}

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
    [ getTemperature( request ) ] {
        random@Math()( r );
        response.temperature = r*40;
        response.token = request.token;
        random@Math()( t );
        timetosleep = t*10000;
        println@Console("Simulate delay, sleeping for " + timetosleep + "ms" )();
        sleep@Time( int( timetosleep ) )();
        println@Console("Sensor " + id + " returns " + response.temperature )();
        returnTemperature@TemperatureCollectorEndpoint( response )
    }
}
