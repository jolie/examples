include "logger.iol"

include "locations.iol"
include "console.iol"

execution{ concurrent }

inputPort Logger {
  Location: Location_Logger
  Protocol: sodep
  Interfaces: LoggerInterface
}

init {
    enableTimestamp@Console( true )()
}

main {
    log( request );
    println@Console( request.content )()
}
