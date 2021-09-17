type GetInfoRequest {
  city: string
}

type GetInfoResponse {
  temperature: double
  traffic: string
  wind: double
}

interface InfoInterface {
RequestResponse:
  getInfo( GetInfoRequest )( GetInfoResponse )
}