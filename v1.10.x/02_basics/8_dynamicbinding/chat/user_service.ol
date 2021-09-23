include "UserInterface.iol"
include "console.iol"

/* this service is embedded within user.ol and it is in charge to receive messages from the chat registry */
execution{ concurrent }

inputPort User {
  Location: LOCATION
  Protocol: sodep
  Interfaces: UserInterface
}

main {
    setMessage( request );
        print@Console( request.username + "@" + request.chat_name + ":" )();
        println@Console( request.message )()
}
