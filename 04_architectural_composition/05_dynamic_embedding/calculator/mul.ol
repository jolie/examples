include "OperationInterface.iol"

inputPort Op {
  Location:"local"
  Interfaces: OperationInterface
}

main {
  run( request )( response ) {
    response = request.x * request.y
  }
}
