type LoginRequest: void

type LoginResponse {
    auth_token: string
    identity_provider_location: string
}

type ExitApplicationRequest {
    session_id: string
}

type GetResultRequest {
    session_id: string
}

type PrintMessageRequest {
    session_id: string
    message: string
}

interface ApplicationInterface {
  RequestResponse:
    login( LoginRequest )( LoginResponse ),
    getResult( GetResultRequest )( void ) throws LoginFailed
  OneWay:
    exitApplication( ExitApplicationRequest ),
    printMessage( PrintMessageRequest )
}
