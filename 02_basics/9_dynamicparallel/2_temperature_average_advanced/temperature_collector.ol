include "TemperatureSensorInterface.iol"
include "TemperatureCollectorInterface.iol"
include "PrivateTemperatureCollectorEndpointInterface.iol"
include "console.iol"

outputPort TemperatureCollectorEndpoint {
  Interfaces: PrivateTemperatureCollectorEndpointInterface
}

execution{ concurrent }

embedded {
  Jolie:
      "temperature_collector_endpoint.ol" in TemperatureCollectorEndpoint
}

inputPort TemperatureCollector {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: TemperatureCollectorInterface
}

main {

    [ getAverageTemperature( request )( response ) {
        index = 0;
        foreach( sensor : global.sensor_hashmap ) {
            /* creates the vector for ranging over in the spawn primitive */
            sensor_vector[ index ] << global.sensor_hashmap.( sensor );
            index++
        };
        println@Console( "Contacting " + #sensor_vector +  " sensors" )();
        /* calling the spawn primitive */
        spawn( i over #sensor_vector ) in resultVar {
            scope( call_sensor ) {
                install( IOException =>
                    /* de-register a sensor if it does not respond */
                    println@Console("Sensor " + sensor_vector[ i ].id + " does not respond. Removed.")();
                    undef( global.sensor_hashmap.( sensor_vector[ i ].id ) )
                );
                rq_temp.sensor_location = sensor_vector[ i ].location;
                println@Console( "Contacting sensor " + sensor_vector[ i ].id + " at location " + sensor_vector[ i ].location )();
                retrieveTemperature@TemperatureCollectorEndpoint( rq_temp )( resultVar );
                println@Console( "Sensor " + sensor_vector[ i ].id + " returns temperature " + resultVar )()
            }
        }
        ;
        /* calculate the average */
        for( y = 0, y < #resultVar, y++ ) {
            total = total + resultVar[ y ]
        };
        response = total / #resultVar;
        println@Console("Calculated average temperature:" + response )()
    }]

    [ registerSensor( request )( response ) {
        global.sensor_hashmap.( request.id ).location = request.location;
        global.sensor_hashmap.( request.id ).id = request.id;
        println@Console("Registered sensor " + request.id + " at location " + request.location )()
    }]
}
