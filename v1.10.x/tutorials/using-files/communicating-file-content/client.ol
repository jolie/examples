include "ServerInterface.iol"
include "file.iol"

outputPort Server {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: ServerInterface
}

main {
    f.filename = "source.txt"
    readFile@File( f )( content )
    setFileContent@Server( content )()
}