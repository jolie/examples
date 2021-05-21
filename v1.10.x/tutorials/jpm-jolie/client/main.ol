from calculator import Calculator
from console import Console

service Example {
	embed Calculator as calculator
	embed Console as console

	main {
		sum@calculator( {
			term[0] = 2
			term[1] = 5
		} )( result )
		println@console( result )()
	}
}

