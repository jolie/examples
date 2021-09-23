include "ChatRegistryInterface.iol"
include "UserInterface.iol"
include "console.iol"

execution{ concurrent }

outputPort User {
  Protocol: sodep
  Interfaces: UserInterface
}

inputPort ChatRegistry {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: ChatRegistryInterface
}

main {
    [ addChat( request )( response ) {
        if ( !is_defined( global.chat.( request.chat_name ) ) ) {
            global.chat.( request.chat_name ) = true
        }
        ;
        /* check if the chat already exists and the username is already registered */
        if ( !is_defined( global.chat.( request.chat_name ).users.( request.username ) )) {
            global.chat.( request.chat_name ).users.( request.username ).location = request.location;
            /* new is a jolie primitive for creating a fresh token */
            token = new;
            global.chat.( request.chat_name ).users.( request.username ).token = token;
            /* token hashmap */
            global.tokens.( token ).chat_name = request.chat_name;
            global.tokens.( token ).username = request.username
        }
        ;
        response.token = global.chat.( request.chat_name ).users.( request.username ).token
    }]

    [ sendMessage( request )( response ) {
        /* validate token */
        if ( is_defined( global.tokens.( request.token ) ) ) {
            /* sending messages to all participants using dynamic binding */
            chat_name = global.tokens.( request.token ).chat_name;
            foreach( u : global.chat.( chat_name ).users ) {
                /* output port dynamic rebinding */
                User.location = global.chat.( chat_name ).users.( u ).location;
                /* message sending */
                if ( u != global.tokens.( request.token ).username ) {
                  with( msg ) {
                      .message = request.message;
                      .chat_name = chat_name;
                      .username = global.tokens.( request.token ).username
                  };
                  setMessage@User( msg )
                }
            }
        } else {
            throw( TokenNotValid )
        }
    }]


}
