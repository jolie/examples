from ServiceInterface import ServiceInterface
from console import Console

service MyService {

  embed Console as Console 
  execution: concurrent 

  inputPort Test {
    location: "socket://localhost:9000"
    protocol: sodep
    interfaces: ServiceInterface
  }

  main {
      test( request)( response ) {
          global.count++
          count++
          println@Console("global.count:" + global.count )()
          println@Console("count:" + count )()
          println@Console()()
      }
  }
}
