from .calculator-interface import CalculatorInterface

service Calculator {
	execution: concurrent

	inputPort CalculatorPort {
		location: "local"
		interfaces: CalculatorInterface
	}     

	main {
		[ sum( request )( response ) {
			for( t in request.term ) {
				response += t
			}
		} ]

		[ sub( request )( request.minuend - request.subtraend ) ]

		[ mul( request )( response ) {
			response = 1
			for ( f in request.factor ) {
				response *= f 
			}
		} ]
		
		[ div( request )( request.dividend / request.divisor ) ]
	}
}

