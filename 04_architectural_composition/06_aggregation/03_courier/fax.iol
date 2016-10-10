type FaxRequest:void {
	.destination:string
	.content:string
}

interface FaxInterface {
RequestResponse:
	fax(FaxRequest)( void )
}
