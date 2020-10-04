type Test2Response: void {
    .result: string
}

interface TestInterface2 {
  OneWay:
    test2( Test2Response )
}
