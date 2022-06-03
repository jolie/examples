from CleanBrInterface import CleanBrInterface
from string_utils import StringUtils


service CleanBr {
  execution: concurrent 

  embed StringUtils as StringUtils

  inputPort CleanBr {
    Location: "local"
    Protocol: sodep
    Interfaces: CleanBrInterface
  }

  main {
      cleanBr( request )( response ) {
          replaceAll@StringUtils( request { regex="<br>", replacement="\n" })( request )
          replaceAll@StringUtils( request { regex="</br>", replacement="\n" })( response )
      }
  }
}
