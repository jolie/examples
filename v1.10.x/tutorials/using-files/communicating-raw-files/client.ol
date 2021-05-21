from .ServerInterface import ServerInterface
from file import File



service ExampleClient{

    embed File as file

    outputPort server {
        Location: "socket://localhost:9000"
        Protocol: sodep
        Interfaces: ServerInterface
    }

    main {
        
        readFile@file( {
            filename = "source.pdf"
            format = "binary"
        } )( rq.content )
        
        setFile@server( rq )()
    }

}