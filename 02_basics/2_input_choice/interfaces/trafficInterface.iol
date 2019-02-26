type GetTrafficRequest: void {
  .city: string
}


interface TrafficInterface {
RequestResponse:
  getData( GetTrafficRequest )( string )
}