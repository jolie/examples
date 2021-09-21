from RegisterInterface import RegisterInterface
from time import Time


service Register {

	execution: concurrent

	embed Time as Time 

	inputPort Register {
		location: "socket://localhost:2000"
		protocol: sodep
		interfaces: RegisterInterface	
	}

	init
	{
		global.registered_users=0;
		response.message = "Successful registration.\nYou are the user number "
	}

	main
	{
		register()( response ){
			/* the synchronized section allows to access syncToken scope in mutual exclusion */
			synchronized( syncToken ) {
				response.message = response.message + ++global.registered_users;
				sleep@Time( 2000 )()
			}
		}
	}
}
