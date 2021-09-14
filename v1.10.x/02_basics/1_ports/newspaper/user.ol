from NewsPaperInterface import NewsPaperInterface
from console import Console


service UserClient {

  embed Console as Console
  outputPort NewsPaper {
    location: "socket://localhost:9000"
    protocol: sodep
    interfaces: NewsPaperInterface
  }

  main {
      getNews@NewsPaper()( response );
      for( i = 0, i < #response.news, i++ ) {
          println@Console( "CATEGORY: " + response.news[ i ].category )();
          println@Console( "TITLE: " + response.news[ i ].title )();
          println@Console( "TEXT: " + response.news[ i ].text )();
          println@Console( "AUTHOR: " + response.news[ i ].author )();
          println@Console("------------------------------------------")()
      }
  }
}
