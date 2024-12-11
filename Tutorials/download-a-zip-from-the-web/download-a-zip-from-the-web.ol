
from database import Database
from file import File
from zip-utils import ZipUtils
from console import Console

interface ApacheDerbyDownloadInterface {
    RequestResponse:
        downloadDerby
}

constants {
    DOWNLOADED_ZIP = "tmp.zip",
    TARGET_PATH_UNZIP = "./unzip"
}

/*
    Downloading db derby 10.14 from https://db.apache.org/derby/ and extracting derby.jar
*/
service Main {

    embed Database as Database
    embed File as File
    embed ZipUtils as ZipUtils
    embed Console as Console

    outputPort ApacheDerby1_10_14 {
        location: "socket://archive.apache.org:443/dist/db/derby/db-derby-10.14.2.0/"
        protocol: https {
            .osc.downloadDerby.alias = "db-derby-10.14.2.0-lib.zip"
            .osc.downloadDerby.method = "get"
        }
        interfaces: ApacheDerbyDownloadInterface
    }


   main {
        
        println@Console("Downloading lib file from apache.org...")()
        downloadDerby@ApacheDerby1_10_14()( derby )
        println@Console("Done.")()
        writeFile@File( { filename = DOWNLOADED_ZIP, content << derby } )()
        println@Console("Unzipping downloaded file...")()
        unzip@ZipUtils( { filename = DOWNLOADED_ZIP, targetPath = TARGET_PATH_UNZIP} )()
        println@Console("Done.")()
        derbyDbJarFilename = TARGET_PATH_UNZIP + "/db-derby-10.14.2.0-lib/lib/derby.jar"

        println@Console("Extracting derby.jar...")()
        readFile@File( { filename = derbyDbJarFilename, format = "binary" } )( derbyJar )
        writeFile@File( { filename = "derby.jar", format = "binary", content << derbyJar })()
        println@Console("Done.")()
        
        delete@File( DOWNLOADED_ZIP )()
        deleteDir@File( TARGET_PATH_UNZIP )()
        
    }
}