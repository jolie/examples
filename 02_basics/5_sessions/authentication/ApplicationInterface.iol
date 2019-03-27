type LoginRequest: void

type LoginResponse: void {
    .auth_token: string
    .identity_provider_location: string
}

type ExitApplicationRequest: void {
    .session_id: string
}

type GetResultRequest: void {
    .session_id: string
}

type PrintMessageRequest: void {
    .session_id: string
    .message: string
}

interface ApplicationInterface {
  RequestResponse:
    login( LoginRequest )( LoginResponse ),
    getResult( GetResultRequest )( void ) throws LoginFailed
  OneWay:
    exitApplication( ExitApplicationRequest ),
    printMessage( PrintMessageRequest )
}
