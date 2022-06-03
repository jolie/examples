from OperationInterface import OperationInterface

service Div {
  inputPort Op {
    location:"local"
    interfaces: OperationInterface
  }

  main {
    run( request )( response ) {
        response = request.x / request.y
    }
  }
}
