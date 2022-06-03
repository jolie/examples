from runtime import Runtime
from OperationInterface import OperationInterface 
from CalculatorInterface import CalculatorInterface


service Calculator {
    execution: concurrent 

    embed Runtime as Runtime

    /* common interface of the embedded services */
    outputPort Operation {
      interfaces: OperationInterface
    }

    inputPort Calculator {
      location: "socket://localhost:8000"
      protocol: sodep
      interfaces: CalculatorInterface
    }

    /* this is the body of each service which embeds the jolie service that corresponds to the name of the operation */
    define __embed_service {
        emb << {
          filepath = __op + ".ol"
          type = "Jolie"
        };
        /* this is the Runtime service operation for dynamic embed files */
        loadEmbeddedService@Runtime( emb )( Operation.location )

        /* once embedded we call the run operation */
        run@Operation( request )( response )
    }

    /* note that the embedded service is running once ofr each enabled session then it expires.
    Thus each call produce a new specific embedding for that call */
    main {
      [ sum( request )( response ) {
          __op = "sum";
          /* here we call the define __embed_service where the variable __p is the name of the operation */
          __embed_service
      }]

      [ mul( request )( response ) {
          __op = "mul";
          __embed_service
      }]

      [ div( request )( response ) {
          __op = "div";
          __embed_service
      }]

      [ sub( request )( response ) {
        __op = "sub";
        __embed_service
      }]
    }
}
