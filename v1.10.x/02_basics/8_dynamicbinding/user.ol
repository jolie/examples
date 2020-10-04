include "console.iol"
include "runtime.iol"

include "ChatRegistryInterface.iol"

outputPort ChatRegistry {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: ChatRegistryInterface
}

init {
  registerForInput@Console()()
}

/*  args[0] specifies the listening location,
    args[1] specifies the name of the chat,
    args[2] specifies the username */
init {
    if ( #args != 3 ) {
      println@Console( "Usage: jolie user.ol <location> <chat_name> <username>")();
      throw( Error )
    }
    ;
    /* dynamic embedding of user_service.ol */
    with( emb ) {
        .filepath = "-C LOCATION=\"" + args[ 0 ] + "\" user_service.ol";
        .type = "Jolie"
    };
    loadEmbeddedService@Runtime( emb )();
    _location = args[0];
    _chat_name = args[1];
    _username = args[2]
}

main {
    with( add_req ) {
        .chat_name = args[1];
        .username = args[2];
        .location = args[0]
    };
    addChat@ChatRegistry( add_req )( add_res );
    token = add_res.token;
    while( cmd != "exit" ) {
        in( message );
        sendMessage@ChatRegistry( { .token = token, .message=message } )()
    }
}
