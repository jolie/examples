type GetInfoRequest: void {
  .city: string
}

type GetInfoResponse: void {
  .temperature: double
  .traffic: string
  .wind: double
}

interface GetInfoInterface {
RequestResponse:
  getInfo( GetInfoRequest )( GetInfoResponse )
}