from .ServerInterface import ServerInterface
from file import File



service ExampleClient{

embed File as file

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

}