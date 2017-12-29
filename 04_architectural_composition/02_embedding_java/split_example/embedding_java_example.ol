include "console.iol"

type Split_req: void{
	.string: string
	.regExpr: string
}

type Split_res : void{
	.s_chunk*: string
}

/* this is the interface which describes the methods of class example.Splitter which will be invoked as operations
inside this service's behaviour */
interface SplitterInterface {
	RequestResponse: 	split( Split_req )( Split_res )
}

/* this is the interface which describes the methods of class example.JavaExample which will be invoked as operations
inside this service's behaviour */
interface MyJavaExampleInterface {
	OneWay: start( void )
}

/* this outputPort will be used in the behaviour for communicating with class example.Splitter */
outputPort Splitter {
	Interfaces: SplitterInterface
}

/* this outputPort will be used in the behaviour for communicating with class example.JavExample */
outputPort MyJavaExample {
	Interfaces: MyJavaExampleInterface
}

/* this the inputPort of this service.
It is worth noting that it is not a public inputPort because
its location is set to 'local'. Thus it can olnly receive messages
from the memory => only from the embedded JavaServices */
inputPort Embedder {
	Location: "local"
	/* the interface it is the same of the interface bound to the JavaService example.Splitter.
	This is why the implementation of the split operation just receives a message and then forwards it
	to the corresponding method of the example.Splitter JavaService */ 
	Interfaces: SplitterInterface
}

embedded {
	/* all the jars which contains javaServices must be placed in the folder ./lib */
	Java:
			/* here we embed the class example.Splitter.class that is stored in file ./lib/lib.jar */
			"example.Splitter" in Splitter,
			/* here we embed the class example.JavaExample.class that is stored in file ./lib/lib.jar */
			"example.JavaExample" in MyJavaExample
}

main
{
	/* here we call the class example.JavaExample on method start */
	start@MyJavaExample();

	/* here we are waiting for a message from class example.JavaExample */
	split( split_req )( split_res ){
		/* Before replying, here we invoke the other embedded class example.Splitter */
		split@Splitter( split_req )( split_res )
	}
}
