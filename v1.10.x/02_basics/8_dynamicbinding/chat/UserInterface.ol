type SetMessageRequest {
    message: string
    chat_name: string
    username: string
}

interface UserInterface {
  OneWay:
    setMessage( SetMessageRequest )
}
