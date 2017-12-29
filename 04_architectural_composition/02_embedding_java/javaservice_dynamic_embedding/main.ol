include "console.iol"
include "runtime.iol"
include "DynamicJavaServiceInterface.iol"

execution{ concurrent }

outputPort DynamicJavaService {
  Interfaces: DynamicJavaServiceInterface
}

inputPort MyInputPort {
  Location: "socket://localhost:9090"
  Protocol: sodep
  Interfaces: DynamicJavaServiceInterface
}


main {
    [ start( request )( response ) {
        with( emb ) {
          .filepath = "org.jolie.example.dynamicembedding.DynamicJavaService";
          .type = "Java"
        };
        loadEmbeddedService@Runtime( emb )( DynamicJavaService.location );
        start@DynamicJavaService()( response )
    }]
}
