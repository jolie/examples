include "console.iol"
include "interface.iol"

outputPort PrintService {
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: PrintInterface
}

init {
	registerForInput@Console()()
}

main
{
	print@Console( "Insert your name: " )();
	in( request.name );
	keepRunning = true;
	login@PrintService( request )( response );
	opMessage.sid = response.sid;
	println@Console( "Server Responded: " + response.message + "\t sid: "+opMessage.sid )();
	while( keepRunning ){
		print@Console( "Insert a message or type \"logout\" for logging out > " )();
		in(  opMessage.message );
		if( opMessage.message != "logout" ){
			print@PrintService( opMessage )
		} else {
			logout@PrintService( opMessage );
			keepRunning = false
		}
	}
}
