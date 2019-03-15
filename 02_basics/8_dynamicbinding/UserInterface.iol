type SetMessageRequest: void {
    .message: string
    .chat_name: string
    .username: string
}

interface UserInterface {
  OneWay:
    setMessage( SetMessageRequest )
}
