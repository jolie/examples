type AddChatRequest {
    chat_name: string
    username: string
    location: string
}
type AddChatResponse {
    token: string
}

type ChatSendMessageRequest {
    token: string
    message: string
}

interface ChatRegistryInterface {
  RequestResponse:
    addChat( AddChatRequest )( AddChatResponse ),
    sendMessage( ChatSendMessageRequest )( void ) throws TokenNotValid
}
