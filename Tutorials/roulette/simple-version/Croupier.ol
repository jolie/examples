
from scheduler import Scheduler     // imported the Scheduler
from console import Console

from .Table import TableToCroupierInterface
from .Player import PlayerGameInterface

type CroupierParam {
    table_location: string
}

interface LocalInterface {
    OneWay:
        wakeUp( undefined )
}

service Croupier( p : CroupierParam ) {

    embed Console as Console
    embed Scheduler as Scheduler

    execution: concurrent


    outputPort Player {
        protocol: sodep
        interfaces: PlayerGameInterface
    }

    outputPort Table {
        location: p.table_location
        protocol: sodep
        interfaces: TableToCroupierInterface
    }

    inputPort Local {
        location: "local"
        interfaces: LocalInterface
    }

    init {
        setCallbackOperation@Scheduler( { operationName = "wakeUp" })  
        // setting cronjob
        setCronJob@Scheduler( {
            jobName = "bet"
            groupName = "roulette"
            cronSpecs << {
                    second = "0"
                    minute = "0/1"
                    hour = "*"
                    dayOfMonth = "*"
                    month = "*"
                    dayOfWeek = "?"
                    year = "*"
            }
        })()
        enableTimestamp@Console( true )()
    }

    main {

        [ wakeUp() ] {
            rienNeVaPlus@Table()( response )
            for( w in response.winners ) {
                Player.location = w.location_player
                undef( payout_req )
                payout_req << {
                    payout = w.payout
                    number = w.number
                }
                payout@Player( payout_req )
            }
            for( l in response.loosers ) {
                Player.location = l.location_player
                undef( lost_req )
                lost_req << {
                    lost = l.lost
                    number = l.number
                    winnerNumber = response.winningNumber
                }
                lost@Player( lost_req )
            }
        }
    }

}