include "console.iol"
include "time.iol"

init {
    /* this install disables the interpreter output message in case of FaultName */
    install( FaultName => nullProcess )
}

main
{
	scope ( MainScope )
	{
		install( this =>
			println@Console( "This is the recovery activity for scope_name" )()
		);
    println@Console("I am running inside MainScope...")();
    sleep@Time( 2000 )();
		println@Console( "I am the last activity of operation MainScope" )()
	}
	|
  {
    /* this activity runs in parallel with scope MainScope and after 1000 msec raises fault
       FaultName which triggers a termination fault to the sibling activities (the MainScope) */
    sleep@Time( 1000 )();
    throw( FaultName )
  }
}
