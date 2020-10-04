type DeleteOrderRequest:void {
  .orderId[1,1]:int
}

type DeleteOrderResponse:void

type FaultTestType:void {
  .code[1,1]:int
  .message[1,1]:string
}

type GetOrdersByItemRequest:void {
  .itemName[1,1]:string
  .quantity[1,1]:int
  .userId[1,1]:string
}|void {
  .itemName[1,1]:string
  .userId[1,1]:string
}

type GetOrdersByItemResponse:Orders

type GetOrdersRequest:void {
  .maxItems[1,1]:int
  .userId[1,1]:string
}

type GetOrdersResponse:Orders

type Order:void {
  .date[1,1]:string
  .id[0,1]:int
  .title[1,1]:string
  .items[0,*]:OrderItem
}

type OrderItem:void {
  .quantity[1,1]:int
  .price[1,1]:double
  .name[1,1]:string
}

type Orders:void {
  .orders[0,*]:Order
}

type PutOrderRequest:void {
  .userId[1,1]:string
  .order[1,1]:Order
}

type PutOrderResponse:void

interface DEMOInterface {
RequestResponse:
  deleteOrder( DeleteOrderRequest )( DeleteOrderResponse ),
  getOrders( GetOrdersRequest )( GetOrdersResponse ),
  getOrdersByItem( GetOrdersByItemRequest )( GetOrdersByItemResponse ) throws FaultTest(FaultTestType)  ,
  putOrder( PutOrderRequest )( PutOrderResponse )
}



outputPort DEMO {
  Protocol:sodep
  Location:"local"
  Interfaces:DEMOInterface
}


embedded { Jolie: "demo.ol" in DEMO }
