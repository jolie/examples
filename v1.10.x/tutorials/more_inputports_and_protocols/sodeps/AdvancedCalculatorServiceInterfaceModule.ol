type FactorialRequest: void {
    term: int
}
type FactorialResponse: void {
    factorial: long 
    advertisement: string
}

type AverageRequest: void {
    term*: int 
}
type AverageResponse: void {
    average: double
    advertisement: string
}

type PercentageRequest: void {
    term: double
    percentage: double
}
type PercentageResponse: void {
    result: double
    advertisement: string 
}

interface AdvancedCalculatorInterface {
    RequestResponse:
        factorial( FactorialRequest )( FactorialResponse ),
        average( AverageRequest )( AverageResponse ),
        percentage( PercentageRequest )( PercentageResponse )
}