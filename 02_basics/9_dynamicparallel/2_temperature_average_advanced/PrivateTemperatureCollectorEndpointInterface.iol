type RetrieveTemperatureRequest: void {
    .sensor_location: string
}

interface PrivateTemperatureCollectorEndpointInterface {
    RequestResponse:
      retrieveTemperature( RetrieveTemperatureRequest )( double )
}
