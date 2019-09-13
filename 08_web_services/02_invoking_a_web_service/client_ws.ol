include "console.iol"
include "string_utils.iol"
include "generated_interface.iol"

main {
    with( request.person ) {
        .name = "Homer";
        .surname = "Simpsons"
    }
    getAddress@MyServiceSOAPPortServicePort( request )( response )
    valueToPrettyString@StringUtils( response )( s )
    println@Console( s )()
}