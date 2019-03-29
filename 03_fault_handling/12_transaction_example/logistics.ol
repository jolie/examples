include "LogisticsInterface.iol"
include "time.iol"
include "console.iol"

execution{ concurrent }

inputPort Logistics {
  Location: "socket://localhost:9002"
  Protocol: sodep
  Interfaces: LogisticsInterface
}

/* this is just a demonstrative service, it  does nto actually implement any logics */
main {
    [ bookTransportation( request )( response ) {
          println@Console("Received a request for booking a transportation")();
          response.reservation_id = token = new;
          getCurrentTimeMillis@Time()( now );
          book.( token ).request_timestamp = now;
          response.actual_delivery_date = now + 1000*60*60*48 // two days
    }]

    [ cancelBooking( request )( response ) {
          println@Console("Received a request for cancelling a booked transportation: " + request.reservation_id )();
          undef( book.( request.reservation_id ) )
    }]

    [ confirmBooking( request )( response ) {
          println@Console("Received a request for a booking confirmation: " + request.reservation_id )();
          undef( book.( request.reservation_id ) )
    }]
}
