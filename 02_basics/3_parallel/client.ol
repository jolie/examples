include "getinfoInterface.iol"
include "config.iol"
include "console.iol"



outputPort GetInfo {
Location: GetInfo_location
Protocol: sodep
Interfaces: GetInfoInterface
}

main {
  request.city = args[0];
  getInfo@GetInfo( request )( response );
  println@Console("Temperature:" + response.temperature )();
  println@Console("Wind:" + response.wind )();
  println@Console("Traffic:" + response.traffic )()
}