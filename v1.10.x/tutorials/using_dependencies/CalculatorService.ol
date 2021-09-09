from CalculatorInterfaceModule import CalculatorInterface

 service CalculatorService {

     execution: concurrent

     inputPort CalculatorPort {
         location: "socket://localhost:8000"
         protocol: http { format = "json" }
         interfaces: CalculatorInterface
     }     

     main {

         [ sum( request )( response ) {
             for( t in request.term ) {
                 response = response + t
             }
         }]

         [ sub( request )( response ) {
             response = request.minuend - request.subtraend
         }]

         [ mul( request )( response ) {
             response = 1
             for ( f in request.factor ) {
                 response = response * f 
             }
         }]

         [ div( request )( response ) {
             response = request.dividend / request.divisor
         }]
     }

 }
