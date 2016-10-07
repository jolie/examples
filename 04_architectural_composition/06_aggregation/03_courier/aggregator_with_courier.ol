include "fax.iol"
include "locations.iol"
include "console.iol"

execution { concurrent }

type AuthenticationData: void {
    .key:string
}

/* this a type extender which extends all the RequestResponse of a given interface with
   type AuthenticationData in case of request message, no types in case of response messages
   and, finally, it adds fault KeyNotValid */
interface extender AuthInterfaceExtender {
	RequestResponse:
	    *( AuthenticationData )( void ) throws KeyNotValid
}

interface AggregatorInterface {
RequestResponse:
    get_key(string)(string)
}

outputPort Fax {
	Interfaces: FaxInterface
}

embedded {
  Jolie:
    "fax.ol" in Fax
}

inputPort Aggregator {
	Location: Location_Aggregator
	Protocol: sodep
	Interfaces: AggregatorInterface
  /* here we aggregates the outputPort Fax extended using the extender AuthInterfaceExtender
     thus all the interfaces of the Fax outputPort (FaxInterface) will be extended using
     the AuthInterfaceExtender */
	Aggregates: Fax with AuthInterfaceExtender
}

/* this courier will be applied to inputPort Aggregator */
courier Aggregator {
  /* all the RequestResponse of interface FaxInterface will be pre-processed by the following code */
	[ interface FaxInterface( request )( response ) ] {
        if ( key == "1111" ){
          /* if the key is ok, the incoming message will be forwarded to the target port (Fax) */
        	forward ( request )( response )
        } else {
          /* the courier session can reply with a fault without forwarding the message to the target port */
          throw( KeyNotValid )
        }
    }
}

main
{
    get_key( username )( key ) {
    	if ( username == "homer" ) {
    		key = "1111"
        } else {
            key = "XXXX"
        }
    }
}
