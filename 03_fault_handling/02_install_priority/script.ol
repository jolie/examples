include "console.iol"

main {
  /* install primitive is always executed with priority */
  scope( s )
    {
    	throw( MyFault )
      |
      /* it can never happen that other parallel activities are executed before the install */
      install( MyFault => println@Console( "Fault caught!" )()	)
    }
}
