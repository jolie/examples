from console import Console
from string_utils import StringUtils
from json_utils import JsonUtils
from math import Math

from .Player import PlayerGameInterface


type StraightUpBetRequest: void {
    player: string
    amount: int
    number: int
    player_location: string
}

type RienNeVaPlusResponse {
    winningNumber: int
    winners* {
        location_player: string 
        payout: int 
        number: int
    }
    loosers* {
        location_player: string 
        lost: int 
        number: int
    }
}

interface TableToPlayerInterface {
    RequestResponse:
        straightUpBet( StraightUpBetRequest )( string ) throws LocatioNotValid
}

interface TableToCroupierInterface {
    RequestResponse:
        rienNeVaPlus( void )( RienNeVaPlusResponse )
}



type TableServiceParam {
    locations {
        playerPort: string
        croupierPort: string
    }
}

service TableService( p : TableServiceParam ) {
    
    execution: concurrent

    embed Math as Math
    embed Console as Console
    embed JsonUtils as JsonUtils
    embed StringUtils as StringUtils

    inputPort PlayerPort {
        location: p.locations.playerPort
        protocol: sodep
        interfaces: TableToPlayerInterface
    }

    inputPort CroupierPort {
        location: p.locations.croupierPort
        protocol: sodep
        interfaces: TableToCroupierInterface
    }

    outputPort PlayerPort {
        protocol: sodep
        interfaces: PlayerGameInterface
    }

    init {
        println@Console("Service Table is running...")()
    }

    main {
        [ straightUpBet( request )( response ){
     
            scope( check_player ) {
                install( default => throw( LocatioNotValid))
                PlayerPort.location = request.player_location
                check@PlayerPort()()
                // synchronizing the bet so that it cannot be placed while the 'wheel is spinning'.
                synchronized( spinning ) {
                    global.db.bets.( request.player )[ #global.db.bets.( request.player ) ] << request
                }
                response = "Received straight up bet on number " + request.number + " for player " + request.player
                println@Console( response )()
            }
        }]

        [ rienNeVaPlus()( response ) {
            random@Math()( temp )
            winningNumber = response.winningNumber = int( temp * 37 )
            println@Console("winningNumber: ==> " + winningNumber )()
            synchronized( spinning ) {
                global.db.spin[ #global.db.spin ] = winningNumber
                foreach ( gioc : global.db.bets ) {
                    for ( bet in global.db.bets.( gioc ) ) {
                        if ( winningNumber == bet.number ){
                            response.winners[ #response.winners ] << {
                                location_player = bet.player_location
                                payout = bet.amount * 37
                                number = bet.number
                            }
                        } else {
                            response.loosers[ #response.loosers ] << {
                                location_player = bet.player_location
                                lost = bet.amount
                                number = bet.number
                            }
                        }
                    }
                }
                undef( global.db.bets )
            }
        }] {
            println@Console("Report after last run:")()
            valueToPrettyString@StringUtils( response )( s )
            println@Console( s )()
        }

    
    }
}

