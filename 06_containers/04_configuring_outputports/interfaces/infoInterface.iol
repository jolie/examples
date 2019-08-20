type GetInfoRequest: void {
  .city: string
}

type GetInfoResponse: void {
  .temperature: double
  .traffic: string
}

interface GetInfoInterface {
RequestResponse:
  getInfo( GetInfoRequest )( GetInfoResponse )
}