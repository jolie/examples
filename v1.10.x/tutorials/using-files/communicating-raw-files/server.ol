include "ServerInterface.iol"
include "file.iol"

execution{ concurrent }

inputPort Server {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: ServerInterface
}

constants {
    FILENAME = "received.pdf"
}

main {
    setFile( request )( response ) {
        with( rq_w ) {
            .filename = FILENAME;
            .content = request.content;
            .format = "binary"
        }
        writeFile@File( rq_w )()
    }
}