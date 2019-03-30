interface ServerInterface {
  RequestResponse:
    hello( string )( string ) throws ServerFault
}
