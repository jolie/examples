from scheduler import Scheduler     // imported the Scheduler
from console import Console
from time import Time
from math import Math

from .Table import TableToPlayerInterface

type PlayerCallBackRequest: void {
    .jobName: string
    .groupName: string
}

type PayoutRequest: void {
    payout: int
    number: int
}

type LostRequest: void {
    lost: int
    number: int
    winnerNumber: int
}



interface PlayerCallBackInterface {
    OneWay:
    playerCallBack( PlayerCallBackRequest )     // definition of the call-back operation
}

interface PlayerGameInterface {
    RequestResponse:
        check( void )( void )
    OneWay:
        payout( PayoutRequest ),
        lost( LostRequest )
}

type PlayerServiceParam {
    location {
        this: string 
        table: string 
    }
    player {
        name: string
        wallet: int
    }
}

service Player( p: PlayerServiceParam ) {

    embed Time as Time
    embed Scheduler as Scheduler 
    embed Console as Console
    embed Math as Math


    execution: concurrent

    outputPort TablePort {
        location: p.location.table
        protocol: sodep
        interfaces: TableToPlayerInterface
    }

    // internal input port for receiving alarms from Scheduler
    inputPort MySelf {
        location: "local"
        interfaces: PlayerCallBackInterface
    }

    inputPort PlayerGamePort {
        location: p.location.this
        protocol: sodep
        interfaces: PlayerGameInterface
    }

    init {
        enableTimestamp@Console( true )()
        // setting the name of the callback operation
        setCallbackOperation@Scheduler( { operationName = "playerCallBack" })  
        // setting cronjob
        setCronJob@Scheduler( {
            jobName = "bet"
            groupName = "roulette"
            cronSpecs << {
                    second = "*/5"
                    minute = "*"
                    hour = "*"
                    dayOfMonth = "*"
                    month = "*"
                    dayOfWeek = "?"
                    year = "*"
            }
        })()
        enableTimestamp@Console( true )()
        global.player = p.player.name
        global.wallet = p.player.wallet
        global.location = p.location.this
        println@Console("Player: " + global.player + " enabled on " + PlayerGamePort.location)()
    }

    main {
        [ playerCallBack( request ) ] {
                // generate a straight up bet
                // number
                random@Math()( temp )
                number = int( temp * 37 )
                // amount
                random@Math()( temp )
                amount = int( temp * 100 )

                // senfing bet to table
                bet_req << {
                    player = global.player
                    amount = amount
                    number = number
                    player_location = global.location 
                }
                synchronized( wallet ) {  
                    println@Console( "Player " + global.player + " is trying to send straight up bet on number " + number + ", amount: " + amount )()
                    if ( ( global.wallet - amount )  > 0 ) {
                        scope( bet ) {
                            global.wallet = global.wallet - amount
                            install( default => 
                                    global.wallet = global.wallet + amount 
                                    println@Console("Error received from Table " + bet.( bet.( default) ) )()
                            )
                            straightUpBet@TablePort( bet_req )( response )
                            println@Console( "Table reply " + response )()
                        }
                    } else {
                        println@Console(  "Player " + global.player + " skipped bet because wallet is low (" + global.wallet + ")" )()
                    }
                }
                
        }


        [ payout( request ) ] {
            synchronized( wallet ) {
                global.wallet = global.wallet + request.payout
            }
            println@Console( "Payout " + request.payout + ", for number " + request.number + " =>> current wallet " + global.wallet )()        
        }

        [ lost( request ) ] {
            println@Console( "Lost " + request.amount + "! The winner number is " + request.winnerNumber + ", your number was " + request.number + " =>> current wallet " + global.wallet )()        
        }

        [ check()() { nullProcess } ]
    }
}