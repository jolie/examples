include "SumInterface.iol"
include "SubInterface.iol"
include "console.iol"


outputPort Sub {
  Location: "socket://localhost:9000/!/Sub"
  Protocol: sodep
  Interfaces: SubInterface
}

outputPort Sum {
  Location: "socket://localhost:9000/!/Sum"
  Protocol: sodep
  Interfaces: SumInterface
}

main {
  if ( args[ 0 ] == "-help" ) {
    println@Console("Usage: jolie client.ol NUM +|- NUM")()
  } else {
    rq.x = double( args[ 0 ] );
    rq.y = double( args[ 2 ] );
    if ( args[ 1 ] == "+" ) {
        sum@Sum( rq )( result );
        println@Console( result )()
    } else if ( args[ 1 ] == "-" ) {
        sub@Sub( rq )( result );
        println@Console( result )()
    } else {
        println@Console("Operator " + args[ 1 ] + " not supported")()
    }
  }

}
