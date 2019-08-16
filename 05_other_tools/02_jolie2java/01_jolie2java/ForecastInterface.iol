type GetTemperatureRequest: void {
  .city: string {
      .place?: void {
          .longitude: string 
          .latittude: string
      }
  }
}

type GetWindRequest: void {
  .city: string
}

interface ForecastInterface {
RequestResponse:
  getTemperature( GetTemperatureRequest )( double ),
  getWind( GetWindRequest )( double )
}