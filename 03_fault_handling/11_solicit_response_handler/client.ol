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
    install( default => comp( calling ) )
    ;
    {
        scope( calling ) {
            install( this => println@Console( "Before calling" )() );
            hello@Server("hello")( response )
            [
                  this => println@Console("ciao")()
            ];
            install( this => cH; println@Console( "After calling" )() )
        }
        |
        {
          sleep@Time( 1000 )();
          println@Console("Raising a fault...")();
          throw( Fault )
        }
    }
  }
}
