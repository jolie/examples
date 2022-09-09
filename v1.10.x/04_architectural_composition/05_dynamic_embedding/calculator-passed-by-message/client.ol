from console import Console
from console import ConsoleInputInterface
from file import File
from CalculatorInterface import CalculatorInterface


service Client {

    embed Console as Console
    embed File as File

    inputPort ConsoleInput {
      location: "local"
      interfaces: ConsoleInputInterface
    }

    outputPort Calculator {
      location: "socket://localhost:8000"
      protocol: sodep
      interfaces: CalculatorInterface
    }

    init {
      registerForInput@Console()()
    }

    main {
      print@Console("insert first operand: ")()
      in( x ); request.x = double( x )
      print@Console("insert second operand: ")()
      in( y ); request.y = double( y )
      print@Console("insert operation [sum|mul|div|sub]: ")()
      in( operation )
      if ( operation == "sum" ) {
        readFile@File( { filename = "sum.ol" } )( request.microserviceDefinition )
        sum@Calculator( request )( response )
      } else if ( operation == "sub" ) {
        readFile@File( { filename = "sub.ol" } )( request.microserviceDefinition )
        sub@Calculator( request )( response )
      } else if ( operation == "div" ) {
        readFile@File( { filename = "div.ol" } )( request.microserviceDefinition )
        div@Calculator( request )( response )
      } else if ( operation == "mul" ) {
        readFile@File( { filename = "mul.ol" } )( request.microserviceDefinition )
        mul@Calculator( request )( response )
      }
      
      println@Console( response )()
    }
}
