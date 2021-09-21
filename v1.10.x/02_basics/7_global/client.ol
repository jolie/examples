from ServiceInterface import ServiceInterface

service Client {
    outputPort Test {
      location: "socket://localhost:9000"
      protocol: sodep
      interfaces: ServiceInterface
    }

    main {
      for( i = 0, i < 10, i++ ) {
          test@Test()()
      }
    }
}