type FaxRequest:void {
	.destination:string
	.content:string
}

type FaxResponse: void

interface FaxInterface {
RequestResponse:
	fax(FaxRequest)(FaxResponse)
}
