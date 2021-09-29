from IdentityProviderInterface import IdentityProviderInterface 
from IdentityProviderInterface import AuthenticateRequest 
from ApplicationAdminInterface import ApplicationAdminInterface

constants {
    IDENTITY_PROVIDER_LOCATION = "socket://localhost:10000"
}

cset {
    auth_token: AuthenticateRequest.auth_token
}


service IdentityProvider {

    execution: concurrent 

    outputPort Application {
        protocol: sodep
        interfaces: ApplicationAdminInterface
    }

    inputPort IdentityProvider {
        location: IDENTITY_PROVIDER_LOCATION
        protocol: sodep
        interfaces: IdentityProviderInterface
    }

    define _check_application {
        application_enabled_flag = false
        for( a = 0, a < #enabled_applications, a++ ) {
            if ( request.application_name == enabled_applications[ a ] ) {
                application_enabled_flag = true
                application_id = a
            }
        }
        if ( !application_enabled_flag ) { throw( ApplicationNotEnabled ) }
    }

    define _check_credentials {
        auth = false
        for ( u = 0, u < #enabled_applications[ application_id ].user, u++ ) {
            user -> enabled_applications[ application_id ].user[ u ]
            if ( user.username == request.credentials.username && user.password == request.credentials.password ) {
                auth = true
            }
        }
    }

    init {
        /* here we simulate that applications have been already registered into the identity provider */
        enabled_applications[ 0 ] = "black death"
        with( enabled_applications[ 0 ] ) {
            .location = "socket://localhost:10001";
            .user[ 0 ].username = "jedi"; .user[ 0 ].password = "luke";
            .user[ 1 ].username = "darthvader"; .user[ 1 ].password = "father"
        }
        enabled_applications[ 1 ] = "rebellion"
        with ( enabled_applications[ 1 ] ) {
            .location = "socket://localhost:10100";
            .user[ 0 ].username = "jedi"; .user[ 0 ].password = "luke"
        }
    }

    main {
        [ openAuthentication( request )( response ) {
            _check_application
            response.auth_token = csets.auth_token = new
            response.identity_provider_location = IDENTITY_PROVIDER_LOCATION
        }] {
            /* here starts the session for managing authentication */
            authenticate( request )( response ) {
                undef( response )
                _check_credentials
                /* binding the outputPort of the application */
                Application.location = enabled_applications[ application_id ].location
                if ( auth ) {
                    success@Application( { .auth_token = csets.auth_token })( result )
                    session_id = result.session_id
                } else {
                    failure@Application( { .auth_token = csets.auth_token })( result )
                    session_id = result.session_id
                }
                /* sending the location where retrieving the result */
                with( response ) {
                    .get_result_location = enabled_applications[ application_id ].location;
                    .session_id = session_id
                }
            }
        }
    }
}
