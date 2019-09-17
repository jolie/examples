include "ServerInterface.iol"
include "file.iol"

execution{ concurrent }

inputPort Server {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: ServerInterface
}

constants {
    FILENAME = "received.txt"
}

main {
    setFileContent( request )( response ) {
        with( rq_w ) {
            .filename = FILENAME;
            .content = request;
            .append = 1
        }
        writeFile@File( rq_w )()
    }
}