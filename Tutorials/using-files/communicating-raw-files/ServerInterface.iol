type SetFileRequest: void {
    .content: raw
}

interface ServerInterface {
    RequestResponse:
        setFile( SetFileRequest )( void )
}