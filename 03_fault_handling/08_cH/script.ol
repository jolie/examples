include "console.iol"
include "time.iol"

init {
    /* this install disables the interpreter output message in case of FaultName */
    install( FaultName => nullProcess )
}

main
{
	scope( scope_name ) {
		println@Console( "step 1" )();
		sleep@Time( 10 )();
		install( this => println@Console( "recovery step 1" )() )
    ;
		println@Console( "step 2" )();
		sleep@Time( 20 )();
		install( this =>
    /* here the previous installed handler is represented by the cH keyword
    that is composed in sequence with the extension */
                     cH;
			               println@Console( "recovery step 2" )()
		);
    /* at this line the recovery handler is:
      println@Console( "recovery step 1" )();
      println@Console( "recovery step 2" )()
    */
		println@Console( "step 3" )();
		sleep@Time( 30 )();
		install( this =>
              			cH;
              			println@Console( "recovery step 3" )()
		);
    /* at this line the recovery handler is:
      println@Console( "recovery step 1" )();
      println@Console( "recovery step 2" )();
      println@Console( "recovery step 3" )()
    */

		println@Console( "step 4" )();
		sleep@Time( 40 )();
		install( this =>
              			cH;
              			println@Console( "recovery step 4" )()
		)
    /* at this line the recovery handler is:
      println@Console( "recovery step 1" )();
      println@Console( "recovery step 2" )();
      println@Console( "recovery step 3" )();
      println@Console( "recovery step 4" )()
    */
	}
	|
	sleep@Time( 30 )();
	throw( FaultName )
}
