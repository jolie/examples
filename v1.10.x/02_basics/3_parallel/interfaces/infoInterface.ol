type GetInfoRequest {
  city: string
}

type GetInfoResponse {
  temperature: double
  traffic: string
}

interface InfoInterface {
RequestResponse:
  getInfo( GetInfoRequest )( GetInfoResponse )
}