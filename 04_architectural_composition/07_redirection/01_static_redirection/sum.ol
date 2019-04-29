include "locations.iol"
include "SumInterface.iol"

execution{ concurrent }

inputPort Sum {
  Location: Location_Sum
  Protocol: sodep
  Interfaces: SumInterface
}

main {
  sum( request )( response ) {
    response = request.x + request.y
  }
}
