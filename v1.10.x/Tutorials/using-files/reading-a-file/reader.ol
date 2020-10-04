/* file.iol is the service which provides operations for dealing with files available in the standard library of Jolie */
include "file.iol"
include "console.iol"

main {
    request.filename = "test.txt"
    readFile@File( request )( response )
    println@Console( response )()
}