include "ServerInterface.iol"

include "console.iol"
include "time.iol"

outputPort Server {
Location:"socket://localhost:10000"
Protocol: sodep
Interfaces: ServerInterface
}

main {
  scope( main_scope ) {
    install( default => println@Console("Received fault " + main_scope.default )();comp( calling ) )
    ;
    {
        scope( calling ) {
            install( this => println@Console( "Before calling" )() );
            hello@Server("hello")( response )
            [
                  this => println@Console("Installed Solicit-response handler")()
            ]
        }
        |
        {
          sleep@Time( int( args[0]) )();
          println@Console("Raising a fault...")();
          throw( Fault )
        }
    }
  }
}
