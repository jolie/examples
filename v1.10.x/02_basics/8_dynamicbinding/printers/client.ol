from PrinterManagerInterface import PrinterManagerInterface
from console import ConsoleInputInterface
from console import Console

service Client {

    embed Console as Console

    inputPort InputPortForConsole {
        location: "local"
        interfaces: ConsoleInputInterface
    }

    outputPort PrinterManager {
        location: "socket://localhost:8000"
        protocol: sodep 
        interfaces: PrinterManagerInterface
    }

    init {
        registerForInput@Console()()
    }

    main {
    
        println@Console("Insert the text to print")()
        in( request.text )
        println@Console("Insert the printer name [printer1|printer2}")()
        in( request.printer )
        scope( print ) {
            install( TypeMismatch => 
                println@Console( "Only printer1 or printer2 are admitted")()
            )
            print@PrinterManager( request )()
        }
    }

}