include "ApplicationInterface.iol"
include "IdentityProviderInterface.iol"
include "console.iol"

outputPort IdentityProvider {
  Protocol: sodep
  Interfaces: IdentityProviderInterface
}

outputPort Application {
  Location: "socket://localhost:10002"
  Protocol: sodep
  Interfaces: ApplicationInterface
}

init {
  registerForInput@Console()();
  println@Console("Welcome to black_death remote console, please login...")()
}

main {
  login@Application()( login_response );
  IdentityProvider.location = login_response.identity_provider_location;
  auth_token = login_response.auth_token;
  print@Console("Insert username:")();
  in( username );
  print@Console("Insert password:")();
  in( password );
  with( auth_req ) {
     with( .credentials ) {
        .username = username;
        .password = password
     };
     .auth_token = auth_token
  };
  authenticate@IdentityProvider( auth_req )( auth_res );
  session_id = auth_res.session_id;
  scope( get_result ) {
      install( LoginFailed => println@Console("Login failed")());
      getResult@Application({ .session_id = session_id })();
      println@Console("Congratulation! Your logged in!")();
      println@Console("Now you can send messages to the black death, type 'exit' for exiting")();
      while( msg != "exit" ) {
          print@Console("?")();in( msg );
          printMessage@Application( { .session_id = session_id, .message = msg })
      };
      exitApplication@Application({ .session_id = session_id})
  }
}
