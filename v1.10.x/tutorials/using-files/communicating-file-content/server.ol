from .ServerInterface import ServerInterface
from file import File

constants {
    FILENAME = "received.txt"
}


service ExampleServer {

 
embed File as file

inputPort server {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: ServerInterface
}


execution:concurrent

main {
    setFileContent( request )( response ) {
        writeFile@File( {
            filename = FILENAME
            content = request
            append = 1
        } )()
    }
}

}

