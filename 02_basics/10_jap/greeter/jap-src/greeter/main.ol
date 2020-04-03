execution { concurrent }

include "interfaces/GreeterAPI.iol"

inputPort GreeterInput {
location: "local"
interfaces: GreeterAPI
}

main
{
	greet( name )( "Hello, " + name )
}