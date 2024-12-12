from mustache import Mustache
from file import File
from console import Console

service MustacheTutorial {

    embed File as File
    embed Mustache as Mustache
    embed Console as Console


    main {

        readFile@File( { filename = "template.mustache" } )( template )
        render_req << {
            template = template
            data << {
                applicationName = "Task Manager"
                version = "1.0.0"
                description = "A simple application for managing tasks and projects."
                author << {
                    name = "Jane Doe"
                    email = "jane.doe@example.com"
                }
                configuration << {
                    environment = "production"
                    port = 8080
                    database << {
                        host = "localhost"
                        port = 5432
                        name = "task_manager_db"
                        user = "admin"
                        password = "securepassword"
                    }
                }
                features[ 0 ] << {
                    name = "Task Management"
                    enabled = true
                }
                features[ 1 ] << {
                    name = "Notifications"
                    enabled = false
                }
                features[ 2 ] << {
                    name = "Reporting"
                    enabled = true
                    last = true 
                }
            }
        }
        println@Console( render@Mustache( render_req ) )()
    }
}
 
