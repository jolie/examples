include "console.iol"

main {
  scope ( myScope ){
    	install( MyFault =>
      		println@Console( "Caught MyFault, message: " + myScope.MyFault.msg )();
          println@Console( "Using keyword default it is possible to retrieve the name of the fault : "
            + myScope.default )();
          println@Console( "Using default and dynamic lookup it is possible to analyze the fault content")();
          foreach( node : myScope.( myScope.default ) ) {
            println@Console("Fault " + myScope.default + ", subnode " + node + ", content:" + myScope.( myScope.default ).( node ) )()
          }
    	);
    	faultMsg.msg = "This is all MyFault!";
    	throw( MyFault, faultMsg )
  }
}
