type AuthenticateRequest {
    credentials {
        username: string
        password: string
    }
    auth_token:string
}
type AuthenticateResponse {
    session_id: string
    get_result_location: string
}

type OpenAuthenticationRequest {
    application_name: string
}
type OpenAuthenticationResponse {
    auth_token: string
    identity_provider_location: string
}


interface IdentityProviderInterface {
   RequestResponse:
      authenticate( AuthenticateRequest )( AuthenticateResponse ),
      openAuthentication( OpenAuthenticationRequest )( OpenAuthenticationResponse )
          throws ApplicationNotEnabled
}
