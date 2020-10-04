include "TransactionServerInterface.iol"
include "time.iol"

outputPort TransactionServer {
    Location: "socket://localhost:9000"
    Protocol: sodep
    Interfaces: TransactionServerInterface
}

main {
   getCurrentTimeMillis@Time()( now );
   with( buy_req ) {
     .product[ 0 ]  = "beer";
     .product[ 0 ].quantity = 10;
     .product[ 1 ]  = "water";
     .product[ 1 ].quantity = 10;
     .product[ 2 ]  = "wine";
     .product[ 2 ].quantity = 10;
     .card_number = "123456789";
     .user_id = "homersimpsons";
     .max_delivery_date = now + 1000*60*60*48
   };
   buy@TransactionServer( buy_req )()

}
