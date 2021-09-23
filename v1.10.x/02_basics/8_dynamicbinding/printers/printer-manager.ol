from PrinterInterface import PrinterInterface
from PrinterManagerInterface import PrinterManagerInterface

service PrinterManager {

    execution: concurrent

    outputPort Printer {
        protocol: sodep 
        interfaces: PrinterInterface
    }

    inputPort PrinterManager {
        location: "socket://localhost:8000"
        protocol: sodep
        interfaces: PrinterManagerInterface
    }

    main {
        print( request )( response ) {
            if ( request.printer == "printer1" ) {
                Printer.location = "socket://localhost:8001"
            } else if ( request.printer == "printer2" ) {
                Printer.location = "socket://localhost:8002"
            } 
            printText@Printer( { text = request.text } )()
        } 
    }
}