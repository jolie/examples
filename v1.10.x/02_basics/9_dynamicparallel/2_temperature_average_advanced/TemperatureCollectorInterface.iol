type RegisterSensorRequest: void {
    .id: string
    .location: string
}

interface TemperatureCollectorInterface {
  RequestResponse:
    getAverageTemperature( void )( double ),
    registerSensor( RegisterSensorRequest )( void )
}

type ReturnTemperatureRequest: void {
    .token: string
    .temperature: double
}

interface TemperatureCollectorEndpointInterface {
  OneWay:
    returnTemperature( ReturnTemperatureRequest )
}
