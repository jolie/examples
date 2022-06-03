from CleanDivInterface import CleanDivInterface
from console import Console
from clean_div import CleanDiv


service Script {

	outputPort CleanDiv {
		Interfaces: CleanDivInterface
	}

	embed CleanDiv in CleanDiv
	embed Console as Console


	main
	{
		div = "<div>This is an example of embedding<br>try to run the encoding_div.ol<br>and watch the result.</div>"
		println@Console("String to be cleaned:" + div )()
		cleanDiv@CleanDiv( div )( clean_string )
		println@Console()()
		println@Console( "String cleaned:" + clean_string )()
	}
}
