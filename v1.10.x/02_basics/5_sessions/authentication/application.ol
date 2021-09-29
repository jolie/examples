from ApplicationAdminInterface import ApplicationAdminInterface
from ApplicationInterface import ApplicationInterface
from IdentityProviderInterface import IdentityProviderInterface
from console import Console

// types used for csets
from IdentityProviderInterface import OpenAuthenticationResponse
from ApplicationAdminInterface import AuthenticationResult
from ApplicationInterface import GetResultRequest
from ApplicationInterface import PrintMessageRequest
from ApplicationInterface import ExitApplicationRequest


service Application {

  execution: concurrent

  cset {
    auth_token: OpenAuthenticationResponse.auth_token
                AuthenticationResult.auth_token
  }

  cset {
    session_id: GetResultRequest.session_id
                PrintMessageRequest.session_id
                ExitApplicationRequest.session_id
  }

  embed Console as Console
  
  outputPort IdentityProvider {
    location: "socket://localhost:10000"
    protocol: sodep
    interfaces: IdentityProviderInterface
  }

  inputPort ApplicationAdmin {
    location: "socket://localhost:10001"
    protocol: sodep
    interfaces: ApplicationAdminInterface
  }

  inputPort Application {
    location: "socket://localhost:10002"
    protocol: sodep
    interfaces: ApplicationInterface
  }

  init {
    application_name = "black death"
    install( LoginFailed => println@Console("Login attempt failed")() )
  }

  main {
      login( request )( response ) {
          open << {
              application_name = application_name
          }
          openAuthentication@IdentityProvider( open )( open_result )
          csets.auth_token = response.auth_token = open_result.auth_token
          response.identity_provider_location = open_result.identity_provider_location
      }
      
      /* result received from identity provider */
      sid.session_id = csets.session_id = new
      ;
      [ success()( sid ) {
          login_result = true
      }]
      [ failure()( sid ) {
          login_result = false
      }]
      
      /* received from the user */
      getResult( )( ) {
        if ( !login_result ) { throw( LoginFailed ) }
      }
      
      /* if the login has success, the application waits for commands */
      provide
        [ printMessage( print_request ) ] {
            println@Console("Message to print:" + print_request.message )()
        }
      until
        [ exitApplication( request ) ] {
            println@Console("Exiting from session " + request.session_id )()
        }
  }
}