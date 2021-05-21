from file import File

service Example{
    embed File as file 

    main{
        writeFile@file( {
            filename = "test.txt"
            content = "this is a test message"
        } )()
    }
}