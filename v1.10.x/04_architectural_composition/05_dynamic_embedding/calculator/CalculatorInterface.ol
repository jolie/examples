type RequestType {
  x: double
  y: double
}

interface CalculatorInterface {
  RequestResponse:
    sum( RequestType )( double ),
    mul( RequestType )( double ),
    div( RequestType )( double ),
    sub( RequestType )( double )
}
