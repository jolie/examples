include "TestInterface.iol"
include "TestInterface2.iol"

outputPort Sender {
  Location:"socket://localhost:9001"
  Protocol: sodep
  Interfaces: TestInterface2
}

inputPort Receiver {
  Location:"socket://localhost:9000"
  Protocol: sodep
  Interfaces: TestInterface
}

main {
  test( request );
  response.result = "result " + request.field;
  test2@Sender( response )
}
