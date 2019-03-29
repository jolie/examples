type CancelLockRequest: void {
    .token: string
}

type CommitAmountRequest: void {
    .token: string
}

type LockCreditRequest: void {
    .card_number: string
    .amount: double
}
type LockCreditResponse: void {
    .token: string
}

interface BankAccountInterface {
    RequestResponse:
        lockCredit( LockCreditRequest )( LockCreditResponse ) throws CreditNotPresent,
        cancelLock( CancelLockRequest )( void ),
        commit( CommitAmountRequest )( void )
}
