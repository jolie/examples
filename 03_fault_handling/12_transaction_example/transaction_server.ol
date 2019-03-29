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
          getProductDetails@ProductStore({ .product = request.product })( product_details );
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
                  with( pr_req ) {
                      .product = request.product;
                      .quantity = request.quantity
                  };
                  lockProduct@ProductStore( pr_req )( pr_res );
                  install( this =>
                      println@Console("unlocking product...")();
                      unlockProduct@ProductStore( { .token = pr_res.token })();
                      println@Console("product unlocking done")()
                  );
                  /* lock logistics delivery time */
                  getCurrentTimeMillis@Time()( now );
                  with( log_req ) {
                      .weight = product_details.weight * request.quantity;
                      .expected_delivery_date = now + 1000*60*60*72; // three days
                      .product = request.product
                  };
                  bookTransportation@Logistics( log_req )( log_res );
                  install( this =>
                      cH;
                      println@Console("cancelling logistics booking..." )();
                      cancelBooking@Logistics({ .reservation_id = log_res.reservation_id } )();
                      println@Console("cancelling logistics booking done")()
                  )
              }
              |
              scope( account ) {
                  /* lock account availability */
                  with( cba ) {
                      .card_number = request.card_number;
                      .amount = request.quantity * product_details.price
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
              confirmBooking@Logistics({ .reservation_id = log_res.reservation_id })()
              |
              commitProduct@ProductStore({ .token = pr_res.token })()
          }
          ;
          response.delivery_date = log_res.actual_delivery_date
    }]
}
