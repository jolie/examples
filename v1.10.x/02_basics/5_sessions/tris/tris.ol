from TrisGameInterface import TrisGameInterface 
from UserInterface import UserInterface
from runtime import Runtime
from console import Console 

from TrisGameInterface import MoveRequest


cset {
    token: MoveRequest.game_token
}

private type InitiateGameRequest: void {
    .game_token: string
    .circle_participant: string {
        .location: string
    }
    .cross_participant: string {
        .location: string
    }
}

private interface InternalInterface {
  OneWay:
    initiateGame( InitiateGameRequest )
}


service Tris {

    embed Console as Console
    embed Runtime as Runtime

    execution: concurrent


    outputPort User {
        protocol: sodep
        interfaces: UserInterface
    }

    outputPort MySelf {
        interfaces: InternalInterface
    }

    inputPort Local {
        location: "local"
        protocol: sodep
        interfaces: InternalInterface
    }

    inputPort Tris {
        location: "socket://localhost:9000"
        protocol: sodep
        interfaces: TrisGameInterface
    }

    define checkVictory {
        /* check the rows */
        for ( r = 0, r < 3, r++ ) {
            if ( (places[0+(3*r)] + places[1+(3*r)] + places[2+(3*r)]) == 3 ) { circle_wins = true }
            if ( (places[0+(3*r)] + places[1+(3*r)] + places[2+(3*r)]) == -3 ) { cross_wins = true }
        }
        /* check the columns */
        for( c = 0, c < 3, c++ ) {
            if ( (places[c]+places[c+3]+places[c+6]) == 3 ) { circle_wins = true }
            if ( (places[c]+places[c+3]+places[c+6]) == -3 ) { cross_wins = true }
        }
        /* check diagonal */
        if ( (places[0]+places[4]+places[8]) == 3 ) { circle_wins = true }
        if ( (places[0]+places[4]+places[8]) == -3 ) { cross_wins = true }
        if ( (places[2]+places[4]+places[6]) == 3 ) { circle_wins = true }
        if ( (places[2]+places[4]+places[6]) == -3 ) { cross_wins = true }

        /* send final messages */
        if ( !circle_wins && !cross_wins ) {
            circle_message = cross_message = "Nobody wins"
        } else {
            if ( circle_wins ) {
                circle_message = "You win!"
                cross_message = "You loose!"
            } else {
                cross_message = "You win!"
                circle_message = "You loose!"
            }
            
            usr.places -> places
            usr.status_game = "end"
            User.location = circle_participant.location
            usr.message = circle_message
            syncPlaces@User( usr )
            User.location = cross_participant.location
            usr.message = cross_message
            syncPlaces@User( usr )
        }
    }

    init {
        getLocalLocation@Runtime()( MySelf.location )
    }

    main {
    [ initiateGame( request ) ] {
        csets.token = request.game_token
        circle_participant = request.circle_participant
        circle_participant.location = request.circle_participant.location
        cross_participant = request.cross_participant
        cross_participant.location = request.cross_participant.location
        for( i = 0, i < 9, i++ ) { places[i] = 0 }

        /* send start messages */
        User.location = cross_participant.location
        usr.places -> places; usr.message = "Wait for a move from circle player"
        usr.status_game = "stay"
        syncPlaces@User( usr )
        User.location = circle_participant.location
        usr.status_game = "play"
        usr.message = "It is your turn to play"
        syncPlaces@User( usr )

        /* start game */
        moves = 0; circle_wins = false; cross_wins = false
        while( moves < 9 && !circle_wins && !cross_wins ) {
            /* waiting for a move */
            scope( move ) {
                install( MoveNotAllowed => nullProcess )
                move( mv_request )() {
                    /* check if the place is empty */
                    if ( places[ mv_request.place ] != 0 ) { throw( MoveNotAllowed, "The place is already occupied")}

                    /* check the turn */
                    if ( (moves%2) == 0 ) {
                        /* circle move */
                        if ( mv_request.participant_token != circle_participant ) {
                            throw( MoveNotAllowed, "It is not your turn" )
                        } else {
                            places[ mv_request.place ] = 1
                            User.location = circle_participant.location
                            usr.places -> places; usr.message = "Wait for a move from cross player"
                            usr.status_game = "stay"
                            syncPlaces@User( usr )
                            User.location = cross_participant.location
                            usr.message = "It is your turn to play"
                            usr.status_game = "play"
                            syncPlaces@User( usr )
                        }
                    } else {
                        /* cross move */
                        if ( mv_request.participant_token != cross_participant ) {
                            throw( MoveNotAllowed, "It is not your turn" )
                        } else {
                            places[ mv_request.place ] = -1
                            User.location = cross_participant.location
                            usr.places -> places; usr.message = "Wait for a move from circle player"
                            usr.status_game = "stay"
                            syncPlaces@User( usr )
                            User.location = circle_participant.location
                            usr.status_game = "play"
                            usr.message = "It is your turn to play"
                            syncPlaces@User( usr )
                        }
                    }
                }
                
                moves++
                checkVictory
            }
        }
        ;
        if ( !circle_wins && ! cross_wins ) {
            usr.places -> places
            usr.status_game = "end"
            User.location = circle_participant.location
            usr.message = ""
            syncPlaces@User( usr )
            User.location = cross_participant.location
            usr.message = ""
            syncPlaces@User( usr )
        }
    }

    [ listOpenGames( request )( response ) {
        count = 0
        foreach( g : global.games ) {
            response.game_token[ count ] = g
            count++
        }
    }]

    [ startGame( request )( response ) {
        new_game = false
        if ( !is_defined( global.games.( request.game ) ) ) {
            new_game = true
            token = new
            global.games.( token ) = true
            global.games.( token ).circle_participant = new
            global.games.( token ).circle_participant.location = request.user_location
            global.games.( token ).cross_participant = new
            response.game_token = token
            response.role_token = global.games.( token ).circle_participant
            response.role_type = "circle"
        } else {
            response.game_token = request.game
            response.role_token = global.games.( request.game ).cross_participant
            global.games.( request.game ).cross_participant.location = request.user_location
            response.role_type = "cross"
        }
    }] {
            if ( !new_game ) {
                initiate_request << {
                    game_token = request.game
                    circle_participant = global.games.( request.game ).circle_participant
                    circle_participant.location = global.games.( request.game ).circle_participant.location
                    cross_participant = global.games.( request.game ).cross_participant
                    cross_participant.location = global.games.( request.game ).cross_participant.location
                }
                initiateGame@MySelf( initiate_request )
                undef( global.games.( request.game ) )
            }
        }
    }
}