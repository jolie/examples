type RequestType: void {
  .x: double
  .y: double
}

/* this interface must be implemented by all the services which will be embedded by the parent one */
interface OperationInterface {
  RequestResponse:
    run( RequestType )( double )
}
