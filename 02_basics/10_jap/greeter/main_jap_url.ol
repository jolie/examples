include "console.iol"

include "jap:file:greeter.jap!/greeter/interfaces/GreeterAPI.iol"
// include "jap-src/greeter/interfaces/GreeterAPI.iol"

outputPort Greeter { interfaces: GreeterAPI }

embedded {
Jolie: "greeter.jap" in Greeter
}

main
{
	greet@Greeter( "Jolie" )( greeting )
	println@Console( greeting )()
}