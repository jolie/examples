include "console.iol"

main
{
  /* main is the parent scope where the following fault handler is installed */
	install( FaultName =>
		            println@Console( "Fault handler for a_fault" )();
                /* comp runs the compensation handler of scope example_scope if present */
		            comp( example_scope )
	);


  /* example_scope is a child scope defined inside scope main */
	scope( example_scope )
	{
    /* installing of the termination handler dor scope example_scope */
		install( this => println@Console( "recovering step 1" )() );
		println@Console( "Executing code of example_scope" )();
    /* updating of the termination handler for scope example_scope */
    
		install( this => cH; println@Console( "recovering step 2" )() )
    /* since there are no more activities, the example_scope is finsihed with success
    and its current termination handler is promoted to the parent scope (main)
    as a compensation handler */
	};
  println@Console("example_scope is finished with success, now throwing faul FaultName...")();
	throw( FaultName )
}
