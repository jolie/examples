type TestRequest: void {
    .field: string
}

interface TestInterface {
  OneWay:
    test( TestRequest )
}
