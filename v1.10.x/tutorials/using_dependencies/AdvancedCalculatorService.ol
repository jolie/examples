from AdvancedCalculatorServiceInterfaceModule import AdvancedCalculatorInterface
from CalculatorInterfaceModule import CalculatorInterface

service AdvancedCalculatorService {

    execution{ concurrent }

    outputPort Calculator {
         location: "socket://localhost:8000"
         protocol: http { format = "json" }
         interfaces: CalculatorInterface
    }

    inputPort AdvancedCalculatorPort {
         location: "socket://localhost:8001"
         protocol: http { format = "json" }
         interfaces: AdvancedCalculatorInterface
    }

    main {
        [ factorial( request )( response ) {
            for( i = request.term, i > 0, i-- ) {
                req_mul.factor[ #req_mul.factor ] = i
            }
            mul@Calculator( req_mul )( response.factorial )            
        }]

        [ average( request )( response ) {
            sum@Calculator( request )( sum_res )
            div@Calculator( { dividend = double( sum_res ), divisor = double( #request.term ) })( response.average )
        }]

        [ percentage( request )( response ) {
            div@Calculator( { dividend = request.term, divisor = 100.0 })( div_res )
            mul@Calculator( { factor[0] = div_res, factor[1] = request.percentage })( response )
        }]
    }
}