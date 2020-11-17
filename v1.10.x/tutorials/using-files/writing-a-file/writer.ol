include "file.iol"

main {
    with( request ) {
        .filename = "test.txt";
        .content = "this is a test message"
    }
    writeFile@File( request )()
}