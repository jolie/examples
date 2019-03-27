type AuthenticationResult: void {
    .auth_token: string
}

interface ApplicationAdminInterface {
  RequestResponse:
      success( AuthenticationResult )( void ),
      failure( AuthenticationResult )( void )
}
