type RegisterSensorRequest: void {
    .id: string
    .location: string
}

interface TemperatureCollectorInterface {
  RequestResponse:
    getAverageTemperature( void )( double ),
    registerSensor( RegisterSensorRequest )( void )
}
