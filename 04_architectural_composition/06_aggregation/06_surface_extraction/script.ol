include "metajolie.iol"
include "metaparser.iol"
include "console.iol"

main {
    getInputPortMetaData@MetaJolie( { .filename = "aggregator.ol" } )( meta_description );
    getSurface@Parser( meta_description.input[ 0 ] )( surface );
    println@Console( surface )()
}
