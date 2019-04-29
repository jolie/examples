type SumRequest: void {
  .x: double
  .y: double
}

interface SumInterface {
  RequestResponse:
    sum( SumRequest )( double )
}
