from .ServerInterface import ServerInterface
from file import File


constants {
    FILENAME = "received.pdf"
}


service ExampleServer {

embed File as file    

inputPort server {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: ServerInterface
}


execution: concurrent 
main {
    setFile( request )( response ) {

        writeFile@file(  {
            .filename = FILENAME;
            .content = request.content;
            .format = "binary"
        })()
    }
}


}

