from PrinterInterface import PrinterInterface
from console import Console 

type ParameterType {
    location: string
    name: string
}

service Printer ( p : ParameterType ) {

    execution: concurrent 

    embed Console as Console

    inputPort PrinterPort {
        location: p.location
        protocol: sodep 
        interfaces: PrinterInterface
    }

    main {
        printText( request )( response ) {
            println@Console( "Printing message " + request.text + ", on " + p.name )()
        }
    }
}