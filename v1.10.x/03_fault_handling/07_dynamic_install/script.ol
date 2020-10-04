include "console.iol"
include "time.iol"

init {
    /* this install disables the interpreter output message in case of FaultName */
    install( FaultName => nullProcess )
}


main
{
	scope( scope_name )
	{
		println@Console( "step 1" )();
		install( this => println@Console( "recovery step 1" )() );
    /* the current recovery handler of scope scope_name is now println@Console( "recovery step 1" )() */

		sleep@Time( 100 )();
		println@Console( "step 2" )();
		install( this => println@Console( "recovery step 2" )() );
    /* the current recovery handler of scope scope_name is now println@Console( "recovery step 2" )() */

		sleep@Time( 200 )();
		println@Console( "step 3" )();
		install( this => println@Console( "recovery step 3" )() );
    /* the current recovery handler of scope scope_name is now println@Console( "recovery step 3" )() */

		sleep@Time( 300 )();
		println@Console( "step 4" )();
		install( this => println@Console( "recovery step 4" )() )
    /* the last recovery handler of scope scope_name is now println@Console( "recovery step 4" )() */
	}
	|
  /* try to modify the sleep time in order to change the interrupt moment */
	sleep@Time( 300 )();
	throw( FaultName )
}
