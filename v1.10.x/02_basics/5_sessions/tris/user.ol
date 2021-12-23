from TrisGameInterface import TrisGameInterface 
from UserInterface import UserInterface
from console import ConsoleInputInterface
from console import Console 

type UserParameter {
    location: string
}

service User ( p : UserParameter ) {

    embed Console as Console

    outputPort TrisGame {
        location: "socket://localhost:9000"
        protocol: sodep
        interfaces: TrisGameInterface
    }

    inputPort ConsoleInputPort {
	  location: "local"
	  interfaces: ConsoleInputInterface
	}
    
    inputPort User {
        location: p.location
        protocol: sodep
        interfaces: UserInterface
    }

    define drawMap {
        for( i = 0, i < 9, i++ ) {
            if ( i%3 == 0 ) { println@Console("-----------")() }
            if ( sync_req.places[ i ] == 0 ) {
                place_content = " "
            };
            if ( sync_req.places[ i ] == 1 ) {
                place_content = "O"
            };
            if ( sync_req.places[ i ] == -1 ) {
                place_content = "X"
            };
            print@Console( " " + place_content + " " )()
            if ( (i%3 == 0) || (i%3 == 1) ) { print@Console("|")() }
            if ( i%3 == 2 ) { println@Console()() }
        }
    }

    init {
        registerForInput@Console()()
    }

    main {
        listOpenGames@TrisGame()( list_games )
        /* play with the first game if it exists, otherwise create a new game */
        if ( #list_games.game_token > 0 ) {
            strt_req.game = list_games.game_token[ 0 ]
        }
        strt_req.user_location = p.location
        startGame@TrisGame( strt_req )( game )
        end_game = false
        while( !end_game ) {
            syncPlaces( sync_req )
                drawMap
                println@Console( sync_req.message )()
                if ( sync_req.status_game != "end" ) {
                    if ( sync_req.status_game == "play" ) {
                        made_move = false
                        while( !made_move ) {
                            scope( move ) {
                                install( MoveNotAllowed => println@Console( move.MoveNotAllowed )() )
                                print@Console("Insert the place you want to set (from 0 to 8, counting from left top corner to thebottom right one):")()
                                [ in( answer ) ] {
                                    println@Console()()
                                    mv << {
                                        game_token = game.game_token
                                        participant_token = game.role_token
                                        place = int( answer )
                                    }
                                    move@TrisGame( mv )()
                                    made_move = true
                                }

                                [ syncPlaces( sync_req ) ] {
                                    if ( sync_req.status_game == "end" ) {
                                        end_game = true
                                        println@Console()()
                                        println@Console( sync_req.message )()
                                        made_move = true
                                    }
                                }
                            }
                        }
                    }
                } else {
                    end_game = true
                }
        }
    }
}
