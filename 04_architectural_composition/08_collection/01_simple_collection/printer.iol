type PrintRequest:void {
	.job:int
	.content:string
}

interface PrinterInterface {
OneWay:
	print(PrintRequest), del(int)
}
