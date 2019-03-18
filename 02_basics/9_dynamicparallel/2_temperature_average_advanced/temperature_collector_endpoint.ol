include "TemperatureCollectorInterface.iol"
include "PrivateTemperatureCollectorEndpointInterface.iol"
include "TemperatureSensorInterface.iol"

execution{ concurrent }

cset {
  token: ReturnTemperatureRequest.token
}

outputPort Sensor {
  Protocol: sodep
  Interfaces: TemperatureSensorInterface
}

inputPort PrivateTemperatureCollectorEndpoint {
  Location: "local"
  Protocol: sodep
  Interfaces: PrivateTemperatureCollectorEndpointInterface
}

inputPort TemperatureCollectorEndpoint {
  Location: "socket://localhost:9001"
  Protocol: sodep
  Interfaces: TemperatureCollectorEndpointInterface
}

main {
    retrieveTemperature( request )( response ) {
        csets.token = new;
        req_temp.token = csets.token;
        Sensor.location = request.sensor_location;
        getTemperature@Sensor( req_temp );
        /* asynchrnous call */
        returnTemperature( result );
        response = result.temperature
    }
}
