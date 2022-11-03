from console import Console
from file import File

type TreeType: void{
  .file: string
  .tab?: string
}

interface TreeInterface {
    RequestResponse: tree( TreeType )( string )
}

service TreeService {
    embed File as File
    inputPort publicIP {
        location: "local"
        Interfaces: TreeInterface
    }
    inputPort selfIP {
        location: "local://A"
        Interfaces: TreeInterface
    }
    outputPort selfOP {
        location: "local://A"
        Interfaces: TreeInterface
    }
    execution: concurrent
    main{
        tree( req )( res ){
            exists@File( req.file )( reqExists );
            if ( reqExists ){
                if( !is_defined( req.tab ) ){
                    res += req.file
                } else {
                    res += req.tab + "├-- " + req.file
                };
                isDirectory@File( req.file )( isDir );
                if ( isDir ){
                    getFileSeparator@File()( sep );
                    lReq.order.byname = true;
                    lReq.directory = req.file;
                    list@File( lReq )( lRes );
                    for (i=0, i < #lRes.result, i++) {
                        bReq.file = req.file + sep + lRes.result[ i ];
                        if( is_defined( req.tab ) ) {
                            bReq.tab = req.tab + "|   "
                        } else {
                            bReq.tab = "    "
                        };

                        /* recursive call */
                        tree@selfOP( bReq )( bRes );
                        res += "\n" + bRes
                    }
                }
            } else {
                res = req.file + " does not exist"
            }
        }
    }
}

service main {
    embed TreeService as TreeInternalService
    embed Console as Console

    main {
        tree@TreeInternalService( { .file = args[0] } )( res );
        println@Console( res )()
    }
}