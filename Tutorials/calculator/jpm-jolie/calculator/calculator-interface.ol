type SumRequest {
	term[1,*]: int
}

type SubRequest {
	minuend: int 
	subtraend: int
}

type MulRequest {
	factor[1,*]: double
}

type DivRequest {
	dividend: double
	divisor: double
}

interface CalculatorInterface {
RequestResponse:
	sum( SumRequest )( int ),
	sub( SubRequest )( int ),
	mul( MulRequest )( double ),
	div( DivRequest )( double ) 
}

