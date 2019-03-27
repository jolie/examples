type AuthenticationResult: void {
    .auth_token: string
}
type SessionId: void {
    .session_id: string 
}

interface ApplicationAdminInterface {
  RequestResponse:
      success( AuthenticationResult )( SessionId ),
      failure( AuthenticationResult )( void )
}
