include "NewsPaperInterface.iol"

execution{ concurrent }

inputPort NewsPaperPort {
  Location:"auto:ini:/Locations/NewsPaperPort:file:locations.ini"
  Protocol: sodep
  Interfaces: NewsPaperInterface
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
