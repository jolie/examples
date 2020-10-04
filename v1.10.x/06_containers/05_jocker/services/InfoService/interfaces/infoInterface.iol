type GetInfoRequest: void {
  .city: string
}

type GetInfoResponse: void {
  .temperature: double
  .traffic: string
}

interface InfoInterface {
RequestResponse:
  getInfo( GetInfoRequest )( GetInfoResponse )
}