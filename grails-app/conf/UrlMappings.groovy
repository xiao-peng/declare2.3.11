class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/" {
            controller="workspace"
            action="index"
        }
        //"/"(view:"/index")
        "403"	(view:'/_errors/403')
        "404"	(view:'/_errors/404')
        "500"	(view:'/_errors/error')
        "503"	(view:'/_errors/503')
	}
}
