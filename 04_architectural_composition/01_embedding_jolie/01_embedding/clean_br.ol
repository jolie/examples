include "CleanBrInterface.iol"
include "string_utils.iol"

execution{ concurrent }

inputPort CleanBr {
  Location: "local"
  Protocol: sodep
  Interfaces: CleanBrInterface
}

main {
    cleanBr( request )( response ) {
        replaceAll@StringUtils( request { .regex="<br>", .replacement="\n" })( request );
        replaceAll@StringUtils( request { .regex="</br>", .replacement="\n" })( response )
    }
}
