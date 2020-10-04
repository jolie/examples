include "console.iol"
include "time.iol"

init {
    /* this install disables the interpreter output message in case of FaultName */
    install( FaultName => nullProcess )
}

main
{
  scope( example_scope )
	{
		install( this =>
        println@Console( "initiating recovery" )()
    );
		i = 1;
		while( true ){
      /* we are updating the termination handler by adding a new println@Console activity */
			install( this =>
				cH;
        /* we freeze the value of variable i at the moment of the installation of the handler with operatori ^ì */
				println@Console( "recovering step" + ^i )()
			);
			i++;
      print@Console( i + "," )();
      sleep@Time( 5 )()
		}
	}
	|
  {
    /* the fault will terminate the sibling scope example_scope. The example_scope will execute its termination handler */
    sleep@Time( 200 )();
	  throw( FaultName )
  }
}
