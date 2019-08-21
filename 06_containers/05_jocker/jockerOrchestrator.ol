include "console.iol"
include "string_utils.iol"
include "json_utils.iol"
include "file.iol"
include "exec.iol"
include "time.iol"
include "services/InfoService/interfaces/infoInterface.iol"

include "InterfaceAPI.iol"

outputPort Jocker {
	Location: "socket://localhost:8008"
	Protocol: sodep
	Interfaces: InterfaceAPI
}

outputPort InfoService {
    Location: "socket://localhost:8002"
    Protocol: sodep
    Interfaces: InfoInterface
}

constants {
    NETWORK_NAME = "testnet",
    STARTING_PORT = 8000
}

define __prepare_image {
    // __serviceName
    // Preparing tar files
    exec_rq = "tar";
    with( exec_rq ) {
        .args[0] = "-cf";
        .args[1] = __serviceName + ".tar";
        .args[2] = __serviceName;
        .workingDirectory = "services"
    };
    exec@Exec( exec_rq )( exec_rs );


	// * Loading file tar and prepare to build
  	file.filename = "services/" + __serviceName + ".tar";
	file.format = "binary";
	readFile@File(file)(rqImg.file);

	rqImg.dockerfile = __serviceName + "/Dockerfile";
    toLowerCase@StringUtils( __serviceName )( __serviceName );
  	rqImg.t = __serviceName + "_img:latest";


	println@Console("Building " + __serviceName + " image")();
	// send it to Docker
	build@Jocker(rqImg)(response);
    println@Console("Done")()
}

init {
    service[ 0 ] = "ForecastService";
    service[ 1 ] = "TrafficService";
    service[ 2 ] = "InfoService"
}


main {
    // image creation
    for( i = 0, i < #service, i++ ) {
         __serviceName = service[ i ];
         __prepare_image
    }
    ;
    // create network
    println@Console("Creating network " + NETWORK_NAME + "...")();
    ntwCreate_rq.Name = NETWORK_NAME;
    createNetwork@Jocker( ntwCreate_rq )( ntwCreate_rs );
    network_id = ntwCreate_rs.Id;
    println@Console("Done.")();

    // creating containers
    for( i = 0, i < #service, i++ ) {
        toLowerCase@StringUtils( service[ i ] )( service_name );
        port = STARTING_PORT + i;
        with ( cntCreate_rq ) {
            .name = service_name;
            .Image = service_name + "_img:latest";
            //.ExposedPorts.("9000/tcp") = obj.("{}");
            .HostConfig.PortBindings.("8000/tcp")._.HostIp = "localhost";
            .HostConfig.PortBindings.("8000/tcp")._.HostPort = string( port )
        }
        ;
        createContainer@Jocker( cntCreate_rq )( cntCreate_rs );
        service[ i ].container_id = cntCreate_rs.Id;

        println@Console("Attaching container " + service_name + " to network " + NETWORK_NAME )();
        with( attachCnt2Ntw_rq ) {
            .Container = service[ i ].container_id;
            .id = network_id
        };
        attachContainerToNetwork@Jocker( attachCnt2Ntw_rq )();
        println@Console("Done.")();

        // starting container
        println@Console("Starting container " + service_name )();
        startCnt_rq.id = service_name;
        startContainer@Jocker( startCnt_rq )();
        println@Console("Done.")()
    }
    ;

    info_service_running = false;
    while( !info_service_running ) {
        inspect_rq.id = service[ 2 ].container_id;
        println@Console("Inspecting container infoservice")();
        scope( inspect ) {
            install( NoSuchContainer =>  sleep@Time( 2000 )(  ) );
             inspectContainer@Jocker( inspect_rq )( inspect_rs );
             println@Console( "Status:" + inspect_rs.State.Status )();
             if ( inspect_rs.State.Running ) {
                info_service_running = true
             } else {
                 sleep@Time( 2000 )(  )
             }
        }
       
    }
    ;
    // invoking the system
    println@Console("Trying to invoke infoService")();
    scope( getInfo ) {
        install( default => 
            // second attempt
            println@Console("Trying a second attempt...")();
            sleep@Time( 2000 )();
            getInfo@InfoService( { .city = "Rome" } )( info )
        );
        getInfo@InfoService( { .city = "Rome" } )( info )
    }
    ;
    valueToPrettyString@StringUtils( info )( s );
    println@Console("Received response from info service:")();
    println@Console( s )();

    // stopping and removing containers
    for( i = 0, i < #service, i++ ) {
        service_name = service[ i ];
        toLowerCase@StringUtils( service_name )( service_name );
        println@Console("Stopping container " +  service_name )();
        stopCnt_rq.id = service_name;
        stopContainer@Jocker( stopCnt_rq )();
        print@Console( "Done." )(  );
        println@Console("removing....")();
        removeContainer@Jocker( stopCnt_rq )( );
        println@Console("Done.")()
    }
    ;

    // removing network
    println@Console("Removing network...")();
    ntwRemove_rq.id = network_id;
    removeNetwork@Jocker( ntwRemove_rq )();
    println@Console("Done.")();

    // removing image
    for( i = 0, i < #service, i++ ) {
        service_name = service[ i ];
        toLowerCase@StringUtils( service_name )( service_name );
        rmImage_rq.name = service_name + "_img:latest";
        println@Console( "Removing image " + rmImage_rq.name + "...")();
        removeImage@Jocker( rmImage_rq )();
        println@Console("Done")()
    }

	

}
