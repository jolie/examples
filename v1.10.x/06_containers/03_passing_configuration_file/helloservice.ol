include "file.iol"

interface HelloInterface {

RequestResponse:
     hello( string )( string )
}

execution{ concurrent }


inputPort Hello {
Location: "socket://localhost:8000"
Protocol: sodep
Interfaces: HelloInterface
}

init {
  file.filename = "/var/temp/config.json";
  file.format = "json";
  readFile@File( file )( config )
}

main {
  hello( request )( response ) {
        response = config.welcome_message + "\n";
        for ( i = 0, i < config.repeat, i++ ) {
          response = response + request + " "
        }
  }
}
