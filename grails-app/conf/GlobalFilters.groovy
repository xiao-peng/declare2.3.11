class GlobalFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
               if(!request.getAttribute("declareRenderingUri")){
                   def uri="";
                   def serverName=request.getServerName().toLowerCase();
                   //@todo, 去数据库比对，取出uri
                   request.setAttribute("declareRenderingUri",uri);
               }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
