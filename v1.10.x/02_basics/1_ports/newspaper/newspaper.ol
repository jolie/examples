from NewsPaperInterface import NewsPaperInterface


service NewsPaper {
  execution: concurrent 

  inputPort NewsPaperPort {
    location:"auto:ini:/Locations/NewsPaperPort:file:locations.ini"
    protocol: sodep
    interfaces: NewsPaperInterface
  }

  /*
  the service collects news from authors (by means of operation sendNews).
  users can see news by invoking operation getNews.
  News are stored into a global variable called news */
  main {
      [ getNews( request )( response ) {
          response.news -> global.news
      }]

      [ sendNews( request ) ] { global.news[ #global.news ] << request }
  }
}
