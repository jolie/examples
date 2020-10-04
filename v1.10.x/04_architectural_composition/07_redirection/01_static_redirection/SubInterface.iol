type SubRequest: void {
  .x: double
  .y: double
}

interface SubInterface {
  RequestResponse:
    sub( SubRequest )( double )
}
