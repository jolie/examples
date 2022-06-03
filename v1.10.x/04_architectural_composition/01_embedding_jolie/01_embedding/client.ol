from CleanDivInterface import CleanDivInterface
from console import Console


service Client {

	embed Console as Console 
	
	outputPort CleanDiv {
		Location: "socket://localhost:9000"
		Protocol: sodep
		Interfaces: CleanDivInterface
	}

	main
	{
		div = "<div>This is an example of embedding<br>try to run the encoding_div.ol<br>and watch the result.</div>";
		println@Console("String to be cleaned:" + div )()
		cleanDiv@CleanDiv( div )( clean_string )
		println@Console()()
		println@Console( "String cleaned:" + clean_string )()
	}
}
