type GetTemperatureRequest: string {
    .place?: void {
        .longitude: string 
        .latittude: string
    }
}

type GetWindRequest: int {
  .city: string
}

interface ForecastInterface {
RequestResponse:
  getTemperature( GetTemperatureRequest )( double ),
  getWind( GetWindRequest )( double )
}