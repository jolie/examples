include "console.iol"
include "time.iol"

init {
    /* this install disables the interpreter output message in case of FaultName */
    install( FaultName => nullProcess )
}

main
{
	scope( grandFather )	{
		install( this => println@Console( "recovering grandFather" )() )
    ;
		scope( father ) {
			install( this => println@Console( "recovering father" )() )
      ;
			scope ( son ) {
				install( this =>	println@Console( "recovering son" )() )
        ;
				sleep@Time( 500 )();
				println@Console( "Son's code block" )()
			}
		}
	}
	|
	throw( FaultName )
}
