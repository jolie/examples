type PrintRequest {
    text: string
    printer: string( enum(["printer1", "printer2"]) )
}

interface PrinterManagerInterface {
    RequestResponse:
        print( PrintRequest )( void ) 
}