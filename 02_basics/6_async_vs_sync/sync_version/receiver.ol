include "TestInterface.iol"

execution{ concurrent }

inputPort Receiver {
  Location:"socket://localhost:9000"
  Protocol: sodep
  Interfaces: TestInterface
}

main {
  test( request )( response ) {
      response.result = "result " + request.field
  }
}
