type ListOpenGamesRequest: void
type ListOpenGamesResponse {
    game_token*: string
}

type MoveRequest {
    game_token: string
    participant_token: string
    place: int
}

type StartGameRequest {
    game?: string
    user_location: string
}
type StartGameResponse {
    game_token: string
    role_token: string
    role_type: string
}

interface TrisGameInterface {
  RequestResponse:
    listOpenGames( ListOpenGamesRequest )( ListOpenGamesResponse ),
    move( MoveRequest )( void ) throws MoveNotAllowed( string ),
    startGame( StartGameRequest )( StartGameResponse )

}
