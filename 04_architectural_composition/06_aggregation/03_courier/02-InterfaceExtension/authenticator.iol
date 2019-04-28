type CheckKeyRequest: void {
  .key: string
}
type CheckKeyResponse: void

type GetKeyRequest: void {
  .credentials: void {
      .username: string
      .password: string
  }
}
type GetKeyResponse: void {
  .key: string
}

interface AuthenticatorInterface {
  RequestResponse:
    checkKey( CheckKeyRequest )( CheckKeyResponse ) throws KeyNotValid,
    getKey( GetKeyRequest )( GetKeyResponse )
}
