include "ProductStoreInterface.iol"

include "console.iol"

execution{ concurrent }

inputPort ProductStore {
  Location: "socket://localhost:9001"
  Protocol: sodep
  Interfaces: ProductStoreInterface
}

init {
    global.product_storage_size = 1000;
    product_catalog.( "beer" ) << {
        .weight = 0.350,
        .price = 1.3
    };
    product_catalog.( "water" ) << {
        .weight = 1.0,
        .price = 1.0
    };
    product_catalog.( "wine" ) << {
        .weight = 1.2,
        .price = 10.5
    }
}

main {
    [ commitProduct( request )( response ) {
        undef( global.lock.( request.token ) )
    }]

    [ getProductDetails( request )( response ) {
        response.weight = product_catalog.( request.product ).weight;
        response.price = product_catalog.( request.product ).price
    }]

    [ lockProduct( request )( response ) {
        println@Console("Received a request for locking product " + request.product )();
        synchronized( get_lock ) {
            if ( request.quantity <= global.product_storage_size ) {
                response.token = token = new;
                global.lock.( token ).size = request.quantity;
                global.product_storage_size = global.product_storage_size - request.quantity
            } else {
                throw( ProductNotAvailable )
            }
        }
    }]

    [ unlockProduct( request )( response ) {
        println@Console("Received a request for unlocking token " + request.token )();
        if ( is_defined( global.lock.( request.token ) ) ) {
            synchronized( get_lock ) {
                global.product_storage_size = global.product_storage_size + global.lock.( request.token ).size;
                undef( global.lock.( request.token ) )
            }
        }
    }]
}
