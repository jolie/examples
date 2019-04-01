include "CleanBrInterface.iol"
include "CleanDivInterface.iol"

include "string_utils.iol"

execution{ concurrent }

outputPort CleanBr {
  Interfaces: CleanBrInterface
}

embedded {
  Jolie:
    "clean_br.ol" in CleanBr
}

inputPort CleanDiv {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: CleanDivInterface
}

main {
    cleanDiv( request )( response ) {
        replaceAll@StringUtils( request { .regex="<div>", .replacement="" })( request );
        replaceAll@StringUtils( request { .regex="</div>", .replacement="\n" })( request );
        cleanBr@CleanBr( request )( response )
    }
}
