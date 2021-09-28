from PrinterInterface import PrinterInterface
from console import Console
from console import ConsoleInputInterface


service Client {

	embed Console as Console 

	inputPort ConsoleInputPort {
	  location: "local"
	  interfaces: ConsoleInputInterface
	}

	outputPort PrintService {
		location: "socket://localhost:2000"
		protocol: sodep
		interfaces: PrinterInterface
	}

	init {
		registerForInput@Console()()
	}

	main
	{
		print@Console( "Insert your name: " )()
		in( request.name )
		keepRunning = true
		login@PrintService( request )( response )
		opMessage.sid = response.sid
		println@Console( "Server Responded: " + response.message + "\t sid: "+opMessage.sid )()
		while( keepRunning ){
			print@Console( "Insert a message or type \"logout\" for logging out > " )()
			in(  opMessage.message )
			if( opMessage.message != "logout" ){
				print@PrintService( opMessage )
			} else {
				logout@PrintService( opMessage )
				keepRunning = false
			}
		}
	}
}