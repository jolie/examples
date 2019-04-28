type LogRequest: void {
  .content: string
}

interface LoggerInterface {
  OneWay:
    log( LogRequest )
}
