type JobID:void{
	.jobId:string
}

type FaxAndPrintRequest:void{
	.print:PrintRequest
	.fax:FaxRequest
}
type Aggregator_FaxRequest:void{
	.destination:string
	.content:string
	.key:string
}
type Aggregator_void:void
type Aggregator_PrintRequest:void{
	.content:string
	.key:string
}
type Aggregator_JobID:void{
	.jobId:string
}

type PrintRequest:void{
	.content:string
}
type FaxRequest:void{
	.destination:string
	.content:string
}

interface AggregatorSurface {
OneWay:
	del( JobID )
RequestResponse:
	faxAndPrint( FaxAndPrintRequest )( void ) throws Aborted( undefined ),
	fax( Aggregator_FaxRequest )( Aggregator_void ) throws KeyNotValid( undefined ),
	print( Aggregator_PrintRequest )( Aggregator_JobID ) throws KeyNotValid( undefined )
}
