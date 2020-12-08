type FactorialRequest: void {
    term[1,*]: int
}
type FactorialResponse: void {
    factorial: long 
}

type AverageRequest: void {
    term*: int 
}
type AverageResponse: void {
    average: double
}

type PercentageRequest: void {
    term: double
    percentage: double
}
type PercentageResponse: double

interface AdvancedCalculatorInterface {
    RequestResponse:
        factorial( FactorialRequest )( FactorialResponse ),
        average( AverageRequest )( AverageResponse ),
        percentage( PercentageRequest )( PercentageResponse )
}