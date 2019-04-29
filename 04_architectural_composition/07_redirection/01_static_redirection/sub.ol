include "locations.iol"
include "SubInterface.iol"


execution{ concurrent }

inputPort Sub {
  Location: Location_Sub
  Protocol: sodep
  Interfaces: SubInterface
}

main {
  sub( request )( response ) {
    response = request.x - request.y
  }
}
