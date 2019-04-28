include "authenticator.iol"

include "locations.iol"
include "time.iol"
include "console.iol"

execution { concurrent }

inputPort Authenticator {
  Location: Location_Authenticator
  /* for the sake of simplicity here we use sodep, try to replaceit with a security protocol like sodeps or https */
  Protocol: sodep
  Interfaces: AuthenticatorInterface
}


init {
   /* simulation of credentiual repository */
   global.credentials.client = "client_password";

   if ( #args == 0 ) {
     KEY_DURATION_IN_MILLIS = 5000
   } else {
     KEY_DURATION_IN_MILLIS = args[ 0 ]
   };
   println@Console("Key duration set to " + KEY_DURATION_IN_MILLIS )();
   println@Console("If you wnt to change it, relaunch this service specifying the key duration as service argument in milliseconds. ex: jolie authenticator.ol 15")()
}

main {
  [ getKey( request )( response ) {
      synchronized( token_generation ) {
          if ( global.credentials.( request.username ) == request.password ) {
              new_key = new;
              getCurrentTimeMillis@Time()( timestamp );
              global.valid_keys.( new_key ) = timestamp;
              response.key = new_key
          }
      }
  }]

  [ checkKey( request )( response ) {
      getCurrentTimeMillis@Time()( timestamp );
      if ( is_defined( global.valid_keys.( request.key )) ) {
          println@Console("Verifying expiration of key " + request.key )();
          println@Console("Milliseconds diff: " + (timestamp - global.valid_keys.( request.key )))();
          if ( (timestamp - global.valid_keys.( request.key )) > KEY_DURATION_IN_MILLIS ) {
             /* removing expired key */
             undef( global.valid_keys.( request.key ) );
             throw( KeyNotValid )
          }
      } else {
          throw( KeyNotValid )
      }
  }]
}
