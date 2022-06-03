from CleanBrInterface import CleanBrInterface
from CleanDivInterface import CleanDivInterface
from string_utils import StringUtils
from clean_br import CleanBr

service CleanDiv {

    execution: concurrent

    outputPort CleanBr {
      Interfaces: CleanBrInterface
    }

    embed StringUtils as StringUtils
    embed CleanBr in CleanBr

    inputPort CleanDiv {
      Location: "socket://localhost:9000"
      Protocol: sodep
      Interfaces: CleanDivInterface
    }

    main {
        cleanDiv( request )( response ) {
            replaceAll@StringUtils( request { regex="<div>", replacement="" })( request )
            replaceAll@StringUtils( request { regex="</div>", replacement="\n" })( request )
            cleanBr@CleanBr( request )( response )
        }
    }
}
