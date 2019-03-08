include "TestInterface.iol"
include "console.iol"

outputPort Receiver {
  Location:"socket://localhost:9000"
  Protocol: sodep
  Interfaces: TestInterface
}

main {
    test@Receiver( { .field="test message" } )( response );
    println@Console( response.result )()
}
