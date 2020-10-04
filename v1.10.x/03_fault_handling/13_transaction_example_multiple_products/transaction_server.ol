include "TransactionServerInterface.iol"
include "ProductStoreInterface.iol"
include "LogisticsInterface.iol"
include "BankAccountInterface.iol"

include "time.iol"
include "console.iol"
include "string_utils.iol"

execution{ concurrent }

outputPort BankAccount {
  Location: "socket://localhost:9003"
  Protocol: sodep
  Interfaces: BankAccountInterface
}

outputPort Logistics {
  Location: "socket://localhost:9002"
  Protocol: sodep
  Interfaces: LogisticsInterface
}

outputPort ProductStore {
  Location: "socket://localhost:9001"
  Protocol: sodep
  Interfaces: ProductStoreInterface
}

inputPort TransactionServer {
  Location: "socket://localhost:9000"
  Protocol: sodep
  Interfaces: TransactionServerInterface
}

init {
    install( TransactionFailure => nullProcess )
}
/* WARN: this is just a demonstrative example.
Transactions here are simplified in order to show language mechanisms */

main {
    [ buy( request )( response ) {
          for ( i = 0, i < #request.product, i++ ) {
               getProductDetails@ProductStore({ .product = request.product[ i ] })( product_details );
               products.( request.product[ i ] ) << product_details
          };
          scope( locks ) {
              install( default =>
                    { comp( lock_product ) | comp( account ) }
                    ;
                    valueToPrettyString@StringUtils( locks.( locks.default ) )( s );
                    msg_failure = "ERROR: " + locks.default + "," + s;
                    throw( TransactionFailure, msg_failure )
              );
              scope( lock_product ) {
                  /* lock product availability */
                  for( i = 0, i < #request.product, i++ ) {
                        println@Console("processing product " + request.product[ i ] )();
                        with( pr_req ) {
                            .product = request.product[ i ];
                            .quantity = request.product[ i ].quantity
                        };
                        println@Console("locking " + request.product[ i ])();
                        lockProduct@ProductStore( pr_req )( pr_res );
                        token = product.( request.product[ i ]).token = pr_res.token ;
                        install( this =>
                            cH;
                            println@Console("unlocking product " + request.product[ ^i ] )();
                            unlockProduct@ProductStore( { .token = ^token })()
                        );
                        /* lock logistics delivery time */
                        getCurrentTimeMillis@Time()( now );
                        with( log_req ) {
                            .weight = products.( request.product[ i ] ).weight * request.product[ i ].quantity;
                            .expected_delivery_date = now + 1000*60*60*72; // three days
                            .product = request.product[ i ]
                        };
                        bookTransportation@Logistics( log_req )( log_res );
                        reservation_id = product.( request.product[ i ]).reservation_id = log_res.reservation_id;
                        install( this =>
                            cH;
                            println@Console("cancelling logistics booking for product " + request.product[ ^i ] )();
                            cancelBooking@Logistics({ .reservation_id = ^reservation_id } )()
                        )
                  }
              }
              |
              scope( account ) {
                  /* lock account availability */
                  for( y = 0, y < #request.product, y++ ) {
                      amount = amount + request.product[ y ].quantity * products.( request.product[ y ] ).price
                  };
                  with( cba ) {
                      .card_number = request.card_number;
                      .amount = amount
                  };
                  lockCredit@BankAccount( cba )( lock_credit );
                  install( this =>
                      println@Console("cancelling account lock..")();
                      cancelLock@BankAccount( { .token = lock_credit.token })();
                      println@Console("cancelling account lock done")()
                  )
              }
          }
          ;
          /* commit */
          {
              commit@BankAccount({ .token = lock_credit.token })()
              |
              {
                  foreach( pr : product ) {
                      confirmBooking@Logistics({ .reservation_id = product.( pr ).reservation_id })()
                      |
                      commitProduct@ProductStore({ .token = product.( pr ).token })()
                  }
              }
          }
          ;
          response.delivery_date = log_res.actual_delivery_date
    }]
}
