include "console.iol"

/* this is the interface of the internal service */
interface TwiceInterface {
	RequestResponse: twice( int )( int )
}

/* internal services are a commodity for implementing microservice inner functions intead of
storing them in an external file and then embed it. In this case you don't need to declare
the outputPort but it is sufficient to use the keyword service and define the behaviour.
Differently from the statement 'define', internal services act exactly as a service,
thus each invocation enable a new session */
service TwiceService {
  Interfaces: TwiceInterface
  main {
    	twice( number )( result )
    	{
    		result = number * 2
    	}
  }
}

main
{
	/* here we are calling the internal service */
	twice@TwiceService( 5 )( response );
	println@Console( response )()
}
