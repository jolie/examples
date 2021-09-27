from ChatRegistryInterface import ChatRegistryInterface
from UserInterface import UserInterface
from console import ConsoleInputInterface
from console import Console
from runtime import Runtime

type UserParams {
  location: string 
  chat_name: string 
  username: string
}

type UserListenerParams {
  location: string
}

service UserListener ( p : UserListenerParams ) {
/* this service is embedded within user.ol and it is in charge to receive messages from the chat registry */
  execution: concurrent

  embed Console as Console 

  inputPort User {
    location: p.location
    protocol: sodep
    interfaces: UserInterface
  }

  init {
    println@Console("Running listener on location " + p.location )()
  }

  main {
    setMessage( request );
        print@Console( request.username + "@" + request.chat_name + ":" )()
        println@Console( request.message )()
  }
}

service User ( p: UserParams ) {

  embed UserListener( { location = p.location } ) 
  embed Console as Console 

  inputPort ConsoleInputPort {
	  location: "local"
	  interfaces: ConsoleInputInterface
	}

  outputPort ChatRegistry {
    location: "socket://localhost:9000"
    protocol: sodep
    interfaces: ChatRegistryInterface
  }

  init {
    registerForInput@Console()()
    println@Console("Started a user client for username:" + p.username )()
    println@Console("Type `stop` for exiting")()
  }

  main {
      add_req << {
          chat_name = p.chat_name
          username = p.username
          location = p.location
      }
      addChat@ChatRegistry( add_req )( add_res )
      println@Console("Added to chat:" + p.chat_name )()
      token = add_res.token;
      while( text != "stop" ) {
          in( text )
          sendMessage@ChatRegistry( { token = token, message = text } )()
      }
  }
}
