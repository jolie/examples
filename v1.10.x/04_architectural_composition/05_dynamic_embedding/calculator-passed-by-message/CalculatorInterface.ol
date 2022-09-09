type RequestType {
  x: double
  y: double
  microserviceDefinition: string
}

interface CalculatorInterface {
  RequestResponse:
    sum( RequestType )( double ),
    mul( RequestType )( double ),
    div( RequestType )( double ),
    sub( RequestType )( double )
}
