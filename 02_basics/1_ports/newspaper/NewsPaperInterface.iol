type News: void {
    .category: string
    .title: string
    .text: string
    .author: string
}

type GetNewsResponse: void {
    .news*: News
}

type SendNewsRequest: News

interface NewsPaperInterface {
  RequestResponse:
      getNews( void )( GetNewsResponse )

  OneWay:
      sendNews( SendNewsRequest )
}
