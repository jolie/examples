from file import File

service ManagingJsonFiles {
    embed File as File

    main {
        readFile@File( { filename = "starting.json", format = "json" } )( starting_json )
        starting_json.module[ 2 ] << {
            moduleId = "THREE"
            moduleName = "THREE"
            moduleOverview = "THREE"
        }
        writeFile@File({ filename = "final.json", format = "json", content << starting_json } )()
    }
}