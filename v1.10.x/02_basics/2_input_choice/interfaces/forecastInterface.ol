type GetTemperatureRequest {
  city: string
}

type GetWindRequest {
  city: string
}

interface ForecastInterface {
RequestResponse:
  getTemperature( GetTemperatureRequest )( double ),
  getWind( GetWindRequest )( double )
}