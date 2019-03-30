include "ServerInterface.iol"
include "time.iol"
include "console.iol"

execution{ concurrent }

inputPort Server {
  Location: "socket://localhost:10000"
  Protocol: sodep
  Interfaces: ServerInterface
}

init {
  if ( args[0] == "fault" ) {
    fault = true
  } else {
    fault = false
  }
}

main {
    hello( request )( response ) {
        println@Console("Received a request, sleeping...")();
        sleep@Time( 3000 )();
        println@Console("Processing request...")();
        if ( fault ) {
          println@Console("Sending a fault to invoker")();
          throw( ServerFault )
        } else {
            response = "Server:" + request
        }
        ;
        println@Console("Sending response:" + response )()

    }

}
