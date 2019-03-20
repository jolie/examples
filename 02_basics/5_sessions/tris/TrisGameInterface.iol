type ListOpenGamesRequest: void
type ListOpenGamesResponse: void {
    .game_token*: string
}

type MoveRequest: void {
    .game_token: string
    .participant_token: string
    .place: int
}

type StartGameRequest: void {
    .game?: string
    .user_location: string
}
type StartGameResponse: void {
    .game_token: string
    .role_token: string
    .role_type: string
}

interface TrisGameInterface {
  RequestResponse:
    listOpenGames( ListOpenGamesRequest )( ListOpenGamesResponse ),
    move( MoveRequest )( void ) throws MoveNotAllowed( string ),
    startGame( StartGameRequest )( StartGameResponse )

}
