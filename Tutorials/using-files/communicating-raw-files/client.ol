include "ServerInterface.iol"
include "file.iol"

outputPort Server {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: ServerInterface
}

main {
    with( f ) {
        .filename = "source.pdf";
        .format = "binary"
    }
    readFile@File( f )( rq.content )
    setFile@Server( rq )()
}