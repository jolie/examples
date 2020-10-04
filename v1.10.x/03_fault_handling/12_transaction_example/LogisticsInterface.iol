type BookTransportationRequest: void {
    .weight: double
    .expected_delivery_date: long
    .product: string
}
type BookTransportationResponse: void {
    .actual_delivery_date: long
    .reservation_id: string
}

type CancelBookingRequest: void {
    .reservation_id: string
}

type ConfirmBookingRequest: void {
    .reservation_id: string
}

interface LogisticsInterface {
    RequestResponse:
      bookTransportation( BookTransportationRequest )( BookTransportationResponse ),
      cancelBooking( CancelBookingRequest )( void ),
      confirmBooking( ConfirmBookingRequest )( void )
}
