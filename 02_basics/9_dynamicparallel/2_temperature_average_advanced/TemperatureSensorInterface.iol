type GetTemperatureRequest: void {
   .token: string
}

interface TemperatureSensorInterface {
  OneWay:
    getTemperature( GetTemperatureRequest )
}
