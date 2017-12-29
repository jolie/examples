include "console.iol"
include "DynamicJavaServiceInterface.iol"

outputPort Service {
  Location: "socket://localhost:9090"
  Protocol: sodep
  Interfaces: DynamicJavaServiceInterface
}

main {
    for( i = 0, i < 10, i++ ) {
      start@Service()( counter );
      println@Console( counter )()
    }
}
