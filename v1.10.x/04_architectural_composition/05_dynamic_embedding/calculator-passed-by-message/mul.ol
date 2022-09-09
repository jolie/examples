from OperationInterface import OperationInterface

service Mul {

  inputPort Op {
    Location:"local"
    Interfaces: OperationInterface
  }

  main {
    run( request )( response ) {
      response = request.x * request.y
    }
  }
}
