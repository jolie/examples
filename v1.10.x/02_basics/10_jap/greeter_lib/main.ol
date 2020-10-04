include "console.iol"

include "greeter/interfaces/GreeterAPI.iol"

outputPort Greeter { interfaces: GreeterAPI }

embedded {
Jolie: "greeter/main.ol" in Greeter
}

main
{
	greet@Greeter( "Jolie" )( greeting )
	println@Console( greeting )()
}
