type AuthenticateRequest: void {
    .credentials: void {
        .username: string
        .password: string
    }
    .auth_token:string
}
type AuthenticateResponse: void {
    .session_id: string
    .get_result_location: string
}

type OpenAuthenticationRequest: void {
    .application_name: string
}
type OpenAuthenticationResponse: void {
    .auth_token: string
    .identity_provider_location: string
}


interface IdentityProviderInterface {
   RequestResponse:
      authenticate( AuthenticateRequest )( AuthenticateResponse ),
      openAuthentication( OpenAuthenticationRequest )( OpenAuthenticationResponse )
          throws ApplicationNotEnabled
}
