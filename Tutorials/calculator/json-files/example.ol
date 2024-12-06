from file import File

service ManagingJsonFiles {
    embed File as File

    main {
        readFile@File( { filename = "file.json", format = "json" } )( starting_json )
        starting_json.module[ #starting_json.module ] << {
            moduleId = "NEW"
            moduleName = "NEW"
            moduleOverview = "NEW"
        }
        writeFile@File({ filename = "file.json", format = "json", content << starting_json } )()
    }
}