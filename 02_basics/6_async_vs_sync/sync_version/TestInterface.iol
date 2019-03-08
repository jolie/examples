type TestRequest: void {
    .field: string
}

type TestResponse: void {
    .result: string
}

interface TestInterface {
  RequestResponse:
    test( TestRequest )( TestResponse )
}
