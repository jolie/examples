include "ServiceInterface.iol"

outputPort Test {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: ServiceInterface
}

main {
  for( i = 0, i < 10, i++ ) {
      test@Test()()
  }
}
