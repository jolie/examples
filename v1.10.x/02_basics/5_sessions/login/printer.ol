from PrinterInterface import PrinterInterface
from PrinterInterface import Message	// we need to import also type Message to be used in the cset
from console import Console


/* here we define the correlation set we will use for correlating messages inside the same session */
cset {
	/* sid is the variable used inside the session to identify the correlation set.
	   The values which come from messages whose type is OpMessage and the node is .sid will be stored
	   inside variable sid as identification key */
	sid: Message.sid
}

service Printer {

	embed Console as Console 

	execution: concurrent 

	inputPort PrintService {
		location: "socket://localhost:2000"
		protocol: sodep
		interfaces: PrinterInterface
	}

	init {
		keepRunning = true
	}

	main
	{
		/* here the session starts with the login operation  */
		login( request )( response ){
			username = request.name
			/* here we generate a fresh token for correlation set sid */
			response.sid = csets.sid = new
			response.message = "You are logged in."
		}
		while( keepRunning ){
			/* both print and logout operations receives message of type OpMessage,
			thus they can be correlated on sid node */
			[ print( request ) ]{
				println@Console( "User "+username+" writes: "+request.message )()
			}
			[ logout( request ) ] {
				println@Console("User "+username+" logged out.")();
				keepRunning = false }
		}
	}
}
