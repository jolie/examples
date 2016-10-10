include "AggregatorSurface.iol"
include "console.iol"

init {
  install( KeyNotValid => println@Console("This key is not valid!")() )
}

main {
  if ( #args == 0 ) {
    println@Console("Usage: jolie client.ol USERNAME")()
  } else {
    get_key@Aggregator( args[ 0 ] )( key );
    println@Console("The key for username " + args[0] + " is " + key )();
    with( rq_fax ) {
        .destination = "My Destination";
        .content = "My Message";
        .key = key
    };
    fax@Aggregator( rq_fax )()
  }

}
