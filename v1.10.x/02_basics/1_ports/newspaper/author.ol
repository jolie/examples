from NewsPaperInterface import NewsPaperInterface
from console import Console
from console import ConsoleInputInterface

service AuthorClient {

  embed Console as Console

  inputPort ConsoleInput {
    location: "local"
    Interfaces: ConsoleInputInterface
  }

  outputPort NewsPaper {
    location: "socket://localhost:9000"
    protocol: sodep
    interfaces: NewsPaperInterface
  }

  main {
      /* in order to get parameters from the console we need to register the service to the console one
      by using the operatio registerForInput. After this, we are enabled to receive messages from the console
      on input operation in (defined in console.iol)*/
      registerForInput@Console()();
      print@Console("Insert category:")(); in( request.category );
      print@Console("Insert title:")(); in( request.title );
      print@Console("Insert news text:")(); in( request.text );
      print@Console("Insert your name:")(); in( request.author );
      sendNews@NewsPaper( request );
      println@Console("The news has been sent to the newspaper")()
  }
}
