include "TestInterface2.iol"
include "TestInterface.iol"
include "console.iol"

outputPort Receiver {
  Location:"socket://localhost:9000"
  Protocol: sodep
  Interfaces: TestInterface
}

inputPort Sender {
  Location: "socket://localhost:9001"
  Protocol: sodep
  Interfaces: TestInterface2
}

main {
    test@Receiver( { .field="test message" } );
    test2( response );
    println@Console( response.result )()
}
