type BuyRequest: void {
    .product: string
    .quantity: int
    .card_number: string
    .user_id: string
    .max_delivery_date: long
}
type BuyResponse: void {
    .delivery_date: long
}

interface TransactionServerInterface {
  RequestResponse:
    buy( BuyRequest )( BuyResponse ) throws TransactionFailure( string )
}
