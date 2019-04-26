type Aggregator_FaxRequest:void{
	.key:string
	.destination:string
	.content:string
}

type Aggregator_void:void


interface AggregatorSurface {
RequestResponse:
	get_key( string )( string ),
	fax( Aggregator_FaxRequest )( Aggregator_void ) throws KeyNotValid
}

outputPort Aggregator{
	Location:"socket://localhost:9002"
	Protocol:sodep
	Interfaces:AggregatorSurface
}
