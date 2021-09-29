type AuthenticationResult {
    auth_token: string
}
type SessionId {
    session_id: string 
}

interface ApplicationAdminInterface {
  RequestResponse:
      success( AuthenticationResult )( SessionId ),
      failure( AuthenticationResult )( void )
}
