include "ServiceInterface.iol"
include "console.iol"

execution{ concurrent }

inputPort Test {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: ServiceInterface
}

main {
    test( request)( response ) {
        global.count++;
        count++;
        println@Console("global.count:" + global.count )();
        println@Console("count:" + count )();
        println@Console()()
    }
}
