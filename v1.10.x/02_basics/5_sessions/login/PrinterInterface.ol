type LoginRequest {
	name: string
}

type Message {
	sid: string
	message?: string
}

interface PrinterInterface {
	RequestResponse: login( LoginRequest )( Message )
	OneWay: print( Message ), logout( Message )
}