include "runtime.iol"

interface HelloInterface {

RequestResponse:
     hello( string )( string )
}

execution{ concurrent }


inputPort Hello {
Location: "socket://localhost:8000"
Protocol: sodep
Interfaces: HelloInterface
}

init {
  getenv@Runtime( "TESTVAR" )( TESTVAR )
}

main {
  hello( request )( response ) {
        response = TESTVAR + ":" + request + ":" + args[0]
  }
}
