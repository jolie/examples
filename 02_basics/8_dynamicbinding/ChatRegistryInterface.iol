type AddChatRequest: void {
    .chat_name: string
    .username: string
    .location: string
}
type AddChatResponse: void {
    .token: string
}

type ChatSendMessageRequest: void {
    .token: string
    .message: string
}

interface ChatRegistryInterface {
  RequestResponse:
    addChat( AddChatRequest )( AddChatResponse ),
    sendMessage( ChatSendMessageRequest )( void ) throws TokenNotValid
}
