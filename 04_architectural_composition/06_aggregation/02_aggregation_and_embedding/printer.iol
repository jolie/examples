type JobID: void {
	.jobId: string
}

type PrintRequest:void {
	.content:string
}

type PrintResponse: JobID

interface PrinterInterface {
RequestResponse:
	print( PrintRequest )( PrintResponse ),
OneWay:
	del( JobID )
}
