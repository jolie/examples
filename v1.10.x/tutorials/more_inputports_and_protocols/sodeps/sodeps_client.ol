from AdvancedCalculatorServiceInterfaceModule import AdvancedCalculatorInterface
from console import *
from string_utils import StringUtils

service SodepClient {
    outputPort AdvancedCalculatorService {
        location: "socket://localhost:8006"
        protocol: sodeps {
            ssl.trustStore = "truststore.jks",
            ssl.trustStorePassword = "jolie!"
        }
        interfaces: AdvancedCalculatorInterface
    }

    inputPort ConsoleInputPort {
        location: "local"
        interfaces: ConsoleInputInterface
    }

    embed Console as Console
    embed StringUtils as StringUtils

    init {
        registerForInput@Console()()
    }

    main {
        println@Console("Select the operation to call:")()
        println@Console("1- factorial")()
        println@Console("2- percentage")()
        println@Console("3- average")()
        print@Console("? ")()

        in( answer )
        if ( (answer != "1") && (answer != "2") && (answer != "3") ) {
            println@Console("Please, select 1, 2 or 3")()
            throw( Error )
        }

        if ( answer == "1" ) {
            println@Console( "Enter an integer")()
            in( term )
            factorial@AdvancedCalculatorService( { term = int( term ) } )( factorial_response )
            println@Console( "Result: " + factorial_response.factorial )()
            println@Console( factorial_response.advertisement )()
        }
        if ( answer == "2" ) {
            println@Console( "Enter a double")()
            in ( term )
            println@Console( "Enter a percentage to be calculated")()
            in ( percentage )
            percentage@AdvancedCalculatorService( { term = double( term ), percentage = double( percentage ) } )( percentage_response )
            println@Console( "Result: " + percentage_response.result )()
            println@Console( percentage_response.advertisement )()
        }
        if ( answer == "3" ) {
            println@Console("Enter a list of integers separated by commas")()
            in( terms )
            split@StringUtils( terms { regex = ","} )( splitted_terms )
            for( t in splitted_terms.result ) {
                req_average.term[ #req_average.term ] = int( t )
            }
            average@AdvancedCalculatorService( req_average )( average_response )
            println@Console( "Result: " + average_response.average )()
            println@Console( average_response.advertisement )()
        }
    }
 }