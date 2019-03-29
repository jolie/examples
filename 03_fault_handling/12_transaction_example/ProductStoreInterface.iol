type CommitProductRequest: void {
    .token: string
}
type CommitProductResponse: void

type GetProductDetailsRequest: void {
    .product: string
}
type GetProductDetailsResponse: void {
    .weight: double
    .price: double
}

type LockProductRequest: void {
    .product: string
    .quantity: int
}
type LockProductResponse: void {
    .token: string
}

type UnlockProductRequest: void {
    .token: string
}

interface ProductStoreInterface {
    RequestResponse:
        getProductDetails( GetProductDetailsRequest )( GetProductDetailsResponse ),
        commitProduct( CommitProductRequest )( CommitProductResponse ),
        lockProduct( LockProductRequest )( LockProductResponse ) throws ProductNotAvailable,
        unlockProduct( UnlockProductRequest )( void )
}
