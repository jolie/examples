/* the type of the fault */
type NumberExceptionType: void{
	.number: int
	.exceptionMessage: string
}

interface GuessInterface {
	/* note that the fault declaration now, specifies also the type of the fault */
	RequestResponse: guess throws NumberException( NumberExceptionType )
}
