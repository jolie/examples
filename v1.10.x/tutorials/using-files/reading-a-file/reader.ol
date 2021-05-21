/* file.iol is the service which provides operations for dealing with files available in the standard library of Jolie */
from file import File
from console import Console

service Example {

    embed Console as console
    embed File as file


    main {

        readFile@file( { filename = "test.txt"} )( response )
        println@console( response )()
    }


}
