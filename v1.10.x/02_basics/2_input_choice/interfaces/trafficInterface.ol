type GetTrafficRequest {
  city: string
}


interface TrafficInterface {
RequestResponse:
  getData( GetTrafficRequest )( string )
}