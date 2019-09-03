/*
The MIT License (MIT)
Copyright (c) 2016 Claudio Guidi <guidiclaudio@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

include "DemoInterface.iol"

include "console.iol"
include "string_utils.iol"

include "config.iol"

execution{ concurrent }

inputPort DEMO {
  Location: "local"
  Protocol: sodep
  Interfaces: DemoInterface
}

init {
      with( global.orders[ 0 ] ) {
        .title = "order0";
        .id = 1;
        .date = "01/01/2001";
        with( .items[ 0 ] ) {
          .name = "itemA";
          .quantity = 2;
          .price = 10.8
        };
        with( .items[ 1 ] ) {
          .name = "itemb";
          .quantity = 3;
          .price = 11.8
        };
        with( .items[ 2 ] ) {
          .name = "itemC";
          .quantity = 3;
          .price = 15.0
        }
      }
      ;
      with( global.orders[ 1 ] ) {
        .title = "order1";
        .id = 2;
        .date = "02/02/2002";
        with( .items[ 0 ] ) {
          .name = "itemA";
          .quantity = 2;
          .price = 10.8
        };
        with( .items[ 1 ] ) {
          .name = "itemb";
          .quantity = 3;
          .price = 11.8
        };
        with( .items[ 2 ] ) {
          .name = "itemC";
          .quantity = 3;
          .price = 15.0
        }
      }
      ;
      with( global.orders[ 2 ] ) {
        .title = "order2";
        .id = 2;
        .date = "03/03/2003";
        with( .items[ 0 ] ) {
          .name = "itemA";
          .quantity = 2;
          .price = 10.8
        };
        with( .items[ 1 ] ) {
          .name = "itemb";
          .quantity = 3;
          .price = 11.8
        };
        with( .items[ 2 ] ) {
          .name = "itemC";
          .quantity = 3;
          .price = 15.0
        }
      }
      println@Console("Demo is runnung...")()
}

main {
  [ getOrders( request )( response ) {
      response.orders -> global.orders
  }]

  [ getOrdersByIItem( request )( response ) {
      if ( request.quantity > 1 ) {
         f.message = "test message"
         f.code = 100
         throw( FaultTest, f )
      }
      response.orders -> global.orders
  }]

  [ putOrder( request )( response ) {
      orders_max = #orders;
      with( orders[ orders_max ] ) {
        .title = request.title;
        .id = orders_max;
        .date = request.date;
        for( i = 0, i < #request.items, i++ ) {
            with( .items[ i ] ) {
              .name = request.items[ i ].name;
              .quantity = request.items[ i ].quantity;
              .price = request.items[ i ].price
            }
        }
      }
  }]

  [ deleteOrder( request )( response ) {
      nullProcess
  }]
}
