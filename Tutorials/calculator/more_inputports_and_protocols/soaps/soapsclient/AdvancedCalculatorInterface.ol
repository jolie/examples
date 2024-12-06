
type NOTATIONType:any

type average:void {
	.term*:int
}

type percentageResponse:void {
	.result:double
	.advertisement:string
}

type factorial:void {
	.term:int
}

type percentage:void {
	.percentage:double
	.term:double
}

type averageResponse:void {
	.average:double
	.advertisement:string
}

type factorialResponse:void {
	.factorial:long
	.advertisement:string
}

interface AdvancedCalculatorPortSOAP {
RequestResponse:
	average(average)(averageResponse),
	factorial(factorial)(factorialResponse),
	percentage(percentage)(percentageResponse)
}

outputPort AdvancedCalculatorPortSOAPServicePort {
Location: "socket://localhost:8002"
Protocol: soap {
	.debug = 1;
	.debug.showContent = 1;
	.ssl.trustStore = "../keystore.jks",
	.ssl.trustStorePassword = "jolie!";
	.wsdl = "file:/home/claudio/Sviluppo/examples/v1.10.x/tutorials/more_inputports_and_protocols/soaps/soapsclient/AdvancedCalculator.wsdl";
	.wsdl.port = "AdvancedCalculatorPortSOAPServicePort"
}
Interfaces: AdvancedCalculatorPortSOAP
}


