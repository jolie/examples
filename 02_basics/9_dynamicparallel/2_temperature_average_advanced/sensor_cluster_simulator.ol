include "runtime.iol"
include "console.iol"

main {
    if ( #args == 0 ) {
        println@Console("Usage jolie sensor_cluster_simulator.ol <num of sensors>")()
    } else {
        start_port = 10000;
        for( i = 0, i < args[ 0 ], i++ ) {
            with( emb ) {
                .filepath = "-C TemperatureSensorLocation=\"socket://localhost:" + start_port + "\" temperature_sensor.ol";
                .type = "Jolie"
            };
            loadEmbeddedService@Runtime( emb )();
            start_port++
        };
        while( true ){ nullProcess }
    }
}
