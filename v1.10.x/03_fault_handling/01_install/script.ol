include "console.iol"

main
{
  registerForInput@Console()();
	install( WrongNumberFault =>
    /* this fault handler will be executed last */
		println@Console( "A wrong number has been inserted!" )()
	);

  /* number to guess */
	secret = 3;

	scope( num_scope )
	{
		install(
      /* this fault handler will be executed first, then the fault will be re-thrown */
			WrongNumberFault =>
				println@Console( "Wrong!" )();
				throw( WrongNumberFault )
		);

		print@Console( "Insert a number: " )();
    in( number );
		if ( number == secret ) {
			println@Console("OK!")()
		} else {
      /* here the fault is thrown */
			throw( WrongNumberFault )
		}
	}
}
