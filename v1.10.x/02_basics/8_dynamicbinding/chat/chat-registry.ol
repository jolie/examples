from ChatRegistryInterface import ChatRegistryInterface
from UserInterface import UserInterface
from console import Console


service Chat {
    execution: concurrent 

    embed Console as Console

    outputPort User {
        protocol: sodep
        interfaces: UserInterface
    }

    inputPort ChatRegistry {
        location: "socket://localhost:9000"
        protocol: sodep
        interfaces: ChatRegistryInterface
    }

    main {
        [ addChat( request )( response ) {
            if ( !is_defined( global.chat.( request.chat_name ) ) ) {
                global.chat.( request.chat_name ) = true
            }
            ;
            /* check if the chat already exists and the username is already registered */
            if ( !is_defined( global.chat.( request.chat_name ).users.( request.username ) )) {
                global.chat.( request.chat_name ).users.( request.username ).location = request.location
                /* new is a jolie primitive for creating a fresh token */
                token = new
                global.chat.( request.chat_name ).users.( request.username ).token = token
                /* token hashmap */
                global.tokens.( token ).chat_name = request.chat_name
                global.tokens.( token ).username = request.username
            }
            ;
            response.token = token
        }]

        [ sendMessage( request )( response ) {
            /* validate token */
            if ( !is_defined( global.tokens.( request.token ) ) ) {
                throw( TokenNotValid )
            }
        }] {
            /* sending messages to all participants using dynamic binding */
                chat_name = global.tokens.( request.token ).chat_name
                foreach( u : global.chat.( chat_name ).users ) {
                    /* output port dynamic rebinding */
                    User.location = global.chat.( chat_name ).users.( u ).location
                    /* message sending */
                    if ( u != global.tokens.( request.token ).username ) {
                        msg <<  {
                            message = request.message
                            chat_name = chat_name
                            username = global.tokens.( request.token ).username
                        }
                        scope( sending_msg ) {
                            install( IOException => 
                                target_token = global.chat.( chat_name ).users.( u ).token
                                undef( global.tokens.( target_token ) )
                                undef( global.chat.( chat_name ).users.( u ) )
                                println@Console("User service not found, removed user " + u + " from chat " + chat_name )()
                            )
                            setMessage@User( msg )
                        }
                    }
                }
        }


    }
}
