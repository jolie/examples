type PrintTextRequest {
    text: string
}


interface PrinterInterface {
    RequestResponse: 
        printText( PrintTextRequest )( void )
}