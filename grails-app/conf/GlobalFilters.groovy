import com.bjrxht.declare.Declare

class GlobalFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
               if(!session.getAttribute("declareRenderingUri")){
                   def uri="";
                   def serverName=request.getServerName().toLowerCase();
                   //@done, 去数据库比对，取出uri
                   uri=Declare.findByDomainName(serverName).code;
                   session.setAttribute("declareRenderingUri",uri);
               }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
