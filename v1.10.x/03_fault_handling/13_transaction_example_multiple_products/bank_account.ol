include "BankAccountInterface.iol"

include "console.iol"
include "time.iol"

execution{ concurrent }

inputPort BankAccount {
  Location: "socket://localhost:9003"
  Protocol: sodep
  Interfaces: BankAccountInterface
}

init {
     if ( #args == 0 ) { initial_amount = 10000 } else { initial_amount = double( args[0] ) };
     account.( "123456789" ) = initial_amount;
     install( CreditNotPresent => nullProcess )
}

main {
    [ cancelLock( request )( response ) {
        println@Console("Received cancelLock for token " + request.token )();
        synchronized( lock_account ) {
            account.( lock.( request.token ).card_number ) =
                account.( lock.( request.token ).card_number ) + lock.( request.token ).amount;
            undef( lock.( request.token ) )
        }
    }]

    [ commit( request )( response ) {
        println@Console("Received commit for token " + request.token )();
        undef( lock.( request.token ) )
    }]

    [ lockCredit( request )( response ) {
        /* we simulate a delay in the response for allowing installation of termination handlers
        in the transaction service */
        sleep@Time(4000)();
        println@Console("Received lockCredit for card_number " + request.card_number + " for amount " + request.amount )();
        synchronized( lock_account ) {
            if ( account.( request.card_number ) >= request.amount ) {
                response.token = token = new;
                lock.( token ).card_number = request.card_number;
                lock.( token ).amount = request.amount;
                account.( request.card_number ) = account.( request.card_number ) - request.amount
            } else {
                throw( CreditNotPresent )
            }
        }

    }]




}
