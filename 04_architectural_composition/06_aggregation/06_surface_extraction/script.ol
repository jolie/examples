include "metajolie.iol"
include "metaparser.iol"
include "console.iol"

main {
    with( rq ) {
        .filename = "aggregator.ol";
        with( .name ) {
            .name = "Aggregator";
            .domain = ""
        }
    };
    getInputPortMetaData@MetaJolie( rq )( meta_description );
    getSurface@Parser( meta_description.input[ 0 ] )( surface );
    println@Console( surface )()
}
